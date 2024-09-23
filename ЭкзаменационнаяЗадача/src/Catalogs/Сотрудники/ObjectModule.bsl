
// @strict-types
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс
#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Записать = Истина;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Сотрудники.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Сотрудники КАК Сотрудники
	|ГДЕ
	|	Сотрудники.ИНН = &ИНН
	|	И Сотрудники.Ссылка <> &Ссылка";

	Запрос.УстановитьПараметр("ИНН", ИНН);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);

	РезультатЗапроса = Запрос.Выполнить();

	Если Не РезультатЗапроса.Пустой() Тогда
		Записать = Ложь;
	КонецЕсли;

	Если Не Записать Тогда

		Сообщить("Запись с таким ИНН уже существует!");
		Отказ = Истина;

	КонецЕсли;

КонецПроцедуры

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