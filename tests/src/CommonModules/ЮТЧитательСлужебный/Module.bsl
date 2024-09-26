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

#Если Клиент Тогда
// ЗагрузитьТесты
// 	Читает наборы тестов (тестовые модули) из расширений
// Параметры:
//  ПараметрыЗапускаТестов - см. ЮТФабрика.ПараметрыЗапуска
//
// Возвращаемое значение:
//  Массив из см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля - Набор описаний тестовых модулей, которые содержат информацию о запускаемых тестах
Функция ЗагрузитьТесты(ПараметрыЗапускаТестов) Экспорт
	
	Результат = Новый Массив;
	
	ЮТФильтрацияСлужебный.УстановитьКонтекст(ПараметрыЗапускаТестов);
	
	Для Каждого МетаданныеМодуля Из ТестовыеМодули() Цикл
		
		ОписаниеТестовогоМодуля = ТестовыеНаборыМодуля(МетаданныеМодуля, ПараметрыЗапускаТестов);
		
		Если ОписаниеТестовогоМодуля = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Результат.Добавить(ОписаниеТестовогоМодуля);
		
	КонецЦикла;
	
	ЮТЗависимостиСлужебныйКлиент.ДедупликацияЗависимостей(Результат);
	
	Возврат Результат;
	
КонецФункции
#КонецЕсли

// ПрочитатьНаборТестов
// 	Читает набор тестов из модуля
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрикаСлужебный.ОписаниеМетаданныеМодуля
//
// Возвращаемое значение:
//  - Неопределено - Если это не тестовый модуль
//  - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля
Функция ИсполняемыеСценарииМодуля(Знач МетаданныеМодуля) Экспорт
	
	ЭтоТестовыйМодуль = Истина;
	
	ЮТСобытияСлужебный.ПередЧтениемСценариевМодуля(МетаданныеМодуля);
	
	ПолноеИмяМетода = МетаданныеМодуля.Имя + "." + ИмяМетодаСценариев();
	Ошибка = ЮТМетодыСлужебный.ВыполнитьМетодКонфигурацииСПерехватомОшибки(ПолноеИмяМетода, Неопределено);
	
	Если Ошибка <> Неопределено Тогда
		
		ТипыОшибок = ЮТФабрикаСлужебный.ТипыОшибок();
		ТипОшибки = ЮТРегистрацияОшибокСлужебный.ТипОшибки(Ошибка, ПолноеИмяМетода);
		
		Если ТипОшибки = ТипыОшибок.ТестНеРеализован Тогда
			ЭтоТестовыйМодуль = Ложь;
			Ошибка = Неопределено;
		ИначеЕсли ТипОшибки = ТипыОшибок.МалоПараметров Тогда
			Ошибка = ЮТМетодыСлужебный.ВыполнитьМетодКонфигурацииСПерехватомОшибки(ПолноеИмяМетода, Неопределено, ЮТКоллекции.ЗначениеВМассиве(Неопределено));
			
			Сообщение = "Используется устаревшая сигнатура метода `ИсполняемыеСценарии`, метод не должен принимать параметров.";
			ЮТОбщий.СообщитьПользователю(Сообщение);
			ЮТЛогирование.Предостережение(Сообщение);
		КонецЕсли;
		
	КонецЕсли;
	
	Если Ошибка <> Неопределено Тогда
		
		НаборПоУмолчанию = ЮТФабрикаСлужебный.ОписаниеТестовогоНабора(МетаданныеМодуля.Имя);
		ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуЧтенияТестов(НаборПоУмолчанию, "Ошибка формирования списка тестовых методов", Ошибка);
		
		ОписаниеТестовогоМодуля = ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля(МетаданныеМодуля, Новый Массив);
		ОписаниеТестовогоМодуля.НаборыТестов.Добавить(НаборПоУмолчанию);
		
	ИначеЕсли ЭтоТестовыйМодуль Тогда
		
		ОписаниеТестовогоМодуля = ЮТТестыСлужебный.ОписаниеМодуля();
		ЮТФильтрацияСлужебный.ОтфильтроватьТестовыеНаборы(ОписаниеТестовогоМодуля);
		ЮТСобытияСлужебный.ПослеЧтенияСценариевМодуля(ОписаниеТестовогоМодуля);
		
	Иначе
		
		ОписаниеТестовогоМодуля = Неопределено;
		
	КонецЕсли;
	
	Возврат ОписаниеТестовогоМодуля;
	
КонецФункции

// ЭтоТестовыйМодуль
//   Проверяет, является ли модуль модулем с тестами
// Параметры:
//  МетаданныеМодуля - Структура - Описание метаданных модуля, см. ЮТФабрикаСлужебный.ОписаниеМетаданныеМодуля
//
// Возвращаемое значение:
//  Булево - Этот модуль содержит тесты
Функция ЭтоТестовыйМодуль(МетаданныеМодуля) Экспорт
	
	Если МетаданныеМодуля.Глобальный Или МетаданныеМодуля.ВызовСервера Тогда
		Возврат Ложь;
	КонецЕсли;
	
#Если ТолстыйКлиентУправляемоеПриложение ИЛИ ТонкийКлиент Тогда
	Если МетаданныеМодуля.КлиентУправляемоеПриложение Тогда
		Возврат ЮТМетодыСлужебный.МетодМодуляСуществует(МетаданныеМодуля.Имя, ИмяМетодаСценариев());
	КонецЕсли;
#ИначеЕсли ТолстыйКлиентОбычноеПриложение Тогда
	Если МетаданныеМодуля.КлиентОбычноеПриложение Тогда
		Возврат ЮТМетодыСлужебный.МетодМодуляСуществует(МетаданныеМодуля.Имя, ИмяМетодаСценариев());
	КонецЕсли;
#КонецЕсли

#Если Сервер Тогда
	Возврат ЮТМетодыСлужебный.МетодМодуляСуществует(МетаданныеМодуля.Имя, ИмяМетодаСценариев());
#КонецЕсли
	
	Если МетаданныеМодуля.Сервер Тогда
		//@skip-check unknown-method-property
		Возврат ЮТЧитательСлужебныйВызовСервера.ЭтоТестовыйМодуль(МетаданныеМодуля);
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИмяМетодаСценариев()
	
	Возврат "ИсполняемыеСценарии";
	
КонецФункции

// ТестовыеМодули
//  Возвращает описания модулей, содержащих тесты
// Возвращаемое значение:
//  Массив из см. ЮТМетаданныеСлужебныйВызовСервера.МетаданныеМодуля - Тестовые модули
Функция ТестовыеМодули()
	
	ТестовыеМодули = Новый Массив;
	
	//@skip-check unknown-method-property
	МодулиРасширения = ЮТМетаданныеСлужебныйВызовСервера.МодулиРасширений();
	МодулиДвижка = ЮТМетаданныеСлужебныйВызовСервера.ИменаМодулейДвижка();
	
	Для Каждого ОписаниеМодуля Из МодулиРасширения Цикл
		
		Если МодулиДвижка.Найти(ОписаниеМодуля.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		ЮТЛогирование.Отладка("Анализ модуля: " + ОписаниеМодуля.Имя);
		
		Если НЕ ЮТФильтрацияСлужебный.ЭтоПодходящийМодуль(ОписаниеМодуля) Тогда
			ЮТЛогирование.Отладка("	Пропущен, не подходит под отбор");
		ИначеЕсли НЕ ЭтоТестовыйМодуль(ОписаниеМодуля) Тогда
			ЮТЛогирование.Отладка("	Пропущен, это не тестовый модуль");
		Иначе
			ЮТЛогирование.Отладка("	Добавлен");
			ТестовыеМодули.Добавить(ОписаниеМодуля);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ТестовыеМодули;
	
КонецФункции

Функция ТестовыеНаборыМодуля(МетаданныеМодуля, ПараметрыЗапуска)
	
	// TODO Фильтрация по путям
	ОписаниеМодуля = Неопределено;
	
#Если ТолстыйКлиентОбычноеПриложение Тогда
	Если МетаданныеМодуля.КлиентОбычноеПриложение Тогда
		ОписаниеМодуля = ИсполняемыеСценарииМодуля(МетаданныеМодуля);
	ИначеЕсли МетаданныеМодуля.Сервер Тогда
		ОписаниеМодуля = ЮТЧитательСлужебныйВызовСервера.ИсполняемыеСценарииМодуля(МетаданныеМодуля);
		ЮТЛогированиеСлужебный.ВывестиСерверныеСообщения();
	КонецЕсли;
#ИначеЕсли ТолстыйКлиентУправляемоеПриложение Или ТонкийКлиент Тогда
	Если МетаданныеМодуля.КлиентУправляемоеПриложение Тогда
		ОписаниеМодуля = ИсполняемыеСценарииМодуля(МетаданныеМодуля);
	ИначеЕсли МетаданныеМодуля.Сервер Тогда
		ОписаниеМодуля = ЮТЧитательСлужебныйВызовСервера.ИсполняемыеСценарииМодуля(МетаданныеМодуля);
		ЮТЛогированиеСлужебный.ВывестиСерверныеСообщения();
	КонецЕсли;
#ИначеЕсли Сервер Тогда
	Если МетаданныеМодуля.Сервер Тогда
		ОписаниеМодуля = ИсполняемыеСценарииМодуля(МетаданныеМодуля);
	Иначе
		ВызватьИсключение "Чтение списка тестов модуля в недоступном контексте";
	КонецЕсли;
#КонецЕсли
	
	Возврат ОписаниеМодуля;
	
КонецФункции

#КонецОбласти
