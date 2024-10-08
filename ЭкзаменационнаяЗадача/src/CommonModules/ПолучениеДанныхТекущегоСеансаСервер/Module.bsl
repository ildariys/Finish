#Область ПрограммныйИнтерфейс

// Вернуть значение параметра сеанса текущий пользователь.
// 
// Возвращаемое значение:
//  СправочникСсылка.Сотрудники - Вернуть значение параметра сеанса текущий пользователь
Функция ВернутьЗначениеПараметраСеансаТекущийПользователь() Экспорт

	Возврат ПараметрыСеанса.ТекущийПользователь;

КонецФункции

// Функция - Получить ссылку текущего пользователя ИБ
// 
// Параметры:
//  ИдентификаторПользователяИБ -  - 
// 
// Возвращаемое значение:
//  СправочникСсылка.Пользователи - Получить ссылку текущего пользователя ИБ
Функция ПолучитьСсылкуТекущегоПользователяИБ(ИдентификаторПользователяИБ) Экспорт

	Результат = Справочники.Пользователи.ПустаяСсылка();

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Пользователи.Ссылка
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|ГДЕ
	|	Пользователи.ИдентификаторПользователяИБ = &ИдентификаторПользователяИБ";

	Запрос.УстановитьПараметр("ИдентификаторПользователяИБ", ИдентификаторПользователяИБ);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Результат = ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Функция - Вернуть значение параметра сеанса текущий магазин
// 
// Возвращаемое значение:
//  СправочникСсылка.Магазины - Вернуть значение параметра сеанса текущий магазин
Функция ВернутьЗначениеПараметраСеансаТекущийМагазин() Экспорт

	Возврат ПараметрыСеанса.ТекущийМагазин;

КонецФункции

// Функция - Получить ссылку текущего магазина
// 
// Параметры:
//  ИдентификаторПользователяИБ -  - 
// 
// Возвращаемое значение:
//  СправочникСсылка.Магазины - Получить ссылку текущего магазина
Функция ПолучитьСсылкуТекущегоМагазина(ИдентификаторПользователяИБ) Экспорт

	Результат = Справочники.Магазины.ПустаяСсылка();

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Сотрудники.Магазин КАК Магазин
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
	|		ПО Пользователи.Сотрудник = Сотрудники.Ссылка
	|ГДЕ
	|	Пользователи.ИдентификаторПользователяИБ = &ИдентификаторПользователяИБ";

	Запрос.УстановитьПараметр("ИдентификаторПользователяИБ", ИдентификаторПользователяИБ);

	РезультатЗапроса = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Результат = ВыборкаДетальныеЗаписи.Магазин;
	КонецЦикла;

	Возврат Результат;

КонецФункции

#КонецОбласти