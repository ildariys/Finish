&НаКлиенте
Процедура ПолучитьКурс(Команда)
	
	//1. определить текущую (выделенную) валюту
	ТекущаяВалюта = Элементы.Список.ТекущаяСтрока;

	ДанныеКурса = ПолучитьКурсВалюты(ТекущаяВалюта);
	
	//3. Сообщаем пользователю данные
	Сообщить("Курс: " + ДанныеКурса.Курс + " за " + ДанныеКурса.Кратность + " ед.");

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьКурсВалюты(ТекущаяВалюта)

	//2. Получение данных из регистра сведений
	СтруктураОтбора = Новый Структура("Валюта", ТекущаяВалюта);

	ДанныеСтруктура = РегистрыСведений.КурсыВалют.ПолучитьПоследнее(ТекущаяДата(), СтруктураОтбора);

	Возврат ДанныеСтруктура;

КонецФункции