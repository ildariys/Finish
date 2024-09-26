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

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты.ДобавитьТест("СравнитьВерсии")
	.СПараметрами("1.0", "2.0", -1)
	.СПараметрами("1.0.1", "1.0.2", -1)
	.СПараметрами("1.0", "1.0.1", 0)
	.СПараметрами("1.10", "1.9", 1)
	.СПараметрами("1.10.2.2", "1.10.2.2", 0);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СравнитьВерсии(Версия1, Версия2, ОжидаемыйРезультат) Экспорт
	
	Результат = СравнитьВерсииРеализации(Версия1, Версия2);
	ЮТест.ОжидаетЧто(Результат)
	.ИмеетТип("Число")
	.Равно(ОжидаемыйРезультат);
	
КонецПроцедуры

Функция СравнитьВерсииРеализации(СтрокаВерсии1, СтрокаВерсии2) 
	Массив1 = Новый Массив;
	Массив2 = Новый Массив;
	Массив1 = СтрРазделить(СтрокаВерсии1, ".", Ложь);
	Массив2 = СтрРазделить(СтрокаВерсии2, ".", Ложь);
	Если Массив1.Количество() >= Массив2.Количество() Тогда
		МАКСРазряд = Массив2.Количество() - 1;
	Иначе
		МАКСРазряд = Массив1.Количество() - 1;
	КонецЕсли;
	
			
	Результат = 0;
	
	Для Разряд = 0 По МАКСРазряд Цикл
		Результат = Число(Массив1[Разряд]) - Число(Массив2[Разряд]);		
		Если Результат <> 0 Тогда
			Возврат Результат;
		КонецЕсли;
	КонецЦикла;
	Возврат Результат;
	
	
	
КонецФункции

#КонецОбласти
