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
 	
 	ЮТТесты.ДобавитьТест("Сложение")
 		.СПараметрами(2, 3, 5)
 		.СПараметрами(2, -3, -1)
 		.СПараметрами("2", "-3", "2-3")
 		.СПараметрами("2", -3, "2-3")
 		;
 		
 КонецПроцедуры
 
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Процедура Сложение(ПервыйОперанд, ВторойОперанд, Результат) Экспорт
	
	РезультатСложения = ПервыйОперанд + ВторойОперанд;
	ЮТест.ОжидаетЧто(РезультатСложения)
	.Заполнено()
	.ИмеетТип("Число, Строка")
	.Равно(Результат);
	
КонецПроцедуры
#КонецОбласти
