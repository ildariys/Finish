#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПоступлениеКниг.Дата КАК Дата,
	|	ПоступлениеКниг.Поставщик КАК Поставщик,
	|	ПоступлениеКниг.Сумма КАК Сумма,
	|	ПоступлениеКниг.Ссылка КАК Документ
	|ИЗ
	|	Документ.ПоступлениеКниг КАК ПоступлениеКниг
	|ГДЕ
	|	ПоступлениеКниг.Склад = &Склад
	|	И ПоступлениеКниг.Проведен
	|	И НЕ ПоступлениеКниг.Ссылка В
	|		(ВЫБРАТЬ
	|			ОплаченныеПоступления.Поступление КАК Поступление
	|		ИЗ
	|			РегистрНакопления.ОплаченныеПоступления КАК ОплаченныеПоступления)
	|	И ПоступлениеКниг.Поставщик = &Поставщик";

	Запрос.УстановитьПараметр("Склад", Параметры.Склад);
	Запрос.УстановитьПараметр("Поставщик", Параметры.Контрагент);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		НоваяСтрока = НеОплаченныеДокументы.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ВыборкаДетальныеЗаписи);
	КонецЦикла;
	
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Выбрать(Команда)
	Выбор = Новый Массив;

	Для Каждого ТекущаяСтрока Из НеОплаченныеДокументы Цикл
		Если ТекущаяСтрока.Выбрать Тогда
			Выбор.Добавить(ТекущаяСтрока);
		КонецЕсли;

	КонецЦикла;

	ОповеститьОВыборе(Выбор);

КонецПроцедуры
#КонецОбласти