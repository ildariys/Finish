#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПолучитьКурсы(Команда)

	Если Не ЗначениеЗаполнено(Объект.ДатаЗагрузки) Тогда

		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Укажите дату загрузки!";
		Сообщение.Поле = "Объект.ДатаЗагрузки";
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;

	ПолучитьКурсыНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьКурсы(Команда)

	ЗаписатьКурсыНаСервере();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПолучитьКурсыНаСервере()

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ПолучитьКурсы();
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");

КонецПроцедуры

&НаСервере
Процедура ЗаписатьКурсыНаСервере()

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ЗаписатьКурсы();
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");

КонецПроцедуры

#КонецОбласти