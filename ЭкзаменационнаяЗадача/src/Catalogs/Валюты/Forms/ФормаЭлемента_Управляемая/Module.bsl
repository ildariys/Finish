#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	СтруктураОтбора = Новый Структура("Валюта", Объект.Ссылка);
	ДанныеКурса = РегистрыСведений.КурсыВалют.ПолучитьПоследнее(ТекущаяДата(), СтруктураОтбора);

	Курс = ДанныеКурса.Курс;

КонецПроцедуры

#КонецОбласти