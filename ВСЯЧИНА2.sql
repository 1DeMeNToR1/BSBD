--РАЗРЕШЕНИЯ ДЛЯ РОЛИ ГлавМас
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Автомобили TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Сотрудники TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE График_Работы TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Запчасти TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Услуги TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Заказы TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Проданные_Запчасти_В_Заказе TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Услуги_В_Заказе TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Владелец_Авто TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Платежи TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Модель TO Админ;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Марка TO Админ;

GRANT EXECUTE ON PROCEDURE Добавить_Владельца_Авто(VARCHAR, VARCHAR,VARCHAR,VARCHAR,VARCHAR,VARCHAR) TO Админ;
GRANT EXECUTE ON PROCEDURE Добавить_Заказ(VARCHAR, TEXT, INTEGER) TO Админ;
GRANT EXECUTE ON PROCEDURE Добавить_Запчасть_В_Заказ(INTEGER,INTEGER,INTEGER) TO Админ;
GRANT EXECUTE ON PROCEDURE Добавить_Марку(VARCHAR) TO Админ;
GRANT EXECUTE ON PROCEDURE Добавить_Модель(VARCHAR, VARCHAR) TO Админ;
GRANT EXECUTE ON PROCEDURE Добавить_платеж(NUMERIC, TEXT, INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Список_Запчастей_По_Модели(VARCHAR) TO Админ;
GRANT EXECUTE ON FUNCTION Найти_Автомобиль_По_Винкоду(VARCHAR) TO Админ;
GRANT EXECUTE ON FUNCTION История_Обслуживания_Клиента(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Информация_О_Авто_И_Работах(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Топ_Популярных_Услуг() TO Админ;
GRANT EXECUTE ON FUNCTION Количество_Услуг_По_Типу() TO Админ;
GRANT EXECUTE ON FUNCTION Количество_Моделей_По_Маркам() TO Админ;
GRANT EXECUTE ON FUNCTION Выгрузить_заказ(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Самая_Частая_Машина() TO Админ;
GRANT EXECUTE ON FUNCTION Самый_Частый_Клиент() TO Админ;
GRANT EXECUTE ON FUNCTION Сотрудники_По_Автомобилю(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Суммарная_Выручка_За_Период(DATE, DATE) TO Админ;


GRANT EXECUTE ON FUNCTION Суммарная_Выручка_От_Платежей(DATE, DATE) TO Админ;
GRANT EXECUTE ON FUNCTION Суммарная_Стоимость_Проданных_Зап(DATE, DATE) TO Админ;
GRANT EXECUTE ON FUNCTION Суммарная_Стоимость_Запчастей_ЗаП() TO Админ;
GRANT EXECUTE ON FUNCTION Сотрудники_По_Автомобилю(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Расшифровать_Сотрудников(VARCHAR) TO Админ;
GRANT EXECUTE ON FUNCTION Рассчитать_Остаток_По_Платежам(INTEGER) TO Админ;
GRANT EXECUTE ON FUNCTION Получить_Информацию_О_Заказах() TO Админ;
GRANT EXECUTE ON FUNCTION Общая_Стоимость_Услуг_В_Заказе() TO Админ;
GRANT EXECUTE ON FUNCTION Маскировка_СТС(TEXT) TO Админ;
GRANT EXECUTE ON FUNCTION Демаскировка_СТС(TEXT) TO Админ;


SELECT Суммарная_Стоимость_Проданных_Зап('2024-01-01', '2024-02-02');

-- Проверка, имеет ли текущий пользователь роль "Админ"
SELECT pg_has_role('84959876543', 'Админ', 'member') AS is_admin;

SET ROLE Админ;
GRANT Админ TO "84959876543"

show search_path
ALTER ROLE Админ SET search_path = schema_for_sadmin, schema_for_admin, public;
ALTER ROLE Админ SET search_path TO schema_for_sadmin, schema_for_admin, public;
ALTER ROLE ГлавМас SET search_path TO schema_for_admin, public;
ALTER ROLE Сотрудник SET search_path TO public;

GRANT USAGE ON SCHEMA public, schema_for_admin, schema_for_sadmin TO Админ;
GRANT USAGE ON SCHEMA public, schema_for_admin TO ГлавМас; 
