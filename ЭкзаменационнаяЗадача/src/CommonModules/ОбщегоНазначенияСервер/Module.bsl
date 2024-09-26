#Область СлужебныеПроцедурыИФункции

// Получить значение наценки.
// 
// Возвращаемое значение:
//  Произвольный, Число - Получить значение наценки
Функция ПолучитьЗначениеНаценки() Экспорт

	Возврат Константы.НаценкаВПроцентах.Получить();

КонецФункции

// Функция - Получить значение текущего магазина
// 
// Параметры:
//  СсылкаСотрудника -  - 
// 
// Возвращаемое значение:
//  Неопределено - Получить значение текущего магазина
Функция ПолучитьЗначениеТекущегоМагазина(СсылкаСотрудника) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Сотрудники.Магазин КАК Магазин
	|ИЗ
	|	Справочник.Сотрудники КАК Сотрудники
	|ГДЕ
	|	Сотрудники.Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка", СсылкаСотрудника);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Если ВыборкаДетальныеЗаписи.Следующий() Тогда

		Возврат ВыборкаДетальныеЗаписи.Магазин;
	Иначе

		Возврат Неопределено;
	КонецЕсли;

КонецФункции

// Функция - Получение текущего курса валюты
//
// Параметры:
//  ТекущаяВалюта	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
Функция ПолучениеТекущегоКурсаВалюты(ТекущаяВалюта) Экспорт

	Результат = Новый Структура;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КурсыВалютСрезПоследних.Курс,
	|	КурсыВалютСрезПоследних.Кратность
	|ИЗ
	|	РегистрСведений.КурсыВалют.СрезПоследних(, Валюта = &Валюта) КАК КурсыВалютСрезПоследних";

	Запрос.УстановитьПараметр("Валюта", ТекущаяВалюта);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Результат.Вставить("Курс", ВыборкаДетальныеЗаписи.Курс);
		Результат.Вставить("Кратность", ВыборкаДетальныеЗаписи.Кратность);
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Функция - Количество пользователей системы
// 
// Возвращаемое значение:
//  Неопределено - Количество пользователей системы
Функция КоличествоПользователейСистемы() Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Пользователи.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО Пользователи.Сотрудник = Сотрудники.Ссылка";

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Возврат ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;

	Возврат Неопределено;
КонецФункции // КоличествоПользователейСистемы()

// Функция - Сумма документа поступления
// 
// Параметры:
//  ДокументСсылка -  - 
// 
// Возвращаемое значение:
//  Неопределено - Сумма документа поступления
Функция СуммаДокументаПоступления(ДокументСсылка) Экспорт

	Результат = Неопределено;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПоступлениеКниг.Сумма КАК Сумма
	|ИЗ
	|	Документ.ПоступлениеКниг КАК ПоступлениеКниг
	|ГДЕ
	|	ПоступлениеКниг.Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Результат = ВыборкаДетальныеЗаписи.Сумма;
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Функция - Получить остаток средст магазина
// 
// Параметры:
//  Дата -  - 
//  Магазин -  - 
// 
// Возвращаемое значение:
//  Число - Получить остаток средст магазина
Функция ПолучитьОстатокСредстМагазина(Дата, Магазин) Экспорт

	Результат = 0;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ДенежныеСредстваСетиОстатки.ДенежныеСредстваОстаток КАК ДенежныеСредстваОстаток
	|ИЗ
	|	РегистрНакопления.ДенежныеСредстваСети.Остатки(&Период, Магазин = &Магазин) КАК ДенежныеСредстваСетиОстатки";

	Запрос.УстановитьПараметр("Магазин", Магазин);
	Запрос.УстановитьПараметр("Период", Дата);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Результат = ВыборкаДетальныеЗаписи.ДенежныеСредстваОстаток;
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Функция - Получить учетную политику организации
// 
// Параметры:
//  Дата -  - 
// 
// Возвращаемое значение:
//  Неопределено - Получить учетную политику организации
Функция ПолучитьУчетнуюПолитикуОрганизации(Дата) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	УчетнаяПолитикаСрезПоследних.МетодРасчета КАК МетодРасчета
	|ИЗ
	|	РегистрСведений.УчетнаяПолитика.СрезПоследних(&Дата) КАК УчетнаяПолитикаСрезПоследних";

	Запрос.УстановитьПараметр("Дата", Дата);

	РезультатЗапроса = Запрос.Выполнить();

	Если Не РезультатЗапроса.Пустой() Тогда

		Выборка = РезультатЗапроса.Выбрать();

		Выборка.Следующий();

		МетодРасчета = Выборка.МетодРасчета;

	Иначе

		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не установлена учетная политика";
		Сообщение.Сообщить();

		МетодРасчета = Неопределено;
	КонецЕсли;

	Возврат МетодРасчета;

КонецФункции

#КонецОбласти