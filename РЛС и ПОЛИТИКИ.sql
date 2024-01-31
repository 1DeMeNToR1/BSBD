ALTER ROLE Админ SET search_path TO schema_for_sadmin, schema_for_admin, public;
ALTER ROLE ГлавМас SET search_path TO schema_for_admin, public;
ALTER ROLE Сотрудник SET search_path TO public;

SHOW search_path;
DEALLOCATE ALL;

SET SESSION AUTHORIZATION '84959876543';
SELECT Остаток_По_Платежам('4');
SET SESSION AUTHORIZATION postgres;

--РАЗРЕШЕНИЯ ДЛЯ РОЛИ АДМИН
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



--РАЗРЕШЕНИЯ ДЛЯ РОЛИ ГлавМас
GRANT SELECT, UPDATE, INSERT ON TABLE Автомобили TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Сотрудники TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE График_Работы TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Запчасти TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Услуги TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Заказы TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Проданные_Запчасти_В_Заказе TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Услуги_В_Заказе TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Владелец_Авто TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Платежи TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Модель TO ГлавМас;
GRANT SELECT, UPDATE, INSERT ON TABLE Марка TO ГлавМас;

GRANT EXECUTE ON PROCEDURE Добавить_Владельца_Авто(VARCHAR, VARCHAR,VARCHAR,VARCHAR,VARCHAR,VARCHAR) TO ГлавМас;
GRANT EXECUTE ON PROCEDURE Добавить_Заказ(VARCHAR, TEXT, INTEGER) TO ГлавМас;
GRANT EXECUTE ON PROCEDURE Добавить_Запчасть_В_Заказ(INTEGER,INTEGER,INTEGER) TO ГлавМас;
GRANT EXECUTE ON PROCEDURE Добавить_Марку(VARCHAR) TO ГлавМас;
GRANT EXECUTE ON PROCEDURE Добавить_Модель(VARCHAR, VARCHAR) TO ГлавМас;
GRANT EXECUTE ON PROCEDURE Добавить_платеж(NUMERIC, TEXT, INTEGER) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Список_Запчастей_По_Модели(VARCHAR) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Найти_Автомобиль_По_Винкоду(VARCHAR) TO ГлавМас;
GRANT EXECUTE ON FUNCTION История_Обслуживания_Клиента(INTEGER) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Информация_О_Авто_И_Работах(INTEGER) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Топ_Популярных_Услуг() TO ГлавМас;
GRANT EXECUTE ON FUNCTION Количество_Услуг_По_Типу() TO ГлавМас;
GRANT EXECUTE ON FUNCTION Количество_Моделей_По_Маркам() TO ГлавМас;


GRANT EXECUTE ON FUNCTION Суммарная_Стоимость_Запчастей_ЗаП() TO ГлавМас;
GRANT EXECUTE ON FUNCTION Сотрудники_По_Автомобилю(INTEGER) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Расшифровать_Сотрудников(VARCHAR) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Рассчитать_Остаток_По_Платежам(INTEGER) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Получить_Информацию_О_Заказах() TO ГлавМас;
GRANT EXECUTE ON FUNCTION Общая_Стоимость_Услуг_В_Заказе() TO ГлавМас;
GRANT EXECUTE ON FUNCTION Маскировка_СТС(TEXT) TO ГлавМас;
GRANT EXECUTE ON FUNCTION Демаскировка_СТС(TEXT) TO ГлавМас;

--РАЗРЕШЕНИЯ ДЛЯ РОЛИ Сотрудник
GRANT SELECT ON TABLE Автомобили TO Сотрудник;
GRANT SELECT ON TABLE Сотрудники TO Сотрудник;
GRANT SELECT ON TABLE Заказы TO Сотрудник;
GRANT SELECT ON TABLE Проданные_Запчасти_В_Заказе TO Сотрудник;
GRANT SELECT ON TABLE График_Работы TO Сотрудник;
GRANT SELECT ON TABLE Запчасти TO Сотрудник;
GRANT SELECT ON TABLE Услуги_В_Заказе TO Сотрудник;
GRANT SELECT ON TABLE Услуги TO Сотрудник;
GRANT SELECT ON TABLE Марка TO Сотрудник;
GRANT SELECT ON TABLE Модель TO Сотрудник;

GRANT EXECUTE ON FUNCTION Топ_Популярных_Услуг() TO Сотрудник;
GRANT EXECUTE ON FUNCTION Количество_Услуг_По_Типу() TO Сотрудник;
GRANT EXECUTE ON FUNCTION Количество_Моделей_По_Маркам() TO Сотрудник;




--ПОЛИТИКА НА УРОВНЕ СТРОКЪ
ALTER TABLE Автомобили ENABLE ROW LEVEL SECURITY;
ALTER TABLE Заказы ENABLE ROW LEVEL SECURITY;
ALTER TABLE Проданные_Запчасти_В_Заказе ENABLE ROW LEVEL SECURITY;
ALTER TABLE График_Работы ENABLE ROW LEVEL SECURITY;
ALTER TABLE Запчасти ENABLE ROW LEVEL SECURITY;
ALTER TABLE Сотрудники ENABLE ROW LEVEL SECURITY;
ALTER TABLE Услуги_В_Заказе ENABLE ROW LEVEL SECURITY;

--РЛС ДЛЯ ТАБЛИЦЫ СОТРУДНИКИ
CREATE POLICY rls_Сотрудник_sel ON Сотрудники AS PERMISSIVE FOR SELECT TO Сотрудник
USING (Номер_Телефона = current_user);
CREATE POLICY rls_Админ_all ON Сотрудники AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Сотрудники AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ ГРАФИК_РАБОТЫ
CREATE POLICY rls_Сотрудник_sel ON График_Работы AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Сотрудники WHERE (Сотрудники.ID_Сотрудника = График_Работы.ID_Сотрудника))));
CREATE POLICY rls_Админ_all ON График_Работы AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON График_Работы AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ УСЛУГИ В ЗАКАЗЕ
CREATE POLICY rls_Сотрудник_sel ON Услуги_В_Заказе AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Сотрудники WHERE (Сотрудники.ID_Сотрудника = Услуги_В_Заказе.ID_Сотрудника))));
CREATE POLICY rls_Админ_all ON Услуги_В_Заказе AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Услуги_В_Заказе AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);
CREATE POLICY rls_ГлавМас_up ON Услуги_В_Заказе AS PERMISSIVE FOR UPDATE TO ГлавМас
USING (true);
CREATE POLICY rls_ГлавМас_del ON Услуги_В_Заказе AS PERMISSIVE FOR DELETE TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ ЗАКАЗЫ
CREATE POLICY rls_Сотрудник_sel ON Заказы AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Услуги_В_Заказе WHERE (Услуги_В_Заказе.ID_Заказ = Заказы.ID_Заказа))));
CREATE POLICY rls_Админ_all ON Заказы AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Заказы AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);
CREATE POLICY rls_ГлавМас_up ON Заказы AS PERMISSIVE FOR UPDATE TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ АВТОМОБИЛИ
CREATE POLICY rls_Сотрудник_sel ON Автомобили AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Заказы WHERE (Заказы.ID_Автомобиля = Автомобили.ID_Автомобиля))));
CREATE POLICY rls_Админ_all ON Автомобили AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Заказы AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ ПРОДАННЫЕ ЗАПЧАСТИ В РАМКАХ ЗАКАЗА
CREATE POLICY rls_Сотрудник_sel ON Проданные_Запчасти_В_Заказе AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Заказы WHERE (Заказы.ID_Заказа = Проданные_Запчасти_В_Заказе.ID_Заказа))));
CREATE POLICY rls_Админ_all ON Проданные_Запчасти_В_Заказе AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Проданные_Запчасти_В_Заказе AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);
CREATE POLICY rls_ГлавМас_up ON Проданные_Запчасти_В_Заказе AS PERMISSIVE FOR UPDATE TO ГлавМас
USING (true);
CREATE POLICY rls_ГлавМас_del ON Проданные_Запчасти_В_Заказе AS PERMISSIVE FOR DELETE TO ГлавМас
USING (true);

--РЛС ДЛЯ ТАБЛИЦЫ ПРОДАННЫЕ ЗАПЧАСТИ
CREATE POLICY rls_Сотрудник_sel ON Запчасти AS PERMISSIVE FOR SELECT TO Сотрудник
USING ((EXISTS (SELECT 1 FROM Проданные_Запчасти_В_Заказе WHERE (Проданные_Запчасти_В_Заказе.ID_Запчасти = Запчасти.ID_Запчасти))));
CREATE POLICY rls_Админ_all ON Запчасти AS PERMISSIVE FOR ALL TO Админ
USING (true);
CREATE POLICY rls_ГлавМас_sel ON Запчасти AS PERMISSIVE FOR SELECT TO ГлавМас
USING (true);