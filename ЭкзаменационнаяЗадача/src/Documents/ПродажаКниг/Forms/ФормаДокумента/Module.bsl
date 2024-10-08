#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Ключ.Пустая() Тогда

		Объект.Оператор = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийПользователь();
		Объект.Склад = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийМагазин();

	КонецЕсли;
	Если РольДоступна("Администратор") Тогда

		Элементы.Склад.ТолькоПросмотр = Ложь;

	КонецЕсли;

КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокКниг

&НаКлиенте
Процедура СписокКнигКнигаПриИзменении(Элемент)

	Элементы.СписокКниг.ТекущиеДанные.Количество = 1;
	ДанныеСтроки = Элементы.СписокКниг.ТекущиеДанные;
	ОбработкаТабличныхЧастейКлиент.РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки);
	РасчетСуммыТЧ();

КонецПроцедуры

&НаКлиенте
Процедура СписокКнигКоличествоПриИзменении(Элемент)

	ДанныеСтроки = Элементы.СписокКниг.ТекущиеДанные;
	ОбработкаТабличныхЧастейКлиент.РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки);
	РасчетСуммыТЧ();

КонецПроцедуры

&НаКлиенте
Процедура СписокКнигЦенаПриИзменении(Элемент)

	ДанныеСтроки = Элементы.СписокКниг.ТекущиеДанные;
	ОбработкаТабличныхЧастейКлиент.РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки);
	РасчетСуммыТЧ();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДобавитьКниги(Команда)

	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбора", ЭтотОбъект);
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Склад", Объект.Склад);
	ОткрытьФорму("Документ.ПеремещениеКниг.Форма.ФормаВыбораДоступныхКниг", ПараметрыФормы, , , , , ОписаниеОповещения);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора) Экспорт

	Если ВыбранноеЗначение = Неопределено Тогда

		Возврат;
	КонецЕсли;

	Для Каждого ТекущаяСтрока Из ВыбранноеЗначение Цикл

		Отбор = Новый Структура("Книга", ТекущаяСтрока.Книга);
		НайденныеЭлементы = Объект.СписокКниг.НайтиСтроки(Отбор);

		Если НайденныеЭлементы.Количество() > 0 Тогда

			Продолжить;
		КонецЕсли;

		НоваяСтрока = Объект.СписокКниг.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ТекущаяСтрока);
	КонецЦикла;

	Для Каждого ТекущаяСтрока Из Объект.СписокКниг Цикл

		ТекущаяСтрока.Сумма = ТекущаяСтрока.Количество * ТекущаяСтрока.Цена;
	КонецЦикла;

	РасчетСуммыТЧ();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РасчетСуммыТЧ()
	;
	
	Объект.Сумма = Объект.СписокКниг.Итог("Сумма");

КонецПроцедуры

#КонецОбласти