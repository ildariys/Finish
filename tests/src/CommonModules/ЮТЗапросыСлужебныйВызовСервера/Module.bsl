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

Функция РезультатЗапроса(Знач ОписаниеЗапроса, Знач ДляКлиента) Экспорт
	
	Запрос = Запрос(ОписаниеЗапроса);
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат ВыгрузитьРезультатЗапроса(РезультатЗапроса, ДляКлиента);
	
КонецФункции

// Результат пустой.
// 
// Параметры:
//  ОписаниеЗапроса - см. ЮТЗапросы.ОписаниеЗапроса
// 
// Возвращаемое значение:
//  Булево - Результат пустой
Функция РезультатПустой(Знач ОписаниеЗапроса) Экспорт
	
	Запрос = Запрос(ОписаниеЗапроса);
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Пустой();
	
КонецФункции

// Возвращает значения реквизитов ссылки
// 
// Параметры:
//  Ссылка - ЛюбаяСсылка
//  ИменаРеквизитов - Строка
//  ОдинРеквизит - Булево
// 
// Возвращаемое значение:
//  - Структура Из Произвольный - Значения реквизитов ссылки при получении значений множества реквизитов
//  - Произвольный - Значение реквизита ссылки при получении значения одного реквизита
Функция ЗначенияРеквизитов(Знач Ссылка, Знач ИменаРеквизитов, Знач ОдинРеквизит) Экспорт
	
	ИмяТаблицы = Ссылка.Метаданные().ПолноеИмя();
	
	ТекстЗапроса = СтрШаблон("ВЫБРАТЬ ПЕРВЫЕ 1 %1 ИЗ %2 ГДЕ Ссылка = &Ссылка", ИменаРеквизитов, ИмяТаблицы);
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Если ОдинРеквизит Тогда
		Возврат ЗначениеИзЗапроса(Запрос, 0);
	Иначе
		Возврат ЗначенияИзЗапроса(Запрос, ИменаРеквизитов);
	КонецЕсли;
	
КонецФункции

// Возвращает записи результат запроса
// 
// Параметры:
//  ОписаниеЗапроса - см. ЮТЗапросы.ОписаниеЗапроса
//  ОднаЗапись - Булево - Вернуть первую запись
// 
// Возвращаемое значение:
//  Массив из Структура, Структура, Неопределено - Записи
Функция Записи(Знач ОписаниеЗапроса, Знач ОднаЗапись) Экспорт
	
	Если ОднаЗапись Тогда
		ОписаниеЗапроса.КоличествоЗаписей = 1;
	КонецЕсли;
	
	Запрос = Запрос(ОписаниеЗапроса);
	РезультатЗапроса = Запрос.Выполнить();
	
	Записи = ВыгрузитьРезультатЗапроса(РезультатЗапроса, Истина);
	
	Если НЕ ОднаЗапись Тогда
		Возврат Записи;
	ИначеЕсли Записи.Количество() Тогда
		Возврат Записи[0];
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает значения реквизитов записи
// 
// Параметры:
//  ОписаниеЗапроса - см. ЮТЗапросы.ОписаниеЗапроса
//  ОдинРеквизит - Булево
// 
// Возвращаемое значение:
//  - Структура Из Произвольный - Значения множества реквизитов записи
//  - Произвольный - Значение одного реквизита записи
// 
Функция ЗначенияРеквизитовЗаписи(Знач ОписаниеЗапроса, Знач ОдинРеквизит) Экспорт
	
	Запись = Записи(ОписаниеЗапроса, Истина);
	
	Если ТипЗнч(Запись) <> Тип("Структура") Тогда
		Если ОдинРеквизит Тогда
			Возврат Неопределено;
		Иначе
			Реквизиты = СтрСоединить(ПсевдонимыВыбираемыхПолей(ОписаниеЗапроса), ",");
			Возврат Новый Структура(Реквизиты);
		КонецЕсли;
	КонецЕсли;
	
	Если ОдинРеквизит Тогда
		Для Каждого КлючЗнач Из Запись Цикл
			Возврат КлючЗнач.Значение;
		КонецЦикла;
	Иначе
		Возврат Запись;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Запрос.
// 
// Параметры:
//  ОписаниеЗапроса - см. ЮТЗапросы.ОписаниеЗапроса
// 
// Возвращаемое значение:
//  Запрос
Функция Запрос(ОписаниеЗапроса)
	
	Запрос = Новый Запрос;
	
	Строки = Новый Массив();
	Строки.Добавить("ВЫБРАТЬ ");
	
	Если ОписаниеЗапроса.КоличествоЗаписей <> Неопределено Тогда
		Строки.Добавить("ПЕРВЫЕ " + ЮТОбщий.ЧислоВСтроку(ОписаниеЗапроса.КоличествоЗаписей));
	КонецЕсли;
	
	Если ОписаниеЗапроса.ВыбираемыеПоля.Количество() Тогда
		ВыбираемыеПоля = ОписаниеЗапроса.ВыбираемыеПоля;
	Иначе
		ВыбираемыеПоля = ЮТКоллекции.ЗначениеВМассиве("1 КАК Поле");
	КонецЕсли;
	
	Строки.Добавить(СтрСоединить(ВыбираемыеПоля, "," + Символы.ПС));
	Строки.Добавить("ИЗ " + ОписаниеЗапроса.ИмяТаблицы);
	
	Условия = СформироватьУсловия(ОписаниеЗапроса.Условия, ОписаниеЗапроса.ИмяТаблицы, Запрос);
	
	Если Условия.Количество() Тогда
		Строки.Добавить("ГДЕ (");
		Строки.Добавить(СтрСоединить(Условия, ") И (" + Символы.ПС));
		Строки.Добавить(")");
	КонецЕсли;
	
	Если ОписаниеЗапроса.Порядок.Количество() Тогда
		Строки.Добавить("УПОРЯДОЧИТЬ ПО ");
		Строки.Добавить(СтрСоединить(ОписаниеЗапроса.Порядок, ","));
	КонецЕсли;
	
	Запрос.Текст = СтрСоединить(Строки, Символы.ПС);
	ЮТКоллекции.ДополнитьСтруктуру(Запрос.Параметры, ОписаниеЗапроса.ЗначенияПараметров);
	
	Возврат Запрос;
	
КонецФункции

Функция ЗначенияИзЗапроса(Запрос, Реквизиты) Экспорт
	
	Результат = Новый Структура(Реквизиты);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеИзЗапроса(Запрос, Реквизит) Экспорт
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка[Реквизит];
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Функция ВыгрузитьРезультатЗапроса(РезультатЗапроса, ВМассив)
	
	Если НЕ ВМассив Тогда
		Возврат РезультатЗапроса.Выгрузить();
	Иначе
		Результат = Новый Массив();
	КонецЕсли;
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Результат;
	КонецЕсли;
	
	Реквизиты = Новый Массив();
	ТабличныеЧасти = Новый Массив();
	
	ТипРезультатЗапроса = Тип("РезультатЗапроса");
	Для Каждого Колонка Из РезультатЗапроса.Колонки Цикл
		
		Реквизиты.Добавить(Колонка.Имя);
		
		Если Колонка.ТипЗначения.СодержитТип(ТипРезультатЗапроса) Тогда
			ТабличныеЧасти.Добавить(Колонка.Имя);
		КонецЕсли;
		
	КонецЦикла;
	
	ПараметрыКонструктора = СтрСоединить(Реквизиты, ",");
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Запись = Новый Структура(ПараметрыКонструктора);
		ЗаполнитьЗначенияСвойств(Запись, Выборка);
		
		Для Каждого ТабличнаяЧасть Из ТабличныеЧасти Цикл
			Запись[ТабличнаяЧасть] = ВыгрузитьРезультатЗапроса(Выборка[ТабличнаяЧасть], ВМассив);
		КонецЦикла;
		
		Результат.Добавить(Запись);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ПсевдонимыВыбираемыхПолей(ОписаниеЗапроса)
	
	Псевдонимы = Новый Массив;
	
	Запрос = Запрос(ОписаниеЗапроса);
	
	СхемаЗапроса = Новый СхемаЗапроса();
	СхемаЗапроса.УстановитьТекстЗапроса(Запрос.Текст);
	
	Для Каждого ЗапросСЗ Из СхемаЗапроса.ПакетЗапросов Цикл
		Для Каждого КолонкаСЗ Из ЗапросСЗ.Колонки Цикл
			Псевдонимы.Добавить(КолонкаСЗ.Псевдоним);
		КонецЦикла;
	КонецЦикла;
	
	Возврат Псевдонимы;
	
КонецФункции

Функция ШаблонУсловия(ВыражениеПредиката, ВыраженияПредикатов, ТипРеквизита) // BSLLS:CognitiveComplexity-off
	Выражение = ВыражениеПредиката.ВидСравнения;
	
	Отрицание = ЮТПредикатыСлужебныйКлиентСервер.ЭтоВыраженияОтрицания(Выражение);
	Если Отрицание Тогда
		Выражение = ЮТПредикатыСлужебныйКлиентСервер.ВыраженияБезОтрицания(Выражение);
	КонецЕсли;
	
	Если Выражение = ВыраженияПредикатов.Равно Тогда
		Если ЭтоСтрокаНеограниченнойДлинны(ТипРеквизита) Тогда
			Шаблон = СтрШаблон("ВЫРАЗИТЬ(%%1 КАК Строка(%1)) = &%%2", XMLСтрока(СтрДлина(ВыражениеПредиката.Значение) + 1));
		Иначе
			Шаблон = "%1 = &%2";
		КонецЕсли;
	ИначеЕсли Выражение = ВыраженияПредикатов.Больше Тогда
		Шаблон = "%1 > &%2";
	ИначеЕсли Выражение = ВыраженияПредикатов.БольшеРавно Тогда
		Шаблон = "%1 >= &%2";
	ИначеЕсли Выражение = ВыраженияПредикатов.Меньше Тогда
		Шаблон = "%1 < &%2";
	ИначеЕсли Выражение = ВыраженияПредикатов.МеньшеРавно Тогда
		Шаблон = "%1 <= &%2";
	ИначеЕсли Выражение = ВыраженияПредикатов.ИмеетТип Тогда
		Шаблон = "ТИПЗНАЧЕНИЯ(%1) = &%2";
	ИначеЕсли Выражение = ВыраженияПредикатов.Содержит Тогда
		Шаблон = "%1 ПОДОБНО ""%%"" + &%2 + ""%%""";
	ИначеЕсли Выражение = ВыраженияПредикатов.ВСписке Тогда
		Шаблон = "%1 В (&%2)";
	ИначеЕсли Выражение = ВыраженияПредикатов.МеждуВключаяГраницы Тогда
		Шаблон = "%1 МЕЖДУ &%2 И &%3";
	ИначеЕсли Выражение = ВыраженияПредикатов.МеждуИсключаяГраницы Тогда
		Шаблон = "%1 > &%2 И %1 < &%3";
	ИначеЕсли Выражение = ВыраженияПредикатов.МеждуВключаяНачалоГраницы Тогда
		Шаблон = "%1 >= &%2 И %1 < &%3";
	ИначеЕсли Выражение = ВыраженияПредикатов.МеждуВключаяОкончаниеГраницы Тогда
		Шаблон = "%1 > &%2 И %1 <= &%3";
	ИначеЕсли Выражение = ВыраженияПредикатов.Заполнено Тогда
		// TODO Реализовать
		ВызватьИсключение "Проверка заполненности пока не поддерживается";
	Иначе
		ВызватьИсключение "Неподдерживаемое выражения предикатов " + Выражение;
	КонецЕсли;
	
	Если Отрицание Тогда
		Шаблон = СтрШаблон("НЕ (%1)", Шаблон);
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

Функция ТипыРеквизитов(ИмяТаблицы, Предикаты)
	
	Результат = Новый Соответствие();
	Реквизиты = Новый Массив();
	
	ПсевдонимТаблицы = ЮТТестовыеДанные.СлучайныйИдентификатор() + СтрЗаменить(ИмяТаблицы, ".", "");
	ДлинаПсевдонима = СтрДлина(ПсевдонимТаблицы);
	
	Для Каждого ВыражениеПредиката Из Предикаты Цикл
		Если ЮТПредикатыСлужебныйКлиентСервер.ЭтоПредикат(ВыражениеПредиката) И ЗначениеЗаполнено(ВыражениеПредиката.ИмяРеквизита) Тогда
			Реквизиты.Добавить(СтрШаблон("%1.%2 КАК _%3", ПсевдонимТаблицы, ВыражениеПредиката.ИмяРеквизита, Реквизиты.Количество()));
		КонецЕсли;
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Реквизиты) Тогда
		Возврат Результат;
	КонецЕсли;
	
	Схема = Новый СхемаЗапроса();
	
	Попытка
		Схема.УстановитьТекстЗапроса(СтрШаблон("ВЫБРАТЬ %1 ИЗ %2 КАК %3", СтрСоединить(Реквизиты, ","), ИмяТаблицы, ПсевдонимТаблицы));
	Исключение
		ЮТРегистрацияОшибок.ДобавитьПояснениеОшибки("Не удалось получить типы реквизитов отбора.
		|Возможно имена реквизитов заданы неверно");
		ВызватьИсключение;
	КонецПопытки;
	
	Для Каждого Колонка Из Схема.ПакетЗапросов[0].Колонки Цикл
		Выражение = Строка(Колонка.Поля[0]);
		Результат.Вставить(Сред(Выражение, ДлинаПсевдонима + 2), Новый ОписаниеТипов(Колонка.ТипЗначения, , "Null"));
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ЭтоСтрокаНеограниченнойДлинны(ТипРеквизита)
	
	Возврат ТипРеквизита <> Неопределено
		И ТипРеквизита.СодержитТип(Тип("Строка"))
		И ТипРеквизита.КвалификаторыСтроки.Длина = 0;
	
КонецФункции

Функция СформироватьУсловия(Условия, ИмяТаблицы, Запрос) Экспорт
	
	Результат = Новый Массив();
	
	Если НЕ ЗначениеЗаполнено(Условия) Тогда
		Возврат Результат;
	КонецЕсли;
	
	ТипыРеквизитов = ТипыРеквизитов(ИмяТаблицы, Условия);
	ВидыСравнения = ЮТПредикаты.Выражения();
	
	Для Каждого Условие Из Условия Цикл
		
		Если НЕ ЮТПредикатыСлужебныйКлиентСервер.ЭтоПредикат(Условие) Тогда
			Результат.Добавить(Условие);
			Продолжить;
		КонецЕсли;
		
		ТекстУсловия = УсловиеПоПредикату(Условие, Запрос, ВидыСравнения, ТипыРеквизитов);
		
		Результат.Добавить(ТекстУсловия);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция УсловиеПоПредикату(Условие, Запрос, ВидыСравнения, ТипыРеквизитов)
	
	ТипРеквизита = ТипыРеквизитов[Условие.ИмяРеквизита];
	Шаблон = ШаблонУсловия(Условие, ВидыСравнения, ТипРеквизита);
	
	ИмяПараметра = "Параметр_" + ЮТОбщий.ЧислоВСтроку(Запрос.Параметры.Количество() + 1);
	Запрос.Параметры.Вставить(ИмяПараметра, Условие.Значение);
	
	Если ЮТПредикатыСлужебныйКлиентСервер.ЭтоПредикатМежду(Условие) Тогда
		ИмяПараметра2 = "Параметр_" + ЮТОбщий.ЧислоВСтроку(Запрос.Параметры.Количество() + 1);
		Запрос.Параметры.Вставить(ИмяПараметра2, Условие.ОкончаниеИнтервала);
		
		ТекстУсловия = СтрШаблон(Шаблон, Условие.ИмяРеквизита, ИмяПараметра, ИмяПараметра2);
	Иначе
		ТекстУсловия = СтрШаблон(Шаблон, Условие.ИмяРеквизита, ИмяПараметра);
	КонецЕсли;
	
	Возврат ТекстУсловия;
	
КонецФункции

#КонецОбласти
