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

Функция ОписаниеЗапроса(ИмяТаблицы, ПредикатыУсловия, ВыбираемыеПоля = Неопределено) Экспорт
	
	Описание = ЮТЗапросы.ОписаниеЗапроса();
	Описание.ИмяТаблицы = ИмяТаблицы;
	Если ВыбираемыеПоля = Неопределено Тогда
		Описание.ВыбираемыеПоля.Добавить("1 КАК Проверка");
	Иначе
		ЗаполнитьВыбираемыеПоля(Описание, ВыбираемыеПоля);
	КонецЕсли;
	
	Если ПредикатыУсловия <> Неопределено Тогда
		Описание.Условия = ЮТПредикатыСлужебныйКлиентСервер.НаборПредикатов(ПредикатыУсловия);
	КонецЕсли;
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьВыбираемыеПоля(ОписаниеЗапроса, Знач ВыбираемыеПоля)
	
	ТипПараметра = ТипЗнч(ВыбираемыеПоля);
	
	Если ТипПараметра = Тип("Строка") Тогда
		ВыбираемыеПоля = ЮТСтроки.РазделитьСтроку(ВыбираемыеПоля, ",");
		ТипПараметра = Тип("Массив");
	КонецЕсли;
	
	Если ТипПараметра = Тип("Массив") Тогда
		
		ОписаниеЗапроса.ВыбираемыеПоля = ВыбираемыеПоля;
		
	ИначеЕсли ТипПараметра = Тип("Структура") Тогда
		
		Для Каждого Поле Из ВыбираемыеПоля Цикл
			Выражение = СтрШаблон("%1 КАК %2", Поле.Значение, Поле.Ключ);
			ОписаниеЗапроса.ВыбираемыеПоля.Добавить(Выражение);
		КонецЦикла;
		
	Иначе
		
		ВызватьИсключение ЮТИсключения.НеподдерживаемыйПараметрМетода("ЮТЗапросыКлиентСервер.ЗаполнитьВыбираемыеПоля", ВыбираемыеПоля);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
