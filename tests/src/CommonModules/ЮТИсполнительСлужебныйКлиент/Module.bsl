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

Процедура ВыполнитьМодульноеТестирование() Экспорт
	
	Если НЕ ЮТПараметрыЗапускаСлужебный.ЕстьПараметрыЗапускаТестов() Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.АргументыЗапуска = ПараметрЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьПараметры");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикАнализПараметровЗапуска");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикПодключитьКомпоненты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСохранитьОтчет");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСохранитьКодВозврата");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗавершить");
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ВыполнитьМодульноеТестированиеПоНастройке(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикРазрешитьЗависимости");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикВыполнитьТестирование");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ЗагрузитьЗарегистрированныеТесты(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Процедура ЗагрузитьИсполняемыеТесты(ПараметрыЗапуска, ОбработчикЗавершения) Экспорт
	
	ПараметрыИсполнения = ПараметрыИсполнения();
	ПараметрыИсполнения.ПараметрыЗапуска = ПараметрыЗапуска;
	
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикИнициализация");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикЗагрузитьЗарегистрированныеТесты");
	ДобавитьОбработчикЦепочки(ПараметрыИсполнения, "ОбработчикСформироватьИсполняемыеТесты");
	ПараметрыИсполнения.Цепочка.Добавить(ОбработчикЗавершения);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыИсполнения);
	
КонецПроцедуры

Функция ПараметрыИсполнения() Экспорт
	
	Параметры = ЮТАсинхроннаяОбработкаСлужебныйКлиент.ЦепочкаАсинхроннойОбработки();
	Параметры.Вставить("АргументыЗапуска");
	Параметры.Вставить("ПараметрыЗапуска");
	Параметры.Вставить("ИсполняемыеТестовыеМодули");
	Параметры.Вставить("РезультатыТестирования");
	
	Возврат Параметры;
	
КонецФункции

Функция ВыполнитьТестыМодуля(ТестовыйМодуль) Экспорт
	
	Результаты = Новый Массив();
	
	КонтекстыИсполнения = ЮТФабрика.КонтекстыИсполнения();
	
	КлиентскиеНаборы = Новый Массив();
	СерверныеНаборы = Новый Массив();
	ПропущенныеНаборы = Новый Массив();
	
	ТестовыйМодульОблегченный = ЮТКоллекции.СкопироватьСтруктуру(ТестовыйМодуль);
	ТестовыйМодульОблегченный.НаборыТестов = Новый Массив();
	
	Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
		
		Если НЕ Набор.Выполнять Тогда
			ПропущенныеНаборы.Добавить(Набор);
			Продолжить;
		КонецЕсли;
		
		РежимИсполнения = ЮТФабрикаСлужебный.КонтекстИсполнения(Набор.Режим);
		
		Если РежимИсполнения = КонтекстыИсполнения.Клиент Тогда
			КлиентскиеНаборы.Добавить(Набор);
		ИначеЕсли РежимИсполнения = КонтекстыИсполнения.Сервер Тогда
			ИдентификаторТестовогоНабора = ЮТИсполнительСлужебныйКлиентСервер.ИдентификаторТестовогоНабора(ТестовыйМодуль, Набор);
			СерверныеНаборы.Добавить(ИдентификаторТестовогоНабора);
		Иначе
			ПропущенныеНаборы.Добавить(Набор);
		КонецЕсли;
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(КлиентскиеНаборы) Тогда
		Результаты = ЮТИсполнительСлужебныйКлиентСервер.ВыполнитьГруппуНаборовТестов(КлиентскиеНаборы, ТестовыйМодульОблегченный);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СерверныеНаборы) Тогда
		ИдентификаторТестовогоМодуля = ЮТИсполнительСлужебныйКлиентСервер.ИдентификаторТестовогоМодуля(ТестовыйМодуль);
		Результат = ЮТИсполнительСлужебныйВызовСервера.ВыполнитьГруппуНаборовТестов(СерверныеНаборы, ИдентификаторТестовогоМодуля);
		ЮТЛогированиеСлужебный.ВывестиСерверныеСообщения();
		ЮТКоллекции.ДополнитьМассив(Результаты, Результат);
	КонецЕсли;
	
	ЮТКоллекции.ДополнитьМассив(Результаты, ПропущенныеНаборы);
	
	ТестовыйМодульОблегченный.НаборыТестов = Результаты;
	
	Возврат ТестовыйМодульОблегченный;
	
КонецФункции

Процедура ОбработкаОшибки(ТекстОшибки) Экспорт
	ВызватьИсключение ТекстОшибки;
КонецПроцедуры

Процедура ВыполнитьИнициализацию(ПараметрыЗапуска) Экспорт
	
	ЮТЛогирование.Информация("Инициализация");
	ЮТКонтекстСлужебный.ИнициализироватьКонтекст(ПараметрыЗапуска);
	ЮТСобытияСлужебный.Инициализация(ПараметрыЗапуска);
	
	// Повторно сохраним для передачи на сервер
	ЮТКонтекстСлужебный.УстановитьГлобальныеНастройкиВыполнения(ЮТКонтекстСлужебный.ГлобальныеНастройкиВыполнения());
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиЦепочкиДействий

Процедура ОбработчикОшибки(ИнформацияОбОшибке, СтандартнаяОбработка, ДополнительныеПараметры) Экспорт
	
	// TODO Подумать надо ли и как реализовать нормально
	
КонецПроцедуры

Процедура ОбработчикЗагрузитьПараметры(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Загрузка параметров запуска");
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
	ЮТПараметрыЗапускаСлужебный.ПараметрыЗапуска(ДополнительныеПараметры.АргументыЗапуска, Обработчик);
	
КонецПроцедуры

Процедура ОбработчикАнализПараметровЗапуска(ПараметрыЗапуска, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Анализ параметров запуска");
	
	Если НЕ ПараметрыЗапуска.ВыполнятьМодульноеТестирование Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеПараметры.ПараметрыЗапуска = ПараметрыЗапуска;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикИнициализация(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Инициализация");
	ВыполнитьИнициализацию(ДополнительныеПараметры.ПараметрыЗапуска);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикЗагрузитьЗарегистрированныеТесты(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Загрузка тестовых сценариев");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ЗагрузкаТестов);
	
	Отказ = Ложь;
	ЮТСобытияСлужебный.ПередЧтениеСценариев(Отказ);
	
	Если Отказ Тогда
		ТестовыеМодули = Новый Массив;
	Иначе
		ТестовыеМодули = ЮТЧитательСлужебный.ЗагрузитьТесты(ДополнительныеПараметры.ПараметрыЗапуска);
		ЮТСобытияСлужебный.ПослеЧтенияСценариев(ТестовыеМодули);
	КонецЕсли;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, ТестовыеМодули);
	
КонецПроцедуры

Процедура ОбработчикСформироватьИсполняемыеТесты(ТестовыеМодули, ДополнительныеПараметры) Экспорт
	
	ИсполняемыеТестовыеМодули = Новый Массив;
	
	Для Каждого ТестовыйМодуль Из ТестовыеМодули Цикл
		ИсполняемыйТестовыйМодуль = ИсполняемыйТестовыйМодуль(ТестовыйМодуль);
		ИсполняемыеТестовыеМодули.Добавить(ИсполняемыйТестовыйМодуль);
	КонецЦикла;
	
	ЮТСобытияСлужебный.ПослеФормированияИсполняемыхНаборовТестов(ИсполняемыеТестовыеМодули);
	
	ДополнительныеПараметры.ИсполняемыеТестовыеМодули = ИсполняемыеТестовыеМодули;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, ИсполняемыеТестовыеМодули);
	
КонецПроцедуры

Процедура ОбработчикРазрешитьЗависимости(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Разрешение зависимостей");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().РазрешениеЗависимостей);
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
	
	ЮТЗависимостиСлужебныйКлиент.РазрешитьЗависимости(ДополнительныеПараметры.ИсполняемыеТестовыеМодули, Обработчик);
	
КонецПроцедуры

Процедура ОбработчикВыполнитьТестирование(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Выполнение тестовых сценариев");
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ПрогонТестов);
	ЮТИсполнительСлужебныйВызовСервера.СохранитьИнформациюОТестовыхСценариях(ДополнительныеПараметры.ИсполняемыеТестовыеМодули);
	
	РезультатыТестирования = Новый Массив();
	Отказ = Ложь;
	ЮТСобытияСлужебный.ПередВыполнениемТестов(ДополнительныеПараметры.ИсполняемыеТестовыеМодули, Отказ);
	
	Если НЕ Отказ Тогда
		
		Для Каждого ТестовыйМодуль Из ДополнительныеПараметры.ИсполняемыеТестовыеМодули Цикл
			
			РезультатыПрогонаМодуля = ВыполнитьТестыМодуля(ТестовыйМодуль);
			РезультатыТестирования.Добавить(РезультатыПрогонаМодуля);
			
		КонецЦикла;
		
		ЮТСобытияСлужебный.ПослеВыполненияТестов(РезультатыТестирования);
		
	КонецЕсли;
	
	ДополнительныеПараметры.РезультатыТестирования = РезультатыТестирования;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры, РезультатыТестирования);
	
КонецПроцедуры

Процедура ОбработчикСохранитьОтчет(_, ДополнительныеПараметры) Экспорт
	
	ЮТКонтекстСлужебный.УстановитьТекущийЭтапПрогона(ЮТФабрика.ЭтапыПрогона().ФормированиеОтчета);
	Если ЗначениеЗаполнено(ДополнительныеПараметры.ПараметрыЗапуска.reportPath) Тогда
		ЮТЛогирование.Информация("Формирование отчета о тестировании");
		Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
		ЮТОтчетСлужебный.СформироватьОтчет(ДополнительныеПараметры.РезультатыТестирования, ДополнительныеПараметры.ПараметрыЗапуска, Обработчик);
	Иначе
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработчикСохранитьКодВозврата(_, ДополнительныеПараметры) Экспорт
	
	ЗаписатьКодВозврата(ДополнительныеПараметры.РезультатыТестирования, ДополнительныеПараметры.ПараметрыЗапуска);
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ОбработчикЗавершить(_, ДополнительныеПараметры) Экспорт
	
	ЮТЛогирование.Информация("Завершение работы YAxUnit");
	Параметры = ДополнительныеПараметры.ПараметрыЗапуска;
	ЮТКонтекстСлужебный.УдалитьКонтекст();
	
	Если Параметры.showReport Тогда
		ПоказатьОтчет(ДополнительныеПараметры.РезультатыТестирования, Параметры);
	ИначеЕсли Параметры.CloseAfterTests Тогда
		ПрекратитьРаботуСистемы(Ложь);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработчикПодключитьКомпоненты(_, ДополнительныеПараметры) Экспорт
	
	Если ДополнительныеПараметры.ПараметрыЗапуска.ПодключатьВнешниеКомпоненты Тогда
		ЮТЛогирование.Информация("Подключение внешних компонент");
		Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ДополнительныеПараметры);
		ЮТКомпонентыСлужебныйКлиент.ТихаяУстановкаКомпонент(Обработчик);
	Иначе
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

Процедура ДобавитьОбработчикЦепочки(ПараметрыИсполнения, ИмяМетода)
	
	Обработчик = Новый ОписаниеОповещения(ИмяМетода, ЭтотОбъект, ПараметрыИсполнения, "ОбработчикОшибки", ЭтотОбъект);
	ПараметрыИсполнения.Цепочка.Добавить(Обработчик);
	
КонецПроцедуры

Функция ИсполняемыйТестовыйМодуль(ТестовыйМодуль)
	
	ИсполняемыйТестовыйМодуль = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоТестовогоМодуля(ТестовыйМодуль);
	
	КонтекстыПриложения = ЮТФабрикаСлужебный.КонтекстыПриложения();
	КонтекстыМодуля = ЮТФабрикаСлужебный.КонтекстыМодуля(ТестовыйМодуль.Метаданные);
	КонтекстыИсполнения = ЮТФабрика.КонтекстыИсполнения();
	
	ИсполняемыйТестовыйМодуль.НаборыТестов = ИсполняемыеНаборыМодуля(ТестовыйМодуль);
	
	Для Каждого Набор Из ИсполняемыйТестовыйМодуль.НаборыТестов Цикл
		
		КонтекстИсполнения = ЮТФабрикаСлужебный.КонтекстИсполнения(Набор.Режим);
		
		Если КонтекстыПриложения.Найти(Набор.Режим) = Неопределено Тогда
			ОшибкаКонтекста = "Неподдерживаемый режим запуска";
		ИначеЕсли КонтекстыМодуля.Найти(Набор.Режим) = Неопределено Тогда
			ОшибкаКонтекста = "Модуль не доступен в этом контексте";
		ИначеЕсли КонтекстИсполнения <> КонтекстыИсполнения.Сервер И КонтекстИсполнения <> КонтекстыИсполнения.Клиент Тогда
			ОшибкаКонтекста = "Неизвестный контекст/режим исполнения";
		Иначе
			ОшибкаКонтекста = Неопределено;
		КонецЕсли;
		
		Если ОшибкаКонтекста <> Неопределено Тогда
			Набор.Выполнять = Ложь;
			ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуРежимаВыполнения(Набор, ОшибкаКонтекста);
			Для Каждого Тест Из Набор.Тесты Цикл
				ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуРежимаВыполнения(Тест, ОшибкаКонтекста);
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ИсполняемыйТестовыйМодуль;
	
КонецФункции

Функция ИсполняемыеНаборыМодуля(ТестовыйМодуль)
	
	Результат = Новый Массив();
	
	Для Каждого ТестовыйНабор Из ТестовыйМодуль.НаборыТестов Цикл
		
		НаборыКонтекстов = Новый Структура;
		
		ТестыНабора = ЮТКоллекции.ЗначениеСтруктуры(ТестовыйНабор, "Тесты", Новый Массив());
		ОбработатьОшибкиЧтенияНабора(ТестовыйНабор, ТестовыйМодуль);
		
		Для Каждого Тест Из ТестыНабора Цикл
			
			Для Каждого Контекст Из Тест.КонтекстВызова Цикл
				
				Если НЕ НаборыКонтекстов.Свойство(Контекст) Тогда
					ИсполняемыйНабор = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоНабораТестов(ТестовыйНабор);
					ИсполняемыйНабор.Режим = Контекст;
					НаборыКонтекстов.Вставить(Контекст, ИсполняемыйНабор);
				Иначе
					ИсполняемыйНабор = НаборыКонтекстов[Контекст];
				КонецЕсли;
				
				ИсполняемыйТест = ЮТФабрикаСлужебный.НовоеОписаниеИсполняемогоТеста(Тест, Контекст, ТестовыйМодуль);
				Если Тест.Свойство("Ошибки") И Тест.Ошибки.Количество() > 0 Тогда
					ИсполняемыйТест.Ошибки = ЮТКоллекции.СкопироватьМассив(Тест.Ошибки);
				КонецЕсли;
				ИсполняемыйНабор.Тесты.Добавить(ИсполняемыйТест);
				
			КонецЦикла;
			
		КонецЦикла;
		
		Если НаборыКонтекстов.Количество() Тогда
			
			Для Каждого Элемент Из НаборыКонтекстов Цикл
				Результат.Добавить(Элемент.Значение);
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Процедура ОбработатьОшибкиЧтенияНабора(Набор, Модуль)
	ТестыНабора = ЮТКоллекции.ЗначениеСтруктуры(Набор, "Тесты", Новый Массив());
	Ошибки = ЮТКоллекции.ЗначениеСтруктуры(Набор, "Ошибки", Новый Массив());
	
	Если Ошибки.Количество() > 0 Тогда
		Для Каждого Ошибка Из Ошибки Цикл
			Если Ошибка.ТипОшибки = ЮТФабрикаСлужебный.ТипыОшибок().ЧтенияТестов Тогда
				Тест = ОписаниеТестаСОшибкойЧтения(Модуль, Ошибка);
				ТестыНабора.Добавить(Тест);
				
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Функция ОписаниеТестаСОшибкойЧтения(Модуль, Ошибка)
	Контексты = ЮТФабрикаСлужебный.КонтекстыМодуля(Модуль.Метаданные);
	Тест = ЮТФабрикаСлужебный.ОписаниеТеста("ИсполняемыеСценарии", "ИсполняемыеСценарии", Контексты);
	Тест.Вставить("Ошибки", Новый Массив);
	Тест.Ошибки.Добавить(ЮТКоллекции.СкопироватьСтруктуру(Ошибка));
	
	Возврат Тест;
КонецФункции

Процедура ПоказатьОтчет(РезультатыТестирования, Параметры)
	
	Данные = Новый Структура("РезультатыТестирования, ПараметрыЗапуска", РезультатыТестирования, Параметры);
	АдресДанных = ПоместитьВоВременноеХранилище(Данные, Новый УникальныйИдентификатор());
	
	ОткрытьФорму("Обработка.ЮТЮнитТесты.Форма.Основная", Новый Структура("АдресХранилища", АдресДанных));
	
КонецПроцедуры

// Записать код возврата.
// 
// Параметры:
//  РезультатыТестирования - Массив из см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля
//  Параметры - см. ЮТФабрика.ПараметрыЗапуска
Процедура ЗаписатьКодВозврата(РезультатыТестирования, Параметры)
	
	Успешно = Истина;
	
	Если ПустаяСтрока(Параметры.exitCode) Тогда
		Возврат;
	КонецЕсли;
	
	ЮТЛогирование.Информация("Сохранение кода возврата в файл");
	Для Каждого Модуль Из РезультатыТестирования Цикл
		
		Для Каждого Набор Из Модуль.НаборыТестов Цикл
			
			Если РезультатТестаСодержитОшибки(Набор) Тогда
				Успешно = Ложь;
				Прервать;
			КонецЕсли;
			
			Для Каждого Тест Из Набор.Тесты Цикл
				
				Если РезультатТестаСодержитОшибки(Тест) Тогда
					Успешно = Ложь;
					Прервать;
				КонецЕсли;
				
			КонецЦикла;
			
			Если НЕ Успешно Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если НЕ Успешно Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТИсполнительКлиент.ЗаписатьКодВозврата");
#Иначе
	Запись = Новый ЗаписьТекста(Параметры.exitCode, КодировкаТекста.UTF8);
	Запись.ЗаписатьСтроку(?(Успешно, 0, 1));
	Запись.Закрыть();
#КонецЕсли

КонецПроцедуры

Функция РезультатТестаСодержитОшибки(Тест)
	Результат = Ложь;
	
	Если НЕ ЗначениеЗаполнено(Тест.Ошибки) Тогда
		Возврат Результат;
	КонецЕсли;
	
	ТипОшибкиПропущен = ЮТФабрикаСлужебный.ТипыОшибок().Пропущен;
	Для Каждого ОписаниеОшибки Из Тест.Ошибки Цикл
		Если ОписаниеОшибки.ТипОшибки <> ТипОшибкиПропущен Тогда
			Результат = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти
