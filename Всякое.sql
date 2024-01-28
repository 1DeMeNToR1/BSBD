--GRANT USAGE ON SCHEMA public, schema_for_admin, schema_for_sadmin TO Админ;  -- Здесь предполагается, что ваши объекты находятся в схеме "public"
--GRANT USAGE ON SCHEMA public, schema_for_admin TO ГлавМас; 

CREATE OR REPLACE PROCEDURE Добавить_Марку(
    входная_марка VARCHAR(50)
)
AS $$
DECLARE
    марка_id INTEGER;
BEGIN
    SELECT ID_Марки INTO марка_id FROM Марка WHERE Название = входная_марка;

    IF марка_id IS NULL THEN
        INSERT INTO Марка (Название) VALUES (входная_марка);
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE Добавить_Модель(
    входная_марка VARCHAR(50),
    входная_модель VARCHAR(50)
)
AS $$
DECLARE
    марка_id INTEGER;
BEGIN
    SELECT ID_Марки INTO марка_id FROM Марка WHERE Название = входная_марка;

    IF марка_id IS NULL THEN
        RAISE EXCEPTION 'Марка % не существует.', входная_марка;
    ELSE
        INSERT INTO Модель (ID_Марки, Название) VALUES (марка_id, входная_модель);
    END IF;
END;
$$ LANGUAGE plpgsql;
CALL Добавить_Модель('Toyota', 'Camry');



SELECT Информация_О_Авто_И_Работах('1');


ALTER TABLE Автомобили
ADD COLUMN ID_Модели INTEGER REFERENCES Модель(ID_Модели) ON DELETE CASCADE;

ALTER TABLE Автомобили
DROP CONSTRAINT IF EXISTS fk_Марка,
DROP CONSTRAINT IF EXISTS fk_Модель,
DROP COLUMN IF EXISTS Марка,
DROP COLUMN IF EXISTS Модель;

CREATE OR REPLACE FUNCTION Остаток_По_Платежам(ID_Владельца_Параметр INT)
RETURNS DECIMAL(10, 2)
AS $$
DECLARE
    Остаток DECIMAL(10, 2) := 0;
BEGIN
    SELECT COALESCE(SUM(CASE WHEN Платежи.Статус_платежа = NULL THEN NULL ELSE Платежи.Сумма_платежа END), 0)
    INTO Остаток
    FROM Владелец_Авто
    LEFT JOIN Автомобили ON Владелец_Авто.ID_Владельца = Автомобили.ID_Владельца
    LEFT JOIN Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
    LEFT JOIN Платежи ON Заказы.ID_Заказа = Платежи.ID_Заказа
    WHERE Владелец_Авто.ID_Владельца = ID_Владельца_Параметр;

    RETURN Остаток;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION Список_Запчастей_По_Модели(
    автомобиль_модель VARCHAR(50)
) RETURNS TABLE (
    ID_Запчасти INTEGER,
    Наименование VARCHAR(100),
    Артикул VARCHAR(20),
    Описание TEXT,
    Стоимость DECIMAL(10, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.ID_Запчасти,
        p.Наименование,
        p.Артикул,
        p.Описание,
        p.Стоимость
    FROM
        Запчасти p
    JOIN
        Проданные_Запчасти_В_Заказе spz ON p.ID_Запчасти = spz.ID_Запчасти
    JOIN
        Заказы o ON spz.ID_Заказа = o.ID_Заказа
    JOIN
        Автомобили a ON o.ID_Автомобиля = a.ID_Автомобиля
    JOIN
        Модель m ON a.ID_Модели = m.ID_Модели
    WHERE
        m.Название = автомобиль_модель;
END;
$$ LANGUAGE plpgsql;

SELECT Список_Запчастей_По_Модели('Camry');


CREATE OR REPLACE FUNCTION Самая_Частая_Машина() RETURNS TABLE (
    Марка VARCHAR(50),
    Модель VARCHAR(50),
    Год VARCHAR(4),
    Количество_Посещений BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        Марка.Название AS Марка,
        Модель.Название AS Модель,
        Автомобили.Год,
        COUNT(Заказы.ID_Заказа) AS Количество_Посещений
    FROM
        Автомобили
    LEFT JOIN
        Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
    LEFT JOIN
        Модель ON Автомобили.ID_Модели = Модель.ID_Модели
    LEFT JOIN
        Марка ON Модель.ID_Марки = Марка.ID_Марки
    GROUP BY
        Марка.Название, Модель.Название, Автомобили.Год
    ORDER BY
        Количество_Посещений DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

SELECT Самая_Частая_Машина();



CREATE OR REPLACE FUNCTION Суммарная_Выручка_За_Период(
    Период_Начало DATE,
    Период_Конец DATE
) RETURNS DECIMAL(10, 2) AS $$
DECLARE
    Общая_Сумма DECIMAL(10, 2);
BEGIN
    SELECT COALESCE(SUM(Платежи.Сумма_платежа + Запчасти.Стоимость), 0)
    INTO Общая_Сумма
    FROM Платежи
    LEFT JOIN Заказы ON Платежи.ID_Заказа = Заказы.ID_Заказа
    LEFT JOIN Проданные_Запчасти_В_Заказе ON Заказы.ID_Заказа = Проданные_Запчасти_В_Заказе.ID_Заказа
    LEFT JOIN Запчасти ON Проданные_Запчасти_В_Заказе.ID_Запчасти = Запчасти.ID_Запчасти
    WHERE
        Платежи.Дата_платежа >= Период_Начало
        AND Платежи.Дата_платежа <= Период_Конец;

    RETURN Общая_Сумма;
END;
$$ LANGUAGE plpgsql;

SELECT Суммарная_Выручка_За_Период('2024-01-1', '2024-02-29');




