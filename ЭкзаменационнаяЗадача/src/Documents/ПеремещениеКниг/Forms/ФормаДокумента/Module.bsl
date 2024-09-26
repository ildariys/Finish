#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Ключ.Пустая() Тогда

		Объект.Ответственный = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийПользователь();
		Объект.СкладОтправки = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийМагазин();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьКниги(Команда)

	ОписаниеОповещения 				= Новый ОписаниеОповещения("ОбработкаВыбора", ЭтотОбъект);
	ПараметрыФормы 	= Новый Структура("Склад", Объект.СкладОтправки);
	ОткрытьФорму("Документ.ПеремещениеКниг.Форма.ФормаВыбораДоступныхКниг", ПараметрыФормы, , , , , ОписаниеОповещения);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора) Экспорт

	Если ВыбранноеЗначение = Неопределено Тогда

		Возврат;

	КонецЕсли;
	Для Каждого ТекущаяСтрока Из ВыбранноеЗначение Цикл

		Отбор 				= Новый Структура("Книга", ТекущаяСтрока.Книга);
		НайденныеЭлементы 	= Объект.СписокКниг.НайтиСтроки(Отбор);

		Если НайденныеЭлементы.Количество() > 0 Тогда

			Продолжить;
		КонецЕсли;
		НоваяСтрока = Объект.СписокКниг.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекущаяСтрока);
	КонецЦикла;
КонецПроцедуры
#КонецОбласти