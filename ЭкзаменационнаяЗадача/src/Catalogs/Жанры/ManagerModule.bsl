#Область СлужебныеПроцедурыИФункции

Функция СозданиеНовогоЖанра(Наименование) Экспорт

	НовыйЖанр = Справочники.Жанры.СоздатьЭлемент();
	НовыйЖанр.Наименование = Наименование;
	НовыйЖанр.Записать();
	Возврат НовыйЖанр.Ссылка;

КонецФункции

#КонецОбласти