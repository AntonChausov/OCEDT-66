
&НаКлиенте
Процедура ПоказыватьПомеченныхНаУдаление(Команда)
	ПоказыватьПомеченныхНаУдаление = Не ПоказыватьПомеченныхНаУдаление;
    Элементы.ФормаПоказыватьПомеченныхНаУдаление.Пометка = ПоказыватьПомеченныхНаУдаление;
	
	ПолеПометкаУдаления = Новый ПолеКомпоновкиДанных("ПометкаУдаления");
	НайденныйЭлементОтбора = Неопределено;
	Для Каждого ЭлементОтбора Из Список.КомпоновщикНастроек.Настройки.Отбор.Элементы Цикл
		Если ЭлементОтбора.ЛевоеЗначение = ПолеПометкаУдаления Тогда
			НайденныйЭлементОтбора = ЭлементОтбора;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если НайденныйЭлементОтбора = Неопределено Тогда
		НайденныйЭлементОтбора = Список.КомпоновщикНастроек.Настройки.Отбор.Элементы.Добавить(
		Тип("ЭлементОтбораКомпоновкиДанных"));
		НайденныйЭлементОтбора.ЛевоеЗначение = ПолеПометкаУдаления;
	КонецЕсли; 
	
	НайденныйЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	НайденныйЭлементОтбора.ПравоеЗначение = Ложь;
	НайденныйЭлементОтбора.Использование = Не ПоказыватьПомеченныхНаУдаление;	
КонецПроцедуры
