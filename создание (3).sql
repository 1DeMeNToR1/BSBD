CREATE TABLE Марка (
    ID_Марки SERIAL PRIMARY KEY,
    Название VARCHAR(50) NOT NULL
);
CREATE TABLE Модель (
    ID_Модели SERIAL PRIMARY KEY,
    ID_Марки INTEGER REFERENCES Марка(ID_Марки) ON DELETE CASCADE,
    Название VARCHAR(50) NOT NULL
);
-- Создание таблицы Владелец_Авто
CREATE TABLE Владелец_Авто (
    ID_Владельца SERIAL PRIMARY KEY,
    Имя VARCHAR(50),
    Фамилия VARCHAR(50),
    Отчество VARCHAR(50),
    Телефон VARCHAR(11),
    Адрес VARCHAR(155),
    Номер_ВУ VARCHAR(10)
);

-- Создание таблицы Сотрудники
CREATE TABLE Сотрудники (
    ID_Сотрудника SERIAL PRIMARY KEY,
    Имя VARCHAR(50),
    Фамилия VARCHAR(50),
    Отчество VARCHAR(50),
    Должность VARCHAR(50),
    Адрес VARCHAR(155),
    Номер_Телефона VARCHAR(11),
    Паспорт VARCHAR(10)
);

-- Создание таблицы Автомобили
CREATE TABLE Автомобили (
    ID_Автомобиля SERIAL PRIMARY KEY,
    ID_Модели INTEGER REFERENCES Модель(ID_Модели) ON DELETE CASCADE,
    Год VARCHAR(4),
    Номер_СТС VARCHAR(10),
    VIN_Номер VARCHAR(18),
    ID_Владельца INTEGER REFERENCES Владелец_Авто(ID_Владельца) ON DELETE CASCADE
);

-- Создание таблицы Запчасти
CREATE TABLE Запчасти (
    ID_Запчасти SERIAL PRIMARY KEY,
    Наименование VARCHAR(100),
    Артикул VARCHAR(8),
    Описание TEXT,
    Стоимость DECIMAL(10, 2)
);

-- Создание таблицы Заказы
CREATE TABLE Заказы (
    ID_Заказа SERIAL PRIMARY KEY,
    Дата_Заказа DATE,
    Статус_Заказа VARCHAR(50),
    Описание_Проблемы TEXT,
    ID_Автомобиля INTEGER REFERENCES Автомобили(ID_Автомобиля) ON DELETE CASCADE
);

-- Создание таблицы Проданные_Запчасти_В_Заказе
CREATE TABLE Проданные_Запчасти_В_Заказе (
    ID_Проданной_Запчасти SERIAL PRIMARY KEY,
    ID_Заказа INTEGER REFERENCES Заказы(ID_Заказа) ON DELETE CASCADE,
    Статус VARCHAR(50),
    Дата_изменения_статуса TIMESTAMP,
    ID_Запчасти INTEGER REFERENCES Запчасти(ID_Запчасти) ON DELETE CASCADE,
    Количество INTEGER
);

-- Создание таблицы Платежи
CREATE TABLE Платежи (
    ID_Платежа SERIAL PRIMARY KEY,
    Сумма_платежа DECIMAL(10, 2),
    Дата_платежа DATE,
    Статус_платежа TEXT,
    ID_Заказа INTEGER REFERENCES Заказы(ID_Заказа) ON DELETE CASCADE
);


-- Создание таблицы Услуги
CREATE TABLE Услуги (
    ID_Услуги SERIAL PRIMARY KEY,
    Вид_Услуги VARCHAR(100),
    Описание_Услуги TEXT,
    Стоимость_Услуги DECIMAL(10, 2)
);

-- Создание таблицы График_Работы
CREATE TABLE График_Работы (
    ID_Графика SERIAL PRIMARY KEY,
    ID_Сотрудника INTEGER REFERENCES Сотрудники(ID_Сотрудника) ON DELETE CASCADE,
    Дата DATE,
    Время_Начала_Работы TIME,
    Время_Окончания_Работы TIME
);

-- Создание таблицы Услуги_В_Заказе
CREATE TABLE Услуги_В_Заказе (
    ID_Истории_Заказа SERIAL PRIMARY KEY,
    ID_Заказ INTEGER REFERENCES Заказы(ID_Заказа) ON DELETE CASCADE,
    Статус VARCHAR(50),
    Дата_Изменения TIMESTAMP,
    ID_Сотрудника INTEGER REFERENCES Сотрудники(ID_Сотрудника) ON DELETE CASCADE,
    ID_Услуги INTEGER REFERENCES Услуги(ID_Услуги) ON DELETE CASCADE
);