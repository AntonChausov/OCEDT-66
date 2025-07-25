Процедура СформироватьПрайсЛист(ТабличныйДокумент, Ссылки)Экспорт 
	
	Макет = ПолучитьМакет("ПрайсЛист");
	
	// Получаем область шапки и макета по имени
	Шапка = Макет.ПолучитьОбласть("Шапка");
	// Заполняем параметр Дата
	Шапка.Параметры.Дата = Формат(ТекущаяДата(), "ДФ=dd.MM.yyyy"); 
	// Выводим область в документ
	ТабличныйДокумент.Вывести(Шапка);
	
	// Получаем область заголовка
	ТабличнаяЧастьЗаголовок = Макет.ПолучитьОбласть("ТабличнаяЧастьЗаголовок");
	ТабличныйДокумент.Вывести(ТабличнаяЧастьЗаголовок);
	
	// Получаем область строк для формирования табличной части в цикле
	ТабличнаяЧастьСтрока = Макет.ПолучитьОбласть("ТабличнаяЧастьСтрока");
	
	Для каждого СсылкаНоменклатура из Ссылки Цикл
		ТабличнаяЧастьСтрока.Параметры.Товар = СсылкаНоменклатура; 
		ТабличнаяЧастьСтрока.Параметры.Цена = ПолучитьЦенуНоменклатуры(СсылкаНоменклатура); 
		ТабличныйДокумент.Вывести(ТабличнаяЧастьСтрока);
	КонецЦикла;
	        
КонецПроцедуры

Функция ПолучитьЦенуНоменклатуры(СсылкаНоменклатура) 
	
	Отбор = Новый Структура("Номенклатура", СсылкаНоменклатура);
	ПоследняяЗапись = РегистрыСведений.ЦеныПродажиНоменклатуры.ПолучитьПоследнее(ТекущаяДата(), Отбор);
	Возврат ПоследняяЗапись.Цена;
	
КонецФункции