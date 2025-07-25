
&НаКлиенте
Процедура АдресФотоНажатие(Элемент, СтандартнаяОбработка)
	   // отключаем стандартную обработку, т.к. стандартное действие для обработки нажатия на строку - вывести ее содержимое в предупреждении, нам это не нужно.
	СтандартнаяОбработка = Ложь;
	ВыбратьФайлФото();

КонецПроцедуры

&НаКлиенте
Асинх Процедура ВыбратьФайлФото()

	ПараметрыДиалога = Новый ПараметрыДиалогаПомещенияФайлов;
	ПараметрыДиалога.Заголовок = "Выберите фотографию";
	ПараметрыДиалога.Фильтр = "Картинки|*.jpg; *.png";
	ПараметрыДиалога.МножественныйВыбор = Ложь;

	ОписаниеФайла = Ждать ПоместитьФайлНаСерверАсинх( , , , ПараметрыДиалога, УникальныйИдентификатор);

	Если ОписаниеФайла = Неопределено Тогда
		Возврат;
	КонецЕсли;

	АдресФото = ОписаниеФайла.Адрес;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	ДвоичныеДанныеФотографии = ПолучитьИзВременногоХранилища(АдресФото);
	ДанныеВХранилище = Новый ХранилищеЗначения(ДвоичныеДанныеФотографии);
	ТекущийОбъект.Фотография = ДанныеВХранилище;

КонецПроцедуры   

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	ДвоичныеДанныеФотографии = ТекущийОбъект.Фотография.Получить();
	АдресФото = ПоместитьВоВременноеХранилище(ДвоичныеДанныеФотографии, УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Процедура СохранитьФото(Команда)
	АдресРезультата = ПодготовитьКартинку(АдресФото, УникальныйИдентификатор);

	// Если для номенклатуры не загружена картика, то не будем открывать окно сохранения файла
	Если Не ЗначениеЗаполнено(АдресРезультата) Тогда
		Возврат;
	КонецЕсли;

	ПараметрыПолученияФайла = Новый ПараметрыДиалогаПолученияФайлов;
	ПолучитьФайлССервераАсинх(АдресРезультата, Объект.Наименование + ".jpg", ПараметрыПолученияФайла);

КонецПроцедуры

&НаСервереБезКонтекста
Функция ПодготовитьКартинку(АдресФото, УИДФормы)

	ДвоичныеДанныеИзображения = ПолучитьИзВременногоХранилища(АдресФото);

	Если ДвоичныеДанныеИзображения = Неопределено Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Фотография не загружена";
		Сообщение.Сообщить();
		Возврат Неопределено;
	КонецЕсли;

	Картинка = Новый Картинка(ДвоичныеДанныеИзображения);                              

	Если Картинка.Ширина() = 100 Тогда 
		// Если ширина уже 100 пикселей, не надо обрабатывать, просто вернем тот же адрес
		Возврат АдресФото;
	КонецЕсли;

	ОбрабатываемаяКартинка = Новый ОбрабатываемаяКартинка(Картинка);
	ОбрабатываемаяКартинка.УстановитьРазмер(100, Неопределено);

	Картинка = ОбрабатываемаяКартинка.ПолучитьКартинку();

	ДвоичныеДанныеИзображения = Картинка.ПолучитьДвоичныеДанные();

	АдресОбработаннойКартинки = ПоместитьВоВременноеХранилище(ДвоичныеДанныеИзображения, УИДФормы);
	Возврат АдресОбработаннойКартинки;

КонецФункции

