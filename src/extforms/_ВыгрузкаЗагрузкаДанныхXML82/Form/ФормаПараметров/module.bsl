﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ

// Управляет признаком выбора типа у поля ввода, редактирующего значения параметра
//
// Параметры:
//	Нет.
//
Процедура УправлениеКолонкамиПараметры()

	ЭлементыФормы.Параметры.Колонки.ЗначениеПараметра.ЭлементУправления.ВыбиратьТип = Не ЭлементыФормы.Параметры.ТекущаяСтрока.ЭтоВыражение;

КонецПроцедуры // УправлениеКолонкамиПараметры()

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ПАРАМЕТРОВ

// Обработчик события при начале редактирования строки параметров
//
Процедура ПараметрыПриНачалеРедактирования(Элемент, НоваяСтрока)

	УправлениеКолонкамиПараметры();

КонецПроцедуры // ПараметрыПриНачалеРедактирования()

// Обработчик события при окончании редактирования строки параметров
//
Процедура ПараметрыПриОкончанииРедактирования(Элемент, НоваяСтрока)

	ВладелецФормы.Модифицированность = Истина;

КонецПроцедуры // ПараметрыПриОкончанииРедактирования()

// Обработчик события перед удалением строки параметров
//
Процедура ПараметрыПередУдалением(Элемент, Отказ)

	ВладелецФормы.Модифицированность = Истина;

КонецПроцедуры // ПараметрыПередУдалением()

// Обработчик изменения флажка "ЭтоВыражение"
//
Процедура ПараметрыПриИзмененииФлажка(Элемент, Колонка)

	Если Колонка.Имя = "ЭтоВыражение" Тогда

		Если Элемент.ТекущаяСтрока.ЭтоВыражение Тогда
			Если Не ТипЗнч(Элемент.ТекущаяСтрока.ЗначениеПараметра) = Тип("Строка") Тогда
				Элемент.ТекущаяСтрока.ЗначениеПараметра = "";
			КонецЕсли; 
		КонецЕсли;

		УправлениеКолонкамиПараметры();

	КонецЕсли; 

КонецПроцедуры // ПараметрыПриИзмененииФлажка()

// Обработчик нажатия кнопки командной панели "Дополнить из запроса"
//
Процедура КоманднаяПанельФормыПолучитьИзЗапроса(Кнопка)
	ТекстЗапроса = ВладелецФормы.ЭлементыФормы.ТекстЗапроса.ПолучитьТекст();
	Запрос = Новый Запрос(ТекстЗапроса);
	Попытка
		ПараметрыЗапроса = Запрос.НайтиПараметры();
	Исключение
		Предупреждение(ОписаниеОшибки());
		Возврат;
	КонецПопытки;
	Для каждого ПараметрЗапроса Из ПараметрыЗапроса Цикл
		ИмяПараметра =  ПараметрЗапроса.Имя;
		СтрокаПараметров = Параметры.Найти(ИмяПараметра,"ИмяПараметра");
		Если  СтрокаПараметров = Неопределено Тогда
			СтрокаПараметров = Параметры.Добавить();
			СтрокаПараметров.ИмяПараметра = ИмяПараметра;
		КонецЕсли; 
		СтрокаПараметров.ЗначениеПараметра = ПараметрЗапроса.ТипЗначения.ПривестиЗначение(СтрокаПараметров.ЗначениеПараметра);
	КонецЦикла; 
КонецПроцедуры

