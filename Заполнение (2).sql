-- Вставка тестовых данных для Владелец_Авто (10 клиентов)
INSERT INTO Владелец_Авто (Имя, Фамилия, Отчество, Телефон, Адрес, Номер_ВУ)
VALUES
    ('Иван', 'Иванов', 'Иванович', '89836201487', 'Москва, Пушкина 19', '4569785413'),
    ('Петр', 'Петров', 'Петрович', '89005551122', 'Санкт-Петербург, Ленина 5', '6932541201'),
    ('Анна', 'Сидорова', 'Игоревна', '89632014785', 'Казань, ул. Советская 7', 'QWE567'),
    ('Сергей', 'Кузнецов', 'Владимирович', '89523014578', 'Екатеринбург, Заречная 12', '5620145789'),
    ('Елена', 'Васнецова', 'Александровна', '9876543210', 'Омск, Гагарина 32', '4569871230'),
    ('Дмитрий', 'Козлов', 'Анатольевич', '89652301478', 'Омск, Королева 10', '4125630147'),
    ('Наталья', 'Григорьева', 'Сергеевна', '89564712056', 'Омск, Перелета 17', '9652301478'),
    ('Михаил', 'Исаков', 'Дмитриевич', '89456712360', 'Омск, Садовая 1', '7896541206'),
    ('Ольга', 'Федорова', 'Петровна', '89645210236', 'Омск, Победы 4', '7854120369'),
    ('Александр', 'Ковалев', 'Валентинович', '89645214036', 'Омск, Долматова 8', '7412036985');

-- Вставка тестовых данных для Автомобили (15 машин)
INSERT INTO Автомобили (Марка, Модель, Год, Номер_СТС, VIN_Номер, ID_Владельца)
VALUES
    ('Toyota', 'Camry', 2018, 'STS1234567', '1HGCM82673A123456', 1),
    ('Honda', 'Civic', 2019, 'STS7890120', 'JTDKN3DU0D156789', 2),
    ('Nissan', 'Altima', 2017, 'STS3456781', '5YFBURHE5JP345678', 3),
    ('Nissan', 'Note', 2020, 'STS9012345', 'KL1MF48Z1VB654321', 4),
    ('Subaru', 'Levorg', 2016, 'STS345MNO3', 'WAUZZZ8K4AA987654', 5),
    ('Datsun', 'Ondo', 2018, 'STS678STU7', 'WBAVA37568NK432109', 6),
    ('Mitsubishi', 'Outback', 2019, 'STS012VWX2', '2G1FC1EV0A1234567', 7),
    ('Mazda', 'Mazda6', 2017, 'STS345YZA4', '3VW167AJ1HM987654', 8),
    ('Toyota', 'Supra', 2016, 'STS456BCD6', 'KMHDN55D3YU543210', 9),
    ('Subaru', 'BRZ', 2020, 'STS789EFG8', 'SHSRE4750CU123456', 10),
    ('Toyota', 'Prius', 2019, 'STS012HIJ1', 'WVWZZZ3BZWE109876', 1),
    ('Lexus', 'RX350', 2012, 'STS345KLM3', 'ZFA19200000123456', 2),
    ('Lexus', 'ES', 2017, 'STS678NOP5', '1G1JC5SBXG4221098', 3),
    ('Subaru', 'Legacy', 2016, 'STS901QRS7', 'VF34B3FUE56789012', 4),
    ('Toyota', 'Corolla', 2020, 'STS234TUV9', 'YV1MW382X56432109', 5);

-- Вставка тестовых данных для Запчасти
INSERT INTO Запчасти (Наименование, Артикул, Описание, Стоимость)
VALUES
    ('Фильтр масляный', '12345', 'Для легковых автомобилей', 15.99),
    ('Тормозные колодки', '67890', 'Для грузовых автомобилей', 29.99),
    ('Аккумулятор', 'ABCDE', '12V, 60Ah', 59.99),
    ('Масло моторное', 'FGHIJ', 'Синтетическое 5W-30', 24.99),
    ('Свечи зажигания', 'KLMNO', 'Для бензиновых двигателей', 4.99),
    ('Фильтр воздушный', 'PQRST', 'Универсальный', 12.99),
    ('Термостат', 'UVWXY', 'Для двигателей 2.0L', 19.99),
    ('Шаровая опора', 'ZABCD', 'Левая передняя', 14.99),
    ('Топливный насос', 'EFGHI', 'Электрический', 49.99),
    ('Ремень ГРМ', 'JKLMN', 'Для автомобилей с ДВС', 17.99);

-- Вставка тестовых данных для Заказы
INSERT INTO Заказы (Дата_Заказа, Статус_Заказа, Описание_Проблемы, ID_Автомобиля)
VALUES
    ('2024-01-10', 'В обработке', 'Не заводится', 1),
    ('2024-01-12', 'Выполнен', 'Не работает кондиционер', 3),
    ('2024-01-15', 'В процессе', 'Стучит в двигателе', 5),
    ('2024-01-18', 'Выполнен', 'Требуется замена тормозных колодок', 7),
    ('2024-01-20', 'Отменен', 'Проблемы с трансмиссией', 10),
    ('2024-01-22', 'В обработке', 'Течет масло', 12),
    ('2024-01-25', 'В процессе', 'Не работает электрика', 14),
    ('2024-01-28', 'Выполнен', 'Профилактика', 2),
    ('2024-01-30', 'В обработке', 'Проблемы с подвеской', 4),
    ('2024-02-02', 'В процессе', 'Неисправности трансмиссии', 6);

-- Вставка тестовых данных для Проданные_Запчасти_В_Заказе
INSERT INTO Проданные_Запчасти_В_Заказе (ID_Заказа, Статус, Дата_изменения_статуса, ID_Запчасти, Количество)
VALUES
    (1, 'Отгружено', '2024-01-12', 3, 1),
    (1, 'Отгружено', '2024-01-12', 5, 4),
    (3, 'Ожидает отгрузки', NULL, 2, 2),
    (4, 'Отгружено', '2024-01-20', 1, 1),
    (4, 'Отгружено', '2024-01-20', 9, 2),
    (6, 'Ожидает отгрузки', NULL, 7, 1),
    (7, 'Отгружено', '2024-01-28', 4, 2),
    (8, 'Отгружено', '2024-01-30', 6, 1),
    (10, 'Ожидает отгрузки', NULL, 10, 3),
    (10, 'Ожидает отгрузки', NULL, 8, 2);

-- Вставка тестовых данных для Платежи
INSERT INTO Платежи (Сумма_платежа, Дата_платежа, Статус_платежа)
VALUES
    (50.00, '2024-01-12', 'Выполнен'),
    (100.00, '2024-01-20', NULL),
    (30.00, '2024-01-28', NULL),
    (75.00, '2024-02-02', 'Выполнен'),
    (45.00, '2024-02-10', NULL),
    (60.00, '2024-02-18', NULL),
    (25.00, '2024-02-25', 'Выполнен'),
    (90.00, '2024-03-05', NULL),
    (70.00, '2024-03-12', 'Выполнен'),
    (120.00, '2024-03-20', 'Выполнен');

-- Вставка тестовых данных для Услуги
INSERT INTO Услуги (Вид_Услуги, Описание_Услуги, Стоимость_Услуги)
VALUES
    ('Техническое обслуживание', 'Полная замена масла и фильтров', 50.00),
    ('Диагностика двигателя', 'Подключение к диагностическому сканеру', 30.00),
    ('Ремонт трансмиссии', 'Замена масла и фильтра в коробке передач', 80.00),
    ('Замена тормозных колодок', 'Установка новых тормозных колодок', 40.00),
    ('Регулировка подвески', 'Проверка и регулировка амортизаторов', 35.00),
    ('Замена аккумулятора', 'Установка нового аккумулятора', 60.00),
    ('Замена топливного фильтра', 'Установка нового топливного фильтра', 25.00),
    ('Проверка и замена свечей зажигания', 'Подключение к диагностическому сканеру', 20.00),
    ('Полная диагностика автомобиля', 'Проверка всех систем и узлов', 90.00),
    ('Промывка системы охлаждения', 'Промывка радиатора и установка новой жидкости', 55.00);

-- Вставка тестовых данных для Сотрудники
INSERT INTO Сотрудники (Имя, Фамилия, Отчество, Должность, Адрес, Номер_Телефона, Паспорт)
VALUES
    ('Иван', 'Дискян', 'Иванович', 'Механик', 'Улица Пушкина, 10', '89161234567', '5200487523'),
    ('Петр', 'Маслов', 'Петрович', 'Автомеханик', 'Улица Ленина, 5', '84959876543', '5200923461'),
    ('Анна', 'Бензинова', 'Игоревна', 'Электромеханик', 'Проспект Мира, 15', '89125553555', '5203152978'),
    ('Сергей', 'Поршенев', 'Владимирович', 'Технический специалист', 'Улица Гагарина, 20', '83432223344', '5208734619'),
    ('Елена', 'Педальникова', 'Александровна', 'Специалист по ремонту двигателей', 'Проезд Советский, 12', '89876543210', '5205937461'),
    ('Дмитрий', 'Ключкин', 'Анатольевич', 'Специалист по трансмиссии', 'Улица Кирова, 30', '86425871067', '5201729357'),
    ('Наталья', 'Ручникова', 'Сергеевна', 'Автослесарь', 'Переулок Лесной, 7', '89652034780', '5205907312'),
    ('Михаил', 'Турбинин', 'Дмитриевич', 'Мастер по электрике', 'Улица Маяковского, 25', '89652147860', '5208451637'),
    ('Ольга', 'Рулева', 'Петровна', 'Мастер по ходовой', 'Улица Жукова, 8', '97852103655', '5207692045'),
    ('Александр', 'Печкин', 'Валентинович', 'Диагност', 'Улица Рублева, 23', '89652145607', '5209803476');

-- Вставка тестовых данных для График_Работы
INSERT INTO График_Работы (ID_Сотрудника, Дата, Время_Начала_Работы, Время_Окончания_Работы)
VALUES
    (1, '2024-01-10', '08:00:00', '17:00:00'),
    (2, '2024-01-12', '09:00:00', '18:00:00'),	
    (3, '2024-01-15', '10:00:00', '19:00:00'),
    (4, '2024-01-18', '08:30:00', '17:30:00'),
    (5, '2024-01-20', '09:30:00', '18:30:00'),
    (6, '2024-01-22', '10:30:00', '19:30:00'),
    (7, '2024-01-25', '08:00:00', '17:00:00'),
    (8, '2024-01-28', '09:00:00', '18:00:00'),
    (9, '2024-01-30', '10:00:00', '19:00:00'),
    (10, '2024-02-02', '08:30:00', '17:30:00');


-- Вставка тестовых данных для Услуги_В_Заказе
INSERT INTO Услуги_В_Заказе (ID_Заказ, Статус, Дата_Изменения, ID_Сотрудника, ID_Услуги)
VALUES
    (1, 'Выполнено', '2024-01-12', 1, 1),
    (1, 'Выполнено', '2024-01-12', 2, 2),
    (3, 'В процессе', '2024-01-15', 3, 3),
    (4, 'Выполнено', '2024-01-18', 4, 4),
    (4, 'Выполнено', '2024-01-18', 5, 5),
    (6, 'В процессе', '2024-01-22', 6, 6),
    (7, 'Выполнено', '2024-01-25', 7, 7),
    (8, 'Выполнено', '2024-01-28', 8, 8),
    (10, 'В процессе', '2024-02-02', 9, 9),
    (10, 'В процессе', '2024-02-02', 10, 10);
