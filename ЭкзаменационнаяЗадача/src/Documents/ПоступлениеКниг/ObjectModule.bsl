
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ПрайсЛист
	Движения.ПрайсЛист.Записывать = Истина;
	Для Каждого ТекСтрокаСписокКниг Из СписокКниг Цикл
		Движение = Движения.ПрайсЛист.Добавить();
		Движение.Период = Дата;
		Движение.Книга = ТекСтрокаСписокКниг.НазваниеКниги;
		Движение.Поставщик = Поставщик;
		Движение.ЗакупочнаяЦена = ТекСтрокаСписокКниг.ЦенаПоставщика * ТекущийКурс;
		Движение.РозничнаяЦена = ТекСтрокаСписокКниг.РозничнаяЦена * ТекущийКурс;
	КонецЦикла;

	// регистр УчетПоступления Приход
	Движения.УчетПоступления.Записывать = Истина;
	Для Каждого ТекСтрокаСписокКниг Из СписокКниг Цикл
		Движение = Движения.УчетПоступления.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Книга = ТекСтрокаСписокКниг.НазваниеКниги;
		Движение.Контрагент = Поставщик;
		Движение.Количество = ТекСтрокаСписокКниг.Количество;
	КонецЦикла;

	// регистр Взаиморасчеты Расход
	Движения.Взаиморасчеты.Записывать = Истина;
	Для Каждого ТекСтрокаСписокКниг Из СписокКниг Цикл
		Движение = Движения.Взаиморасчеты.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Контрагент = Поставщик;
		Движение.Долг = Сумма;
	КонецЦикла;

	// регистр НаличиеКнигНаСкладах Приход
	Движения.НаличиеКнигНаСкладах.Записывать = Истина;
	Для Каждого ТекСтрокаСписокКниг Из СписокКниг Цикл
		Движение = Движения.НаличиеКнигНаСкладах.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Склад = Склад;
		Движение.Книга = ТекСтрокаСписокКниг.НазваниеКниги;
		Движение.Количество = ТекСтрокаСписокКниг.Количество;
	КонецЦикла;

КонецПроцедуры

