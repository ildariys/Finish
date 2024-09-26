//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область СлужебныйПрограммныйИнтерфейс

#Область ФиксацияОшибокВРезультате

// Регистрирует ошибку обработки события исполнения тестов
//
// Параметры:
//  ИмяСобытия - Строка
//  ОписаниеСобытия - см. ЮТФабрикаСлужебный.ОписаниеСобытияИсполненияТестов
//  Ошибка - ИнформацияОбОшибке
//         - Строка
Процедура ЗарегистрироватьОшибкуСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибка) Экспорт
	
	ТипОшибки = ЮТФабрикаСлужебный.ТипыОшибок().ОшибкаОбработкиСобытия;
	Пояснение = ЮТСообщенияСлужебный.СообщениеОбОшибкеСобытия(ИмяСобытия, Ошибка);
	ДанныеОшибки = ДанныеОшибки(Ошибка, Пояснение, ТипОшибки);
	
	Если ОписаниеСобытия.Тест <> Неопределено Тогда
		Объект = ОписаниеСобытия.Тест;
	ИначеЕсли ОписаниеСобытия.Набор <> Неопределено Тогда
		Объект = ОписаниеСобытия.Набор;
	Иначе
		Объект = ОписаниеСобытия.Модуль;
	КонецЕсли;
	
	Объект.Ошибки.Добавить(ДанныеОшибки);
	
КонецПроцедуры

// Регистрирует ошибку загрузки тестов
//
// Параметры:
//  Объект - Структура - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля или см. ЮТФабрикаСлужебный.ОписаниеТестовогоНабора или см. ЮТФабрикаСлужебный.ОписаниеТеста
//  Описание - Строка - Описания ошибки, места возникновения
//  Ошибка - ИнформацияОбОшибке
Процедура ЗарегистрироватьОшибкуЧтенияТестов(Объект, Описание, Ошибка) Экспорт
	
	ДанныеОшибки = ДанныеОшибки(Ошибка, Описание, ЮТФабрикаСлужебный.ТипыОшибок().ЧтенияТестов);
	Объект.Ошибки.Добавить(ДанныеОшибки);
	
КонецПроцедуры

// Регистрирует ошибку выполнения теста
// Параметры:
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
//  Ошибка - ИнформацияОбОшибке
Процедура ЗарегистрироватьОшибкуВыполненияТеста(Тест, Ошибка) Экспорт
	
	ТипОшибки = ТипОшибки(Ошибка, Тест.ПолноеИмяМетода);
	
	Если ТипОшибки = ЮТФабрикаСлужебный.ТипыОшибок().Утверждений Тогда
		ДанныеОшибки = ДанныеОшибкиУтверждений(Ошибка);
	ИначеЕсли ТипОшибки = ЮТФабрикаСлужебный.ТипыОшибок().Пропущен Тогда
		ДанныеОшибки = ДанныеОшибкиПропуска(Ошибка);
	Иначе
		ДанныеОшибки = ДанныеОшибки(Ошибка, ЮТСообщенияСлужебный.КраткоеСообщениеОшибки(Ошибка), ТипОшибки);
	КонецЕсли;
	
	Тест.Ошибки.Добавить(ДанныеОшибки);
	
КонецПроцедуры

// Регистрирует ошибку выполнения теста
// Параметры:
//  Объект - см. ЮТФабрика.ОписаниеИсполняемогоТеста
//  Сообщение - Строка
Процедура ЗарегистрироватьПростуюОшибкуВыполнения(Объект, Сообщение) Экспорт
	
	ДанныеОшибки = ДанныеОшибки(Неопределено, Сообщение, ЮТФабрикаСлужебный.ТипыОшибок().Исполнения);
	Объект.Ошибки.Добавить(ДанныеОшибки);
	ЮТЛогирование.Ошибка(Сообщение);
	
КонецПроцедуры

// Регистрирует ошибку режима выполнения теста
// Параметры:
//  Объект - см. ЮТФабрика.ОписаниеИсполняемогоТеста
//  Ошибка - Строка
Процедура ЗарегистрироватьОшибкуРежимаВыполнения(Объект, Ошибка) Экспорт
	
	ДанныеОшибки = ДанныеОшибки(Неопределено, Ошибка, ЮТФабрикаСлужебный.ТипыОшибок().НекорректныйКонтекстИсполнения);
	Объект.Ошибки.Добавить(ДанныеОшибки);
	
КонецПроцедуры

#КонецОбласти

// Вызывает ошибку выполнения теста, на основании перехваченной ошибки
//
// Параметры:
//  ИнформацияОбОшибке - ИнформацияОбОшибке
//  ОписаниеПроверки - см. ЮТФабрикаСлужебный.ОписаниеПроверки
Процедура СгенерироватьОшибкуВыполнения(ИнформацияОбОшибке, ОписаниеПроверки = Неопределено) Экспорт
	
	СтруктураОшибки = КонтекстОшибки();
	СтруктураОшибки.ОшибкаУтверждения = Ложь;
	
	ВызватьОшибкуИсполнения(ИнформацияОбОшибке, ОписаниеПроверки);
	
КонецПроцедуры

// Вызывает ошибку сравнения значений
// При этом сохраняет в контекст состояние, для дальнейшей обработки
//
// Параметры:
//  ОписаниеПроверки - см. ЮТФабрикаСлужебный.ОписаниеПроверки
//  Сообщение - Строка
//  ПроверяемоеЗначение - Произвольный
//  ОжидаемоеЗначение - Произвольный
//  ОбъектПроверки - Строка - Человекочитаемое описание проверяемого значения
Процедура СгенерироватьОшибкуСравнения(ОписаниеПроверки,
									   Сообщение,
									   ПроверяемоеЗначение,
									   ОжидаемоеЗначение,
									   ОбъектПроверки = "проверяемое значение") Экспорт
	
	УстановитьДанныеОшибкиСравнения(ПроверяемоеЗначение, ОжидаемоеЗначение);
	ТекстСообщения = ЮТСообщенияСлужебный.ФорматированныйТекстОшибкиУтверждения(ОписаниеПроверки, Сообщение, ОбъектПроверки);
	ВызватьОшибкуПроверки(ТекстСообщения, ОписаниеПроверки);
	
КонецПроцедуры

// Вызывает ошибку проверки утверждений
// При этом сохраняет в контекст состояние, для дальнейшей обработки
//
// Параметры:
//  ОписаниеПроверки - см. ЮТФабрикаСлужебный.ОписаниеПроверки
//  Сообщение - Строка
//  ПроверяемоеЗначение - Произвольный
//  ОбъектПроверки - Строка - Человекочитаемое описание проверяемого значения
Процедура СгенерироватьОшибкуУтверждения(ОписаниеПроверки, Сообщение, ПроверяемоеЗначение, ОбъектПроверки = "проверяемое значение") Экспорт
	
	УстановитьДанныеОшибкиУтверждения(ПроверяемоеЗначение);
	ТекстСообщения = ЮТСообщенияСлужебный.ФорматированныйТекстОшибкиУтверждения(ОписаниеПроверки, Сообщение, ОбъектПроверки);
	ВызватьОшибкуПроверки(ТекстСообщения, ОписаниеПроверки);
	
КонецПроцедуры

Процедура Пропустить(Сообщение) Экспорт
	
	СтруктураОшибки = КонтекстОшибки();
	СтруктураОшибки.ОшибкаУтверждения = Ложь;
	
	СообщениеОбОшибке = ТекстСообщенияОбОшибке(Сообщение, ПрефиксОшибкиПропуска());
	ВызватьИсключение СообщениеОбОшибке;
	
КонецПроцедуры

Функция ПредставлениеОшибки(Описание, Ошибка) Экспорт
	
	Если ТипЗнч(Ошибка) = Тип("ИнформацияОбОшибке") Тогда
		ПредставлениеОшибки = Символы.ПС + ПодробноеПредставлениеОшибки(Ошибка);
	Иначе
		ПредставлениеОшибки = Ошибка;
	КонецЕсли;
	
	Возврат ЮТСтроки.ДобавитьСтроку(Описание, ПредставлениеОшибки, ": ");
	
КонецФункции

// Вызывает ошибку выполнения теста
// Служебный метод, предварительно нужно самостоятельно настроить контекст (см. ЮТКонтекстСлужебный.КонтекстОшибки)
// Параметры:
//  ТекстСообщения - Строка
//  ОписаниеПроверки - см. ЮТФабрикаСлужебный.ОписаниеПроверки
Процедура ВызватьОшибкуПроверки(Знач ТекстСообщения, ОписаниеПроверки = Неопределено) Экспорт
	
	СообщениеОбОшибке = ТекстСообщенияОбОшибке(ТекстСообщения, ПрефиксОшибкиУтверждений(), ОписаниеПроверки);
	ВызватьИсключение СообщениеОбОшибке;
	
КонецПроцедуры

Процедура ЗарегистрироватьОшибкуИнициализацииДвижка(Ошибка, Описание) Экспорт
	
	СообщитьПользователюОбОшибке(Ошибка, Описание);
	
КонецПроцедуры

// Возвращает тип ошибки
//
// Параметры:
//  Ошибка - ИнформацияОбОшибке
//  ИмяВызываемогоМетода - Строка - Имя вызываемого метода
//
// Возвращаемое значение:
//  Строка - см. ЮТФабрикаСлужебный.ТипыОшибок
Функция ТипОшибки(Ошибка, ИмяВызываемогоМетода) Экспорт
	
	ТипыОшибок = ЮТФабрикаСлужебный.ТипыОшибок();
	
	Описание = Ошибка.Описание;
	
	ИмяМетода = Сред(ИмяВызываемогоМетода, СтрНайти(ИмяВызываемогоМетода, ".") + 1);
	
	Тексты = ТекстыОшибокВызоваМетода(ИмяМетода);
	
	Если Описание = Тексты.МетодНеОбнаружен
		И СтрНачинаетсяС(Ошибка.ИсходнаяСтрока, ИмяВызываемогоМетода) Тогда
		
		ТипОшибки = ТипыОшибок.ТестНеРеализован;
		
	ИначеЕсли Описание = Тексты.МалоПараметров И СтрНачинаетсяС(Ошибка.ИсходнаяСтрока, ИмяВызываемогоМетода) Тогда
		
		ТипОшибки = ТипыОшибок.МалоПараметров;
		
	ИначеЕсли Описание = Тексты.МногоПараметров И СтрНачинаетсяС(Ошибка.ИсходнаяСтрока, ИмяВызываемогоМетода) Тогда
		
		ТипОшибки = ТипыОшибок.МногоПараметров;
		
	ИначеЕсли СтрНачинаетсяС(Описание, ПрефиксОшибкиУтверждений()) Тогда
		
		ТипОшибки = ТипыОшибок.Утверждений;
		
	ИначеЕсли СтрНачинаетсяС(Описание, ПрефиксОшибкиПропуска()) Тогда
		
		ТипОшибки = ТипыОшибок.Пропущен;
		
	Иначе
		
		ТипОшибки = ТипыОшибок.Исполнения;
		
	КонецЕсли;
	
	Возврат ТипОшибки;
	
КонецФункции

Функция ПрефиксОшибкиУтверждений() Экспорт
	
	Возврат "[Failed]";
	
КонецФункции

Функция ПрефиксОшибкиВыполнения() Экспорт
	
	Возврат "[Broken]";
	
КонецФункции

Функция ПрефиксОшибкиПропуска() Экспорт
	
	Возврат "[Skip]";
	
КонецФункции

Функция СтатусВыполненияТеста(Тест) Экспорт
	
	СтатусыИсполненияТеста = ЮТФабрика.СтатусыИсполненияТеста();
	
	Если Тест.Ошибки.КОличество() = 0 Тогда
		Возврат СтатусыИсполненияТеста.Успешно;
	КонецЕсли;
	
	ПорядокСтатусов = Новый Массив();
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Успешно);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Исполнение);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.НеРеализован);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Ожидание);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Пропущен);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Ошибка);
	ПорядокСтатусов.Добавить(СтатусыИсполненияТеста.Сломан);
	
	Статус = Тест.Статус;
	
	Для Каждого Ошибка Из Тест.Ошибки Цикл
		
		СтатусОшибки = СтатусОшибки(Ошибка.ТипОшибки);
		
		Если ПорядокСтатусов.Найти(СтатусОшибки) > ПорядокСтатусов.Найти(Статус) Тогда
			Статус = СтатусОшибки;
		КонецЕсли;
		
		Если Статус = СтатусыИсполненияТеста.Сломан Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Статус;
	
КонецФункции

Функция СтатусОшибки(ТипОшибки) Экспорт
	
	СтатусОшибки = ЮТФабрикаСлужебный.ПараметрыТиповОшибок()[ТипОшибки].Статус;
	
	Если СтатусОшибки = Неопределено Тогда
		СтатусОшибки = ЮТФабрика.СтатусыИсполненияТеста().Сломан;
	КонецЕсли;
	
	Возврат СтатусОшибки;
	
КонецФункции

Процедура УстановитьДанныеОшибкиСравнения(ПроверяемоеЗначение, ОжидаемоеЗначение) Экспорт
	
	СтруктураОшибки = КонтекстОшибки();
	
	СтруктураОшибки.ОшибкаУтверждения = Истина;
	СтруктураОшибки.ПроверяемоеЗначение = ЮТОбщий.ПредставлениеЗначения(ПроверяемоеЗначение);
	СтруктураОшибки.ОжидаемоеЗначение = ЮТОбщий.ПредставлениеЗначения(ОжидаемоеЗначение);
	
КонецПроцедуры

Процедура УстановитьДанныеОшибкиУтверждения(ПроверяемоеЗначение) Экспорт
	
	СтруктураОшибки = КонтекстОшибки();
	
	СтруктураОшибки.ОшибкаУтверждения = Истина;
	СтруктураОшибки.ПроверяемоеЗначение = ЮТОбщий.ПредставлениеЗначения(ПроверяемоеЗначение);
	СтруктураОшибки.ОжидаемоеЗначение = Неопределено;
	
КонецПроцедуры

Функция ДобавитьОписания(ТекстОшибки, ОписаниеПроверки = Неопределено) Экспорт
	
	Если ОписаниеПроверки <> Неопределено Тогда
		ПрефиксОшибки = ЮТСтроки.ДобавитьСтроку(ОписаниеПроверки.ПрефиксОшибки, ОписаниеПроверки.ОписаниеПроверки, " ");
		СообщениеОбОшибке = ЮТСтроки.ДобавитьСтроку(ПрефиксОшибки, ТекстОшибки, ": ");
	Иначе
		СообщениеОбОшибке = ТекстОшибки;
	КонецЕсли;
	
	СообщениеОбОшибке = ВРег(Лев(СообщениеОбОшибке, 1)) + Сред(СообщениеОбОшибке, 2);
	Возврат СообщениеОбОшибке;
	
КонецФункции

Процедура ДобавитьОшибкуКРезультатуПроверки(РезультатПроверки, Знач Ошибка, ОписаниеПроверки = Неопределено) Экспорт
	
	Если ТипЗнч(Ошибка) = Тип("ИнформацияОбОшибке") Тогда
		Ошибка = ПодробноеПредставлениеОшибки(Ошибка);
	КонецЕсли;
	
	ТекстОшибки = ДобавитьОписания(Ошибка, ОписаниеПроверки);
	РезультатПроверки.Успешно = Ложь;
	РезультатПроверки.Сообщения.Добавить(ТекстОшибки);
	
КонецПроцедуры

Процедура ДобавитьОшибкуСравненияКРезультатуПроверки(РезультатПроверки, Сообщение, ПроверяемоеЗначение, ОжидаемоеЗначение) Экспорт
	
	ОписаниеКонтекстаОшибки = ОписаниеКонтекстаОшибки();
	ОписаниеКонтекстаОшибки.ПроверяемоеЗначение = ПроверяемоеЗначение;
	ОписаниеКонтекстаОшибки.ОжидаемоеЗначение = ОжидаемоеЗначение;
	ОписаниеКонтекстаОшибки.ОшибкаУтверждения = Истина;
	ОписаниеКонтекстаОшибки.Сообщение = Сообщение;
	
	РезультатПроверки.Успешно = Ложь;
	РезультатПроверки.Сообщения.Добавить(ОписаниеКонтекстаОшибки);
	
КонецПроцедуры

Процедура ДобавитьПояснениеОшибки(Пояснение) Экспорт
	
	Детали = КонтекстДеталиОшибки();
	Установить = Детали = Неопределено;
	
	Если Установить Тогда
		Детали = Новый Массив();
	КонецЕсли;
	
	Детали.Добавить(Пояснение);
	
	Если Установить Тогда
		ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(ИмяКонтекстаДеталиОшибки(), Детали);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Контекст

// Контекст ошибки.
// 
// Возвращаемое значение:
//  см. ОписаниеКонтекстаОшибки
Функция КонтекстОшибки() Экспорт
	
	Контекст = ЮТКонтекстСлужебный.ЗначениеКонтекста(ИмяКонтекстаОшибки());
	
	Если Контекст = Неопределено Тогда
		Контекст = УстановитьКонтекстОшибки();
	КонецЕсли;
	
	//@skip-check constructor-function-return-section
	Возврат Контекст;
	
КонецФункции

Функция УстановитьКонтекстОшибки() Экспорт
	
	ДанныеОшибки = ОписаниеКонтекстаОшибки();
	ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(ИмяКонтекстаОшибки(), ДанныеОшибки);
	
	Возврат ДанныеОшибки;
	
КонецФункции

Функция КонтекстДеталиОшибки(ПолучитьССервера = Ложь)
	
	Возврат ЮТКонтекстСлужебный.ЗначениеКонтекста(ИмяКонтекстаДеталиОшибки(), ПолучитьССервера);
	
КонецФункции

// ОписаниеКонтекстаОшибки
//  Возвращает описание деталей/расшифровки ошибки
// Возвращаемое значение:
//  Структура - Детали ошибки:
// * ОшибкаУтверждения - Булево - Признак, это ошибка проверки утверждения
// * ПроверяемоеЗначение - Произвольный - Фактическое значение
// * ОжидаемоеЗначение - Произвольный - Ожидаемое значение
// * Сообщение - Строка
// * ДополнительныеДанные - Массив из Произвольный
// * Пояснения - Массив из Произвольный
Функция ОписаниеКонтекстаОшибки()
	
	Описание = Новый Структура("ПроверяемоеЗначение, ОжидаемоеЗначение");
	Описание.Вставить("ОшибкаУтверждения", Ложь);
	Описание.Вставить("Сообщение", "");
	Описание.Вставить("ДополнительныеДанные", Новый Массив());
	Описание.Вставить("Пояснения", Новый Массив());
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

Функция ИмяКонтекстаОшибки()
	
	Возврат "ДанныеОшибки";
	
КонецФункции

Функция ИмяКонтекстаДеталиОшибки()
	
	Возврат "ДеталиОшибки";
	
КонецФункции

#КонецОбласти

#Область КонструкторыОписанийОшибки

Функция ДанныеОшибки(Ошибка, Знач Сообщение, ТипОшибки)
	
#Если Сервер Тогда
	Детали = КонтекстДеталиОшибки(Истина);
#Иначе
	ДеталиСервер = КонтекстДеталиОшибки(Истина);
	ДеталиКлиент = КонтекстДеталиОшибки();
	
	Если ЗначениеЗаполнено(ДеталиКлиент) И ЗначениеЗаполнено(ДеталиСервер) Тогда
		ЮТКоллекции.ДополнитьМассив(ДеталиСервер, ДеталиКлиент);
		Детали = ДеталиСервер;
	ИначеЕсли ЗначениеЗаполнено(ДеталиКлиент) Тогда
		Детали = ДеталиКлиент;
	ИначеЕсли ЗначениеЗаполнено(ДеталиСервер) Тогда
		Детали = ДеталиСервер;
	Иначе
		Детали = Неопределено;
	КонецЕсли;
#КонецЕсли
	
	Если ЗначениеЗаполнено(Детали) Тогда
		ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(ИмяКонтекстаДеталиОшибки(), Неопределено);
		
		Детали.Добавить(Сообщение);
		Сообщение = СтрСоединить(Детали, Символы.ПС);
	КонецЕсли;
	
	ДанныеОшибки = ЮТФабрикаСлужебный.ОписаниеОшибкиПропуска(ТипОшибки + ": " + Сообщение);
	
	Если Ошибка <> Неопределено Тогда
		ДанныеОшибки.Стек = СтекОшибки(Ошибка);
	КонецЕсли;
	ДанныеОшибки.ТипОшибки = ТипОшибки;
	
	ДобавитьСообщенияПользователю();
	ДобавитьЛогТеста(ДанныеОшибки);
	
	Возврат ДанныеОшибки;
	
КонецФункции

Функция ДанныеОшибкиУтверждений(Ошибка)
	
	Описание = ИзвлечьТекстОшибки(Ошибка, ПрефиксОшибкиУтверждений());
	
	ДанныеОшибки = ЮТФабрикаСлужебный.ОписаниеОшибкиСравнения(Описание);
	ДанныеОшибки.Стек = СтекОшибки(Ошибка);
	
	ДобавитьСообщенияПользователю();
	ДобавитьЛогТеста(ДанныеОшибки);
	
	СтруктураОшибки = КонтекстОшибки();
	
	Если СтруктураОшибки <> Неопределено И СтруктураОшибки.ОшибкаУтверждения Тогда
		ДанныеОшибки.ПроверяемоеЗначение = СтруктураОшибки.ПроверяемоеЗначение;
		ДанныеОшибки.ОжидаемоеЗначение = СтруктураОшибки.ОжидаемоеЗначение;
	КонецЕсли;
	
	Возврат ДанныеОшибки;
	
КонецФункции

Функция ДанныеОшибкиПропуска(Ошибка)
	
	Описание = ИзвлечьТекстОшибки(Ошибка, ПрефиксОшибкиПропуска());
	
	ДанныеОшибки = ЮТФабрикаСлужебный.ОписаниеОшибкиПропуска(Описание);
	
	ДобавитьСообщенияПользователю();
	ДобавитьЛогТеста(ДанныеОшибки);
	
	Возврат ДанныеОшибки;
	
КонецФункции

Процедура ДобавитьЛогТеста(ДанныеОшибки)
	
	Лог = ЮТЛогИсполненияТестаСлужебный.Записи();
	Если Лог <> Неопределено Тогда
		ЮТКоллекции.ДополнитьМассив(ДанныеОшибки.Лог, Лог);
	КонецЕсли;
	
КонецПроцедуры

Функция СтекОшибки(Ошибка)
	
	Если ТипЗнч(Ошибка) = Тип("ИнформацияОбОшибке") Тогда
		Возврат ПодробноеПредставлениеОшибки(Ошибка);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Функция ИзвлечьТекстОшибки(Ошибка, Префикс)
	
	ДлинаПрефикса = СтрДлина(Префикс);
	
	Описание = Сред(Ошибка.Описание, ДлинаПрефикса + 1);
	Описание = СокрЛП(Описание);
	
	Если СтрНачинаетсяС(Описание, "<") И СтрЗаканчиваетсяНа(Описание, ">") Тогда
		Описание = Сред(Описание, 2, СтрДлина(Описание) - 2);
	КонецЕсли;
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

Функция МодулиУтверждений()
	
	Возврат ЮТКоллекции.ЗначениеВМассиве("ЮТУтверждения");
	
КонецФункции

Процедура СообщитьПользователюОбОшибке(Ошибка, Описание)
	
	ЮТОбщий.СообщитьПользователю(ПредставлениеОшибки(Описание, Ошибка));
	
КонецПроцедуры

Функция ИнформациюОбОшибкеВСтроку(Ошибка, НомерПричины = 0)
	
	ТекстОшибки = "";
	
	Если Ошибка = Неопределено Тогда
		
		ТекстОшибки = "Неизвестная ошибка.";
		
	ИначеЕсли ТипЗнч(Ошибка) = Тип("Строка") Тогда
		
		ТекстОшибки = Ошибка;
		
	ИначеЕсли ЭтоОшибкаСлужебногоМодуля(Ошибка) Тогда
		
		Если Ошибка.Причина = Неопределено Тогда
			
			ТекстОшибки = Ошибка.Описание;
			
		Иначе
			
			ТекстОшибки = ИнформациюОбОшибкеВСтроку(Ошибка.Причина, НомерПричины);
			
		КонецЕсли;
		
	Иначе
		
		Если НЕ ПустаяСтрока(Ошибка.ИмяМодуля) Тогда
			
			ТекстОшибки = ТекстОшибки + "{"
				+ Ошибка.ИмяМодуля + "("
				+ Ошибка.НомерСтроки + ")}: ";
			
		КонецЕсли;
		
		ТекстОшибки = ТекстОшибки + Ошибка.Описание + ?(ПустаяСтрока(Ошибка.ИсходнаяСтрока), "", "
						|" + Ошибка.ИсходнаяСтрока);
		
		Если Ошибка.Причина <> Неопределено Тогда
			
			ТекстОшибки = ТекстОшибки + "
				|
				|ПРИЧИНА №" + Формат(НомерПричины + 1, "ЧГ=0") + "
				|" + ИнформациюОбОшибкеВСтроку(Ошибка.Причина, НомерПричины + 1);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ТекстОшибки;
	
КонецФункции

Функция ЭтоОшибкаСлужебногоМодуля(Ошибка)
	
	Если НЕ ЗначениеЗаполнено(Ошибка.ИмяМодуля) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого ИмяМодуля Из МодулиУтверждений() Цикл
		Если СтрНайти(Ошибка.ИмяМодуля, ИмяМодуля) > 0 Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Процедура ДобавитьСообщенияПользователю()
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	Для Каждого Сообщение Из ПолучитьСообщенияПользователю(Истина) Цикл
		ЮТест.ДобавитьСообщение(Сообщение.Текст);
	КонецЦикла;
#КонецЕсли
	
КонецПроцедуры

Процедура ВызватьОшибкуИсполнения(Знач ИнформацияОбОшибке, ОписаниеПроверки)
	
	ТекстОшибки = ИнформациюОбОшибкеВСтроку(ИнформацияОбОшибке);
	СообщениеОбОшибке = ТекстСообщенияОбОшибке(ТекстОшибки, ПрефиксОшибкиВыполнения(), ОписаниеПроверки);
	ВызватьИсключение СообщениеОбОшибке;
	
КонецПроцедуры

Функция ТекстСообщенияОбОшибке(ТекстОшибки, ПрефиксТипаОшибки, ОписаниеПроверки = Неопределено)
	
	СообщениеОбОшибке = ДобавитьОписания(ТекстОшибки, ОписаниеПроверки);
	
	Возврат СтрШаблон("%1 <%2>", ПрефиксТипаОшибки, СообщениеОбОшибке);
	
КонецФункции

Функция ТекстыОшибокВызоваМетода(ИмяМетода)
	
	Тексты = Новый Структура("МетодНеОбнаружен, МногоПараметров, МалоПараметров");
	
	Если ЮТОкружение.ИспользуетсяАнглийскаяЛокальПлатформы() Тогда
		Тексты.МетодНеОбнаружен = СтрШаблон("Object method not found (%1)", ИмяМетода);
		Тексты.МногоПараметров = "Too many actual parameters";
		Тексты.МалоПараметров = "Not enough actual parameters";
	Иначе
		Тексты.МетодНеОбнаружен = СтрШаблон("Метод объекта не обнаружен (%1)", ИмяМетода);
		Тексты.МногоПараметров = "Слишком много фактических параметров";
		Тексты.МалоПараметров = "Недостаточно фактических параметров";
	КонецЕсли;
	
	Возврат Тексты;
	
КонецФункции

#КонецОбласти
