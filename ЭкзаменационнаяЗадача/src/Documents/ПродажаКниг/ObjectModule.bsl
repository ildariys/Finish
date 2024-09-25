#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс


Процедура ОбработкаПроведения(Отказ, Режим)
	НоменклатурыХватает = Истина;
	МетодРасчета = ОбщегоНазначенияСервер.ПолучитьУчетнуюПолитикуОрганизации(Дата);
	
	Если МетодРасчета = Перечисления.СпособСписания.ПоСредней Тогда
		
		Блокировка = Новый БлокировкаДанных;
		
		ЭлБлокировки = Блокировка.Добавить("РегистрНакопления.ОстаткиНоменклатуры");
		ЭлБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		
		ЭлБлокировки.УстановитьЗначение("Склад", Склад);
		
		ЭлБлокировки.ИсточникДанных = СписокКниг;
		ЭлБлокировки.ИспользоватьИзИсточникаДанных("Книга", "Книга");
		
		Блокировка.Заблокировать();
		//
		//!!! УДАЛЕНИЕ СОБСТВЕННЫХ СТАРЫХ ДВИЖЕНИЙ!!!!
		Движения.ОстаткиНоменклатуры.Записать();
	//	Движения.БронированиеТоваров.Записывать();
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ПродажаТоваровТовары.Книга КАК Книга,
		|	СУММА(ПродажаТоваровТовары.Количество) КАК КолДок,
		|	ПродажаТоваровТовары.Ссылка.Склад КАК Склад
		|ПОМЕСТИТЬ ТабДок
		|ИЗ
		|	Документ.ПродажаКниг.СписокКниг КАК ПродажаТоваровТовары
		|ГДЕ
		|	ПродажаТоваровТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ПродажаТоваровТовары.Книга,
		|	ПродажаТоваровТовары.Ссылка.Склад
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Книга,
		|	Склад
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	БронированиеТоваровОстатки.Книга КАК Книга,
		|	БронированиеТоваровОстатки.КоличествоЗабронированногоОстаток КАК КоличествоЗабронированногоОстаток
		|ПОМЕСТИТЬ ВТ_Бронь
		|ИЗ
		|	РегистрНакопления.БронированиеТоваров.Остатки(
		|			&МоментВремени,
		|			Книга В
		|					(ВЫБРАТЬ
		|						ТабДок.Книга
		|					ИЗ
		|						ТабДок)
		|				И Склад В
		|					(ВЫБРАТЬ
		|						ТабДок.Склад
		|					ИЗ
		|						ТабДок)) КАК БронированиеТоваровОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ОстаткиНоменклатурыОстатки.Книга КАК Книга,
		|	ОстаткиНоменклатурыОстатки.КоличествоОстаток КАК КоличествоОстаток,
		|	ОстаткиНоменклатурыОстатки.СуммаОстаток КАК СуммаОстаток
		|ПОМЕСТИТЬ ВТ_Ост
		|ИЗ
		|	РегистрНакопления.ОстаткиНоменклатуры.Остатки(
		|			&МоментВремени,
		|			Книга В
		|					(ВЫБРАТЬ
		|						ТабДок.Книга
		|					ИЗ
		|						ТабДок)
		|				И Склад В
		|					(ВЫБРАТЬ
		|						ТабДок.Склад
		|					ИЗ
		|						ТабДок)) КАК ОстаткиНоменклатурыОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТабДок.Книга КАК Книга,
		|	ТабДок.КолДок КАК КолДок,
		|	ТабДок.Склад КАК Склад,
		|	ЕСТЬNULL(ВТ_Ост.КоличествоОстаток, 0) КАК КолОст,
		|	ЕСТЬNULL(ВТ_Ост.СуммаОстаток, 0) КАК СуммаОст,
		|	ЕСТЬNULL(ВТ_Бронь.КоличествоЗабронированногоОстаток, 0) КАК БроньОст
		|ИЗ
		|	ТабДок КАК ТабДок
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Бронь КАК ВТ_Бронь
		|		ПО ТабДок.Книга = ВТ_Бронь.Книга
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Ост КАК ВТ_Ост
		|		ПО ТабДок.Книга = ВТ_Ост.Книга";
		
		Запрос.УстановитьПараметр("МоментВремени", МоментВремени());
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Движения.ОстаткиНоменклатуры.Записывать = Истина;
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
			Движение = Движения.ОстаткиНоменклатуры.Добавить();
			
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			
			Движение.Период = Дата;
			
			Движение.Книга = ВыборкаДетальныеЗаписи.Книга;
			Движение.Склад = ВыборкаДетальныеЗаписи.Склад;
			Движение.Количество = ВыборкаДетальныеЗаписи.КолДок;
			
			Если ВыборкаДетальныеЗаписи.КолДок > (ВыборкаДетальныеЗаписи.КолОст - ВыборкаДетальныеЗаписи.БроньОст) Тогда
				
				Нехватка = ВыборкаДетальныеЗаписи.КолДок - ВыборкаДетальныеЗаписи.КолОст
				- ВыборкаДетальныеЗаписи.БроньОст;
				
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = "Не хватает " + Нехватка + " шт. товара " + ВыборкаДетальныеЗаписи.Книга
				+ " в Продажа товаров " + Номер + " от " + Дата;
				Сообщение.Сообщить();
				НоменклатурыХватает = Ложь;
			ИначеЕсли ВыборкаДетальныеЗаписи.КолДок = ВыборкаДетальныеЗаписи.КолОст Тогда
				
				Движение.Сумма = ВыборкаДетальныеЗаписи.СуммаОст;
				
			ИначеЕсли ВыборкаДетальныеЗаписи.КолДок < ВыборкаДетальныеЗаписи.КолОст Тогда
				
				Движение.Сумма = ВыборкаДетальныеЗаписи.КолДок * ВыборкаДетальныеЗаписи.СуммаОст
				/ ВыборкаДетальныеЗаписи.КолОст;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Движения.БронированиеТоваров.Записывать = Истина;
		
	Иначе
		
		Блокировка = Новый БлокировкаДанных;
		
		ЭлБлокировки = Блокировка.Добавить("РегистрНакопления.ОстаткиНоменклатуры");
		ЭлБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		
		ЭлБлокировки.УстановитьЗначение("Склад",Склад);
		
		ЭлБлокировки.ИсточникДанных = СписокКниг;
		ЭлБлокировки.ИспользоватьИзИсточникаДанных("Книга","Книга");	
		
		Блокировка.Заблокировать();
		//
		//!!! УДАЛЕНИЕ СОБСТВЕННЫХ СТАРЫХ ДВИЖЕНИЙ!!!!
		Движения.ОстаткиНоменклатуры.Записать();
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПродажаТоваровТовары.Книга КАК Книга,
		|	СУММА(ПродажаТоваровТовары.Количество) КАК КолДок,
		|	ПродажаТоваровТовары.Ссылка.Склад КАК Склад
		|ПОМЕСТИТЬ ТабДок
		|ИЗ
		|	Документ.ПродажаКниг.СписокКниг КАК ПродажаТоваровТовары
		|ГДЕ
		|	ПродажаТоваровТовары.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ПродажаТоваровТовары.Книга,
		|	ПродажаТоваровТовары.Ссылка.Склад
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Книга,
		|	Склад
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ОстаткиНоменклатурыОстатки.Книга КАК Книга,
		|	ОстаткиНоменклатурыОстатки.Партия КАК Партия,
		|	ОстаткиНоменклатурыОстатки.КоличествоОстаток КАК КоличествоОстаток,
		|	ОстаткиНоменклатурыОстатки.СуммаОстаток КАК СуммаОстаток
		|ПОМЕСТИТЬ ВТ_Остатки
		|ИЗ
		|	РегистрНакопления.ОстаткиНоменклатуры.Остатки(
		|			&Момент,
		|			Книга В
		|					(ВЫБРАТЬ
		|						ТабДок.Книга
		|					ИЗ
		|						ТабДок)
		|				И Склад В
		|					(ВЫБРАТЬ
		|						ТабДок.Склад
		|					ИЗ
		|						ТабДок)) КАК ОстаткиНоменклатурыОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	БронированиеТоваровОстатки.Книга КАК Книга,
		|	БронированиеТоваровОстатки.КоличествоЗабронированногоОстаток КАК КоличествоЗабронированногоОстаток
		|ПОМЕСТИТЬ ВТ_Бронь
		|ИЗ
		|	РегистрНакопления.БронированиеТоваров.Остатки(
		|			&Момент,
		|			Книга В
		|					(ВЫБРАТЬ
		|						ТабДок.Книга
		|					ИЗ
		|						ТабДок)
		|				И Склад В
		|					(ВЫБРАТЬ
		|						ТабДок.Склад
		|					ИЗ
		|						ТабДок)) КАК БронированиеТоваровОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ТабДок.Книга КАК Книга,
		|	ТабДок.КолДок КАК КолДок,
		|	ТабДок.Склад КАК Склад,
		|	ЕСТЬNULL(ВТ_Бронь.КоличествоЗабронированногоОстаток, 0) КАК БроньОст,
		|	ЕСТЬNULL(ВТ_Остатки.КоличествоОстаток, 0) КАК КолОст,
		|	ЕСТЬNULL(ВТ_Остатки.СуммаОстаток, 0) КАК СуммаОст,
		|	ВТ_Остатки.Партия КАК Партия,
		|	ПродажаКниг.Дата КАК ПартияДата
		|ИЗ
		|	ТабДок КАК ТабДок
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Остатки КАК ВТ_Остатки
		|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПродажаКниг КАК ПродажаКниг
		|			ПО ВТ_Остатки.Партия = ПродажаКниг.Ссылка
		|		ПО ТабДок.Книга = ВТ_Остатки.Книга
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_Бронь КАК ВТ_Бронь
		|		ПО ТабДок.Книга = ВТ_Бронь.Книга
		|
		|УПОРЯДОЧИТЬ ПО
		|	Книга
		|ИТОГИ
		|	МАКСИМУМ(КолДок),
		|	МАКСИМУМ(БроньОст),
		|	СУММА(КолОст),
		|	СУММА(СуммаОст)
		|ПО
		|	Книга";	
		
		Запрос.УстановитьПараметр("Момент", МоментВремени());
		Запрос.УстановитьПараметр("Ссылка", Ссылка); 
		
		
		Если МетодРасчета = Перечисления.СпособСписания.FIFO Тогда 
			
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "УБЫВ", "Возр");
			
		КонецЕсли;		  
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаНоменклатура = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
		
		Движения.ОстаткиНоменклатуры.Записывать = Истина;
		
		Пока ВыборкаНоменклатура.Следующий() Цикл   		
			
			Если   ВыборкаНоменклатура.КолДок > (ВыборкаНоменклатура.КолОст - ВыборкаНоменклатура.БроньОст) Тогда 
				
				Нехватка = ВыборкаНоменклатура.КолДок - ВыборкаНоменклатура.КолОст  - ВыборкаНоменклатура.БроньОст;
				
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = "Не хватает " +Нехватка+   " шт. товара "+ВыборкаНоменклатура.Книга+
				" в Продажа товаров "+Номер+" от "+Дата;
				Сообщение.Сообщить();
				НоменклатурыХватает = Ложь;
				Продолжить;
				
			КонецЕсли; 		
			
			ВыборкаДетальныеЗаписи = ВыборкаНоменклатура.Выбрать(); 
			
			КоличествоНадоСписать  = ВыборкаНоменклатура.КолДок;
			
			Пока ВыборкаДетальныеЗаписи.Следующий() и КоличествоНадоСписать <> 0   Цикл
				
				Движение = Движения.ОстаткиНоменклатуры.Добавить(); 
				
				Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
				
				Движение.Период = Дата;
				
				Движение.Книга = ВыборкаДетальныеЗаписи.Книга;
				Движение.Склад = ВыборкаДетальныеЗаписи.Склад;
				
				Если КоличествоНадоСписать >=  ВыборкаДетальныеЗаписи.КолОст Тогда
					
					Движение.Сумма = ВыборкаДетальныеЗаписи.СуммаОст; 
					Движение.Количество = ВыборкаДетальныеЗаписи.КолОст;  
					Движение.Партия = ВыборкаДетальныеЗаписи.Партия;  
					
					КоличествоНадоСписать = КоличествоНадоСписать -  ВыборкаДетальныеЗаписи.КолОст;
					
				ИначеЕсли КоличествоНадоСписать <  ВыборкаДетальныеЗаписи.КолОст Тогда 
					
					Движение.Сумма = КоличествоНадоСписать * ВыборкаДетальныеЗаписи.СуммаОст / ВыборкаДетальныеЗаписи.КолОст;
					Движение.Количество = КоличествоНадоСписать;  
					Движение.Партия = ВыборкаДетальныеЗаписи.Партия;  
					
				КонецЕсли;
				
			КонецЦикла;
		КонецЦикла;
		
		Движения.БронированиеТоваров.Записывать = Истина;
		
	КонецЕсли;
	
	// регистр Выручка 
	Движения.Выручка.Записывать = Истина;
	Для Каждого ТекСтрокаСписокКниг Из СписокКниг Цикл
		Движение = Движения.Выручка.Добавить();
		Движение.Период = Дата;
		Движение.Магазин = Склад;
		Движение.Оператор = Оператор;
		Движение.Сумма = Сумма;
	КонецЦикла;
	Движения.Выручка.Записать(); 
	
	// регистр ДенежныеСредстваСети Приход
	Движения.ДенежныеСредстваСети.Записывать = Истина;
	Движение = Движения.ДенежныеСредстваСети.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Магазин = Склад;
	Движение.ДенежныеСредства = Сумма;
	Движения.ДенежныеСредстваСети.Записать(); 
	
	Если Не НоменклатурыХватает Тогда
	
		Отказ = Истина;
	
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытий

// Код процедур и функций

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс


#КонецОбласти

#Область СлужебныеПроцедурыИФункции


#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
