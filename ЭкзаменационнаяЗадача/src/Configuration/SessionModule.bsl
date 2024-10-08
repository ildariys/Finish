#Область ОбработчикиСобытий

Процедура УстановкаПараметровСеанса(ТребуемыеПараметры)

	ПользовательИБ 					= ПользователиИнформационнойБазы.ТекущийПользователь();
	ИдентификаторПользователяИБ 	= ПользовательИБ.УникальныйИдентификатор;

	ПараметрыСеанса.ТекущийПользователь 
		= ПолучениеДанныхТекущегоСеансаСервер.ПолучитьСсылкуТекущегоПользователяИБ(ИдентификаторПользователяИБ);
	ПараметрыСеанса.ТекущийМагазин
		=ПолучениеДанныхТекущегоСеансаСервер.ПолучитьСсылкуТекущегоМагазина(ИдентификаторПользователяИБ);

КонецПроцедуры

#КонецОбласти