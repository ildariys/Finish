#Область ОбработчикиСобытий

Процедура УстановкаПараметровСеанса(ТребуемыеПараметры)
	

    
	Если ПолучениеДанныхТекущегоСеансаСервер.ПолучитьКоличествоПользователейСистемы() <> Неопределено Тогда
	
		Имя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
		ТекПользователь = ПолучениеДанныхТекущегоСеансаСервер.ВозвратСсылкиНаСотрудника(Имя);
		Если Не ТекПользователь.Сотрудник = Неопределено Тогда 
			ПараметрыСеанса.ТекущийПользователь = ТекПользователь.Сотрудник;
		Иначе
			//TODO Создание сотрудника под текщего пользователя
		КонецЕсли;
		
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти