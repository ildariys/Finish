// @strict-types


#Область ПрограммныйИнтерфейс

Процедура РассчитатьСуммыВСтрокеТабличнойЧасти(ДанныеСтроки) Экспорт
	
//	Если ДанныеСтроки.Количество = 0 Или ДанныеСтроки.ЦенаПоставщика = 0 Тогда
//		Возврат;
//	КонецЕсли;
	
	//Сумма
	ДанныеСтроки.Сумма = ДанныеСтроки.Количество * ДанныеСтроки.Цена;
	
	//СуммаНДС
//	СтавкаНДС = УчетНДСВызовСервера.ПолучитьСтавкуНДС(ДанныеСтроки.СтавкаНДС);
//	ДанныеСтроки.СуммаНДС = ДанныеСтроки.Сумма * СтавкаНДС / 100;
	
	//СуммаВсего
	//ДанныеСтроки.СуммаВсего = ДанныеСтроки.Сумма + ДанныеСтроки.СуммаНДС;
	
	///////////////////////

КонецПроцедуры

Процедура ПроверкаДублированияСтрок(ДанныеСтроки, ТабличнаяЧасть, НазваниеКолонки) Экспорт

	//Для каждого ТекущаяСтрока Из ТабличнаяЧасть Цикл
		
		
		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить(НазваниеКолонки, ДанныеСтроки[НазваниеКолонки]);
		КоличествоСовпадений = ТабличнаяЧасть.НайтиСтроки(СтруктураПоиска);
		
		Если КоличествоСовпадений.Количество() > 1 Тогда
			
			Сообщить("Такие данные уже вводились!");
			Возврат;
			
		КонецЕсли;

	//КонецЦикла;

КонецПроцедуры


#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
