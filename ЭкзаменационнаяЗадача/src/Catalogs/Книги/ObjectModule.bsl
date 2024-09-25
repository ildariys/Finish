#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	#Область ОбработчикиСобытий
	
	Процедура ПередЗаписью(Отказ)
		
		Если ОбменДанными.Загрузка Тогда
			
			Возврат;
		КонецЕсли;
		
		Записать = Истина;
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	Книги.Ссылка
		|ИЗ
		|	Справочник.Книги КАК Книги
		|ГДЕ
		|	Книги.КодISBN = &КодISBN
		|	И Книги.Ссылка <> &Ссылка";
		
		Запрос.УстановитьПараметр("КодISBN", КодISBN);
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Если Не РезультатЗапроса.Пустой() Тогда
			
			Записать = Ложь;
		КонецЕсли;
		
		Если Не Записать Тогда
			
			Сообщить("Запись с таким КодISBN уже существует!");
			Отказ = Истина;
		КонецЕсли;
		
	КонецПроцедуры
	
	#КонецОбласти
	
#КонецЕсли