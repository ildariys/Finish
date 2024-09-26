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

Функция ПредставлениеТипа(Тип) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТТипыДанныхСлужебный.ПредставлениеТипа");
#Иначе
	Возврат ИдентификаторТипа(Тип);
#КонецЕсли
	
КонецФункции

Функция ИдентификаторТипа(Тип) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТТипыДанныхСлужебный.ПредставлениеТипа");
#Иначе
	ЮТПроверкиСлужебный.ПроверитьТипПараметра(Тип, Тип("Тип"), "ЮТТипыДанныхСлужебный.ИдентификаторТипа", "Тип");
	
	Если Тип = Тип("Дата") Тогда
		ИдентификаторТипа = "date";
	ИначеЕсли Тип = Тип("Число") Тогда
		ИдентификаторТипа = "number";
	Иначе
		//@skip-check Undefined variable
		ИмяТипаСПространствомИмен = СериализаторXDTO.ЗаписатьXDTO(Тип).ЛексическоеЗначение;
		ИдентификаторТипа = СтрРазделить(ИмяТипаСПространствомИмен, "}")[1];
	КонецЕсли;
	
	Возврат ИдентификаторТипа;
#КонецЕсли
	
КонецФункции

Функция ТипПоИдентификатору(ИдентификаторТипа) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТТипыДанныхСлужебный.ПредставлениеТипа");
#Иначе
	Возврат Тип(ИдентификаторТипа);
#КонецЕсли
	
КонецФункции

Функция ЭтоСсылочныйТип(Тип) Экспорт
	
	Возврат Тип <> Неопределено И ОписаниеТиповЛюбаяСсылка().СодержитТип(Тип);
	
КонецФункции

Функция СодержитСсылочныйТип(ОписаниеТипов) Экспорт
	
	Для Каждого Тип Из ОписаниеТипов.Типы() Цикл
		Если ОписаниеТиповЛюбаяСсылка().СодержитТип(Тип) Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ЭтоМенеджерЗаписи(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНайти(ПредставлениеТипа, "RecordManager.") > 0;
	
КонецФункции

Функция ЭтоТипОбъекта(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНайти(ПредставлениеТипа, "Object.") > 0;
	
КонецФункции

Функция ЭтоТипНабораЗаписей(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНайти(ПредставлениеТипа, "RecordSet.") > 0;
	
КонецФункции

Функция ЭтоТипОбъектаОбработкиОтчета(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНачинаетсяС(ПредставлениеТипа, "DataProcessorObject.") Или СтрНачинаетсяС(ПредставлениеТипа, "ReportObject.");
	
КонецФункции

Функция ЭтоТипМенеджера(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНайти(ПредставлениеТипа, "Manager.") > 0;
	
КонецФункции

Функция ТипОбъектаСсылки(ТипСсылки) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТТипыДанныхСлужебный.ТипОбъектаСсылки");
#Иначе
	ТипXML = СериализаторXDTO.XMLТип(ТипСсылки);
	ИмяТипа = СтрЗаменить(ТипXML.ИмяТипа, "Ref.", "Object.");
	
	Возврат СериализаторXDTO.ИзXMLТипа(ИмяТипа, ТипXML.URIПространстваИмен);
#КонецЕсли
	
КонецФункции

Функция ЭтоТипПеречисления(ТипЗначения) Экспорт
	
	ПредставлениеТипа = ПредставлениеТипа(ТипЗначения);
	Возврат СтрНачинаетсяС(ПредставлениеТипа, "EnumRef.");
	
КонецФункции

Функция ОписаниеТиповЛюбаяСсылка(Кешировать = Истина) Экспорт
	
	Если Кешировать Тогда
		Возврат ЮТСлужебныйПовторногоИспользования.ОписаниеТиповЛюбаяСсылка();
	Иначе
#Если ВебКлиент Или ТонкийКлиент Тогда
	Параметры = Новый Массив(1);
	Параметры[0] = Ложь;
	Возврат ЮТМетодыСлужебный.ВызватьФункциюКонфигурацииНаСервере("ЮТТипыДанныхСлужебный", "ОписаниеТиповЛюбаяСсылка", Параметры);
#Иначе
		ЧтениеXML = Новый ЧтениеXML;
		ЧтениеXML.УстановитьСтроку(
		"<TypeDescription xmlns=""http://v8.1c.ru/8.1/data/core"">
		|      <TypeSet xmlns:cc=""http://v8.1c.ru/8.1/data/enterprise/current-config"">cc:AnyRef</TypeSet>
		|</TypeDescription>");
		Возврат СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
#КонецЕсли
	КонецЕсли;
	
КонецФункции

#Область СистемныеПеречисления

Функция ЭтоСистемноеПеречисление(Тип) Экспорт
	
	Возврат ТипыСистемныхПеречислений().СодержитТип(Тип);
	
КонецФункции

Функция ТипыСистемныхПеречислений() Экспорт
	
	Возврат Новый ОписаниеТипов(
		"ВидДвиженияБухгалтерии,
		|ВидДвиженияНакопления,
		|ВидПериодаРегистраРасчета,
		|ВидСчета,
		|ВидТочкиМаршрутаБизнесПроцесса,
		|ИспользованиеГруппИЭлементов,
		|ИспользованиеСреза,
		|ИспользованиеРежимаПроведения,
		|РежимАвтоВремя,
		|РежимЗаписиДокумента,
		|РежимПроведенияДокумента,
		|ПериодичностьАгрегатаРегистраНакопления,
		|ИспользованиеАгрегатаРегистраНакопления");
	
КонецФункции

Функция ИмяСистемногоПеречисления(Тип) Экспорт
	
	Возврат Строка(Тип);
	
КонецФункции

Функция ЭтоКоллекцияПримитивныхТипов(Типы) Экспорт
	
	Для Каждого Тип Из Типы Цикл
		
		Если НЕ ЭтоПримитивныйТип(Тип) Тогда
			Возврат Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Функция ЭтоПримитивныйТип(Тип) Экспорт
	
	ПримитивныеТипы = ЮТСлужебныйПовторногоИспользования.ПримитивныеТипы();
	
	ТипПараметра = ТипЗнч(Тип);
	
	Если ТипПараметра = Тип("Тип") Тогда
		Возврат ПримитивныеТипы.Найти(Тип) <> Неопределено;
	КонецЕсли;
	
	Для Каждого Тип Из Тип.Типы() Цикл
		
		Если ПримитивныеТипы.Найти(Тип) = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

Функция ЭтоСтруктура(ТипЗначения) Экспорт
	
	Возврат ТипЗначения = Тип("Структура")
		Или ТипЗначения = Тип("ФиксированнаяСтруктура");
	
КонецФункции

Функция ЭтоМассива(ТипЗначения) Экспорт
	
	Возврат ТипЗначения = Тип("Массив")
		Или ТипЗначения = Тип("ФиксированныйМассив");
	
КонецФункции

Функция ЭтоСоответствие(ТипЗначения) Экспорт
	
	Возврат ТипЗначения = Тип("Соответствие")
		Или ТипЗначения = Тип("ФиксированноеСоответствие");
	
КонецФункции

Функция ЭтоКлючЗначение(ТипЗначения) Экспорт
	
	Возврат ТипЗначения = Тип("Структура")
		Или ТипЗначения = Тип("ФиксированнаяСтруктура")
		Или ТипЗначения = Тип("Соответствие")
		Или ТипЗначения = Тип("ФиксированноеСоответствие");
	
КонецФункции

Функция НовыйТипСсылки(ОбъектМетаданных) Экспорт
	
	ВидТипа = ?(ЮТОкружение.ИспользуетсяРусскийВстроенныйЯзык(), "Ссылка", "Ref");
	Возврат НовыйТип(ОбъектМетаданных, ВидТипа);
	
КонецФункции

Функция НовыйТипМенеджера(ОбъектМетаданных) Экспорт
	
	ВидТипа = ?(ЮТОкружение.ИспользуетсяРусскийВстроенныйЯзык(), "Менеджер", "Manager");
	Возврат НовыйТип(ОбъектМетаданных, ВидТипа);
	
КонецФункции

Функция НовыйТип(ОбъектМетаданных, ВидТипа = "Ссылка") Экспорт
	
	Если ЮТМетаданныеСлужебный.ЭтоОписаниеОбъектаМетаданных(ОбъектМетаданных) Тогда
		ИмяТипа = СтрШаблон("%1%2.%3", ОбъектМетаданных.ОписаниеТипа.Имя, ВидТипа, ОбъектМетаданных.Имя);
	Иначе
		ИмяТипа = СтрЗаменить(ОбъектМетаданных.ПолноеИмя(), ".", ВидТипа + ".");
	КонецЕсли;
	
	Возврат Тип(ИмяТипа);
	
КонецФункции

#КонецОбласти
