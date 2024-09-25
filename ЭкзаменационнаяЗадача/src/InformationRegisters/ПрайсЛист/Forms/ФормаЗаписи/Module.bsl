// @strict-types


#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

// Код процедур и функций


&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустой() Тогда

		Запись.Ответственный = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийПользователь();
		Запись.Склад = ПолучениеДанныхТекущегоСеансаСервер.ВернутьЗначениеПараметраСеансаТекущийМагазин();

	КонецЕсли;
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций


&НаКлиенте
Процедура КнигаПриИзменении(Элемент)
	//КнигаПриИзмененииНаСервере(Книга);
КонецПроцедуры

//&НаСервереБезКонтекста
//Процедура КнигаПриИзмененииНаСервере(Книга)
//	
//	//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
//	// Данный фрагмент построен конструктором.
//	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!
//	
//	Запрос = Новый Запрос;
//	Запрос.Текст =
//		"ВЫБРАТЬ
//		|	ОстаткиНомеклатурыОстатки.КоличествоОстаток,
//		|	УчетПоступления.Книга,
//		|	УчетПоступления.Цена
//		|ИЗ
//		|	РегистрНакопления.ОстаткиНоменклатуры.Остатки(, Книга = &Книга
//		|	И Склад = &Склад) КАК ОстаткиНомеклатурыОстатки
//		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.УчетПоступления КАК УчетПоступления
//		|		ПО ОстаткиНомеклатурыОстатки.Книга = УчетПоступления.Книга";
//	
//	Запрос.УстановитьПараметр("Склад", Склад);
//	Запрос.УстановитьПараметр("Книга", Книга);
//	
//	РезультатЗапроса = Запрос.Выполнить();
//	
//	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
//	
//	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
//		// Вставить обработку выборки ВыборкаДетальныеЗаписи
//	КонецЦикла;
//	
//	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
//	
//
//КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти
