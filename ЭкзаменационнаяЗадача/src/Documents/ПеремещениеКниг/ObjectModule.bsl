
Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ОстаткиНомеклатуры Приход
	Движения.ОстаткиНомеклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаСписокПеремещаемыхКниг Из СписокПеремещаемыхКниг Цикл
		Движение = Движения.ОстаткиНомеклатуры.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Склад = СкладПриема;
		Движение.Книга = ТекСтрокаСписокПеремещаемыхКниг.Книга;
		Движение.Количество = ТекСтрокаСписокПеремещаемыхКниг.Количество;
	КонецЦикла;

	// регистр ОстаткиНомеклатуры Расход
	Движения.ОстаткиНомеклатуры.Записывать = Истина;
	Для Каждого ТекСтрокаСписокПеремещаемыхКниг Из СписокПеремещаемыхКниг Цикл
		Движение = Движения.ОстаткиНомеклатуры.Добавить();
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
