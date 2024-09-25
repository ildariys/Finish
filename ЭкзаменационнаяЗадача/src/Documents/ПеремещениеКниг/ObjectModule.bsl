
Процедура ОбработкаПроведения(Отказ, Режим)


	Движения.БронированиеТоваров.Записывать = Истина;
	Движения.БронированиеТоваров.Очистить();
	Движения.БронированиеТоваров.Записать();
	
	// регистр ОстаткиНоменклатуры Приход
	Движения.ОстаткиНоменклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаСписокПеремещаемыхКниг Из СписокПеремещаемыхКниг Цикл
		Движение = Движения.ОстаткиНоменклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Склад = СкладПриема;
		Движение.Книга = ТекСтрокаСписокПеремещаемыхКниг.Книга;
		Движение.Количество = ТекСтрокаСписокПеремещаемыхКниг.Количество;
	КонецЦикла;

	// регистр ОстаткиНоменклатуры Расход
	Движения.ОстаткиНоменклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаСписокПеремещаемыхКниг Из СписокПеремещаемыхКниг Цикл
		Движение = Движения.ОстаткиНоменклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Склад = СкладОтправки;
		Движение.Книга = ТекСтрокаСписокПеремещаемыхКниг.Книга;
		Движение.Количество = ТекСтрокаСписокПеремещаемыхКниг.Количество;
	КонецЦикла;

КонецПроцедуры
// @strict-types


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
