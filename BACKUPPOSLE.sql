PGDMP     *    "                 |            autoservice    15.1    15.1 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    196787    autoservice    DATABASE        CREATE DATABASE autoservice WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE autoservice;
                postgres    false            �           0    0    autoservice    DATABASE PROPERTIES     v   ALTER ROLE "Админ" IN DATABASE autoservice SET search_path TO 'schema_for_sadmin', 'schema_for_admin', 'public';
                     postgres    false                        2615    197103    hiddent    SCHEMA        CREATE SCHEMA hiddent;
    DROP SCHEMA hiddent;
                postgres    false            �           0    0    SCHEMA public    ACL     `   GRANT USAGE ON SCHEMA public TO "Админ";
GRANT USAGE ON SCHEMA public TO "ГлавМас";
                   pg_database_owner    false    8            	            2615    197102    schema_for_admin    SCHEMA         CREATE SCHEMA schema_for_admin;
    DROP SCHEMA schema_for_admin;
                postgres    false            �           0    0    SCHEMA schema_for_admin    ACL     t   GRANT USAGE ON SCHEMA schema_for_admin TO "Админ";
GRANT USAGE ON SCHEMA schema_for_admin TO "ГлавМас";
                   postgres    false    9                        2615    197101    schema_for_sadmin    SCHEMA     !   CREATE SCHEMA schema_for_sadmin;
    DROP SCHEMA schema_for_sadmin;
                postgres    false            �           0    0    SCHEMA schema_for_sadmin    ACL     9   GRANT USAGE ON SCHEMA schema_for_sadmin TO "Админ";
                   postgres    false    7                        3079    197046    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2            <           1255    196993    check_order_status()    FUNCTION     M  CREATE FUNCTION hiddent.check_order_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."Статус_Заказа" NOT IN ('В обработке', 'Выполнен', 'Отменен')
    THEN
        RAISE EXCEPTION 'Недопустимый статус заказа';
    END IF;

    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION hiddent.check_order_status();
       hiddent          postgres    false    6            =           1255    197001    check_payment_amount()    FUNCTION       CREATE FUNCTION hiddent.check_payment_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."Сумма_платежа" <= 0
    THEN
        RAISE EXCEPTION 'Недопустимая сумма платежа';
    END IF;

    RETURN NEW;
END;
$$;
 .   DROP FUNCTION hiddent.check_payment_amount();
       hiddent          postgres    false    6            >           1255    196991    check_phone_number()    FUNCTION     �  CREATE FUNCTION hiddent.check_phone_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Проверяем, начинается ли номер телефона с "8"
    IF NEW."Телефон" IS NOT NULL AND NEW."Телефон" NOT LIKE '8%'
    THEN
        RAISE EXCEPTION 'Номер телефона должен начинаться с 8';
    END IF;

    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION hiddent.check_phone_number();
       hiddent          postgres    false    6                       1255    196980    check_Имя()    FUNCTION     �   CREATE FUNCTION hiddent."check_Имя"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.Имя ~ '^[A-Я]' THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'Имя должно начинаться с большой буквы';
	END IF;
END;
$$;
 (   DROP FUNCTION hiddent."check_Имя"();
       hiddent          postgres    false    6            ?           1255    196989    check_Марка()    FUNCTION     N  CREATE FUNCTION hiddent."check_Марка"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."Марка" ~ '^[A-Z]' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Марка должна начинаться с большой буквы на английской раскладке';
    END IF;
END;
$$;
 ,   DROP FUNCTION hiddent."check_Марка"();
       hiddent          postgres    false    6            @           1255    196988    check_Модель()    FUNCTION     R  CREATE FUNCTION hiddent."check_Модель"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.Модель ~ '^[A-Z]' THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Модель должна начинаться с большой буквы на английской раскладке';
    END IF;
END;
$$;
 .   DROP FUNCTION hiddent."check_Модель"();
       hiddent          postgres    false    6            	           1255    196982    check_Отчество()    FUNCTION       CREATE FUNCTION hiddent."check_Отчество"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.Отчество ~ '^[A-Я]' THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'Отчество должно начинаться с большой буквы';
	END IF;
END;
$$;
 2   DROP FUNCTION hiddent."check_Отчество"();
       hiddent          postgres    false    6            
           1255    196978    check_Фамилия()    FUNCTION       CREATE FUNCTION hiddent."check_Фамилия"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.Фамилия ~ '^[A-Я]' THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'Фамилия должна начинаться с большой буквы';
	END IF;
END;
$$;
 0   DROP FUNCTION hiddent."check_Фамилия"();
       hiddent          postgres    false    6            '           1255    197003    set_order_date()    FUNCTION     �   CREATE FUNCTION hiddent.set_order_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."Дата_Заказа" := CURRENT_DATE;
    
    RETURN NEW;
END;
$$;
 (   DROP FUNCTION hiddent.set_order_date();
       hiddent          postgres    false    6            (           1255    197005    set_paying_date()    FUNCTION     �   CREATE FUNCTION hiddent.set_paying_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."Дата_Платежа" := CURRENT_DATE;
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION hiddent.set_paying_date();
       hiddent          postgres    false    6            )           1255    196999    update_order_status()    FUNCTION       CREATE FUNCTION hiddent.update_order_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE "Заказы"
    SET "Статус_Заказа" = 'В обработке'
    WHERE "ID_Заказа" = NEW."ID_Заказа" AND
          EXISTS (SELECT 1 FROM "Проданные_Запчасти_В_Заказе" WHERE "ID_Заказа" = NEW."ID_Заказа" AND "Статус" = 'В обработке');

    UPDATE "Заказы"
    SET "Статус_Заказа" = 'Выполнен'
    WHERE "ID_Заказа" = NEW."ID_Заказа" AND
          NOT EXISTS (SELECT 1 FROM "Проданные_Запчасти_В_Заказе" WHERE "ID_Заказа" = NEW."ID_Заказа" AND "Статус" = 'В обработке');

    RETURN NEW;
END;
$$;
 -   DROP FUNCTION hiddent.update_order_status();
       hiddent          postgres    false    6            �           0    0 &   FUNCTION pgp_pub_decrypt(bytea, bytea)    ACL     �   GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea) TO "Админ";
GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea) TO "ГлавМас";
          public          postgres    false    290            �           0    0 ,   FUNCTION pgp_pub_decrypt(bytea, bytea, text)    ACL     �   GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) TO "Админ";
GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) TO "ГлавМас";
          public          postgres    false    291            �           0    0 2   FUNCTION pgp_pub_decrypt(bytea, bytea, text, text)    ACL     �   GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) TO "Админ";
GRANT ALL ON FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) TO "ГлавМас";
          public          postgres    false    292            *           1255    197099 7   Количество_Моделей_По_Маркам()    FUNCTION     D  CREATE FUNCTION public."Количество_Моделей_По_Маркам"() RETURNS TABLE("Название_Марки" character varying, "Количество_Моделей" bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Марка.Название,
        COUNT(Модель.ID_Модели) AS Количество_Моделей
    FROM
        Марка
    LEFT JOIN
        Модель ON Марка.ID_Марки = Модель.ID_Марки
    GROUP BY
        Марка.ID_Марки, Марка.Название;
END;
$$;
 P   DROP FUNCTION public."Количество_Моделей_По_Маркам"();
       public          postgres    false            �           0    0 B   FUNCTION "Количество_Моделей_По_Маркам"()    ACL     D  GRANT ALL ON FUNCTION public."Количество_Моделей_По_Маркам"() TO "Сотрудник";
GRANT ALL ON FUNCTION public."Количество_Моделей_По_Маркам"() TO "ГлавМас";
GRANT ALL ON FUNCTION public."Количество_Моделей_По_Маркам"() TO "Админ";
          public          postgres    false    298            -           1255    196937 /   Количество_Услуг_По_Типу()    FUNCTION     !  CREATE FUNCTION public."Количество_Услуг_По_Типу"() RETURNS TABLE("Вид_Услуги" character varying, "Количество" bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        us.Вид_Услуги,
        COUNT(*) AS Количество
    FROM
        Услуги_В_Заказе u
    JOIN
        Заказы o ON u.ID_Заказ = o.ID_Заказа
    JOIN
        Услуги us ON u.ID_Услуги = us.ID_Услуги
    GROUP BY
        us.Вид_Услуги;
END;
$$;
 H   DROP FUNCTION public."Количество_Услуг_По_Типу"();
       public          postgres    false            �           0    0 :   FUNCTION "Количество_Услуг_По_Типу"()    ACL     ,  GRANT ALL ON FUNCTION public."Количество_Услуг_По_Типу"() TO "Сотрудник";
GRANT ALL ON FUNCTION public."Количество_Услуг_По_Типу"() TO "ГлавМас";
GRANT ALL ON FUNCTION public."Количество_Услуг_По_Типу"() TO "Админ";
          public          postgres    false    301            ,           1255    196951 (   Топ_Популярных_Услуг()    FUNCTION     V  CREATE FUNCTION public."Топ_Популярных_Услуг"() RETURNS TABLE("Вид_Услуги" character varying, "Описание_Услуги" text, "Стоимость_Услуги" numeric, "Количество_Заказов" bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Услуги.Вид_Услуги,
        Услуги.Описание_Услуги,
        Услуги.Стоимость_Услуги,
        COUNT(Услуги_В_Заказе.ID_Услуги) AS Количество_Заказов
    FROM
        Услуги
    LEFT JOIN
        Услуги_В_Заказе ON Услуги.ID_Услуги = Услуги_В_Заказе.ID_Услуги
    GROUP BY
        Услуги.ID_Услуги
    ORDER BY
        Количество_Заказов DESC
    LIMIT 3;
END;
$$;
 A   DROP FUNCTION public."Топ_Популярных_Услуг"();
       public          postgres    false            �           0    0 3   FUNCTION "Топ_Популярных_Услуг"()    ACL       GRANT ALL ON FUNCTION public."Топ_Популярных_Услуг"() TO "Сотрудник";
GRANT ALL ON FUNCTION public."Топ_Популярных_Услуг"() TO "ГлавМас";
GRANT ALL ON FUNCTION public."Топ_Популярных_Услуг"() TO "Админ";
          public          postgres    false    300                       1255    196976 �   Добавить_Владельца_Авто(character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE        CREATE PROCEDURE schema_for_admin."Добавить_Владельца_Авто"(IN "Владелец_Имя" character varying, IN "Владелец_Фамилия" character varying, IN "Владелец_Отчество" character varying, IN "Владелец_Телефон" character varying, IN "Владелец_Адрес" character varying, IN "Владелец_Номер_ВУ" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Владелец_Авто" ("Имя", "Фамилия", "Отчество", "Телефон", "Адрес", "Номер_ВУ")
    VALUES (Владелец_Имя, Владелец_Фамилия, Владелец_Отчество, Владелец_Телефон, Владелец_Адрес, Владелец_Номер_ВУ);
END;
$$;
 �  DROP PROCEDURE schema_for_admin."Добавить_Владельца_Авто"(IN "Владелец_Имя" character varying, IN "Владелец_Фамилия" character varying, IN "Владелец_Отчество" character varying, IN "Владелец_Телефон" character varying, IN "Владелец_Адрес" character varying, IN "Владелец_Номер_ВУ" character varying);
       schema_for_admin          postgres    false    9            �           0    0   PROCEDURE "Добавить_Владельца_Авто"(IN "Владелец_Имя" character varying, IN "Владелец_Фамилия" character varying, IN "Владелец_Отчество" character varying, IN "Владелец_Телефон" character varying, IN "Владелец_Адрес" character varying, IN "Владелец_Номер_ВУ" character varying)    ACL     b  GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Владельца_Авто"(IN "Владелец_Имя" character varying, IN "Владелец_Фамилия" character varying, IN "Владелец_Отчество" character varying, IN "Владелец_Телефон" character varying, IN "Владелец_Адрес" character varying, IN "Владелец_Номер_ВУ" character varying) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Владельца_Авто"(IN "Владелец_Имя" character varying, IN "Владелец_Фамилия" character varying, IN "Владелец_Отчество" character varying, IN "Владелец_Телефон" character varying, IN "Владелец_Адрес" character varying, IN "Владелец_Номер_ВУ" character varying) TO "Админ";
          schema_for_admin          postgres    false    268            1           1255    196975 =   Добавить_Заказ(character varying, text, integer) 	   PROCEDURE     �  CREATE PROCEDURE schema_for_admin."Добавить_Заказ"(IN "входной_статус" character varying, IN "входное_описание" text, IN "входной_id_Автомобиля" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Заказы (Статус_Заказа, Описание_Проблемы, ID_Автомобиля)
    VALUES (входной_статус, входное_описание, входной_id_Автомобиля);
END;
$$;
 �   DROP PROCEDURE schema_for_admin."Добавить_Заказ"(IN "входной_статус" character varying, IN "входное_описание" text, IN "входной_id_Автомобиля" integer);
       schema_for_admin          postgres    false    9            �           0    0 �   PROCEDURE "Добавить_Заказ"(IN "входной_статус" character varying, IN "входное_описание" text, IN "входной_id_Автомобиля" integer)    ACL     �  GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Заказ"(IN "входной_статус" character varying, IN "входное_описание" text, IN "входной_id_Автомобиля" integer) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Заказ"(IN "входной_статус" character varying, IN "входное_описание" text, IN "входной_id_Автомобиля" integer) TO "Админ";
          schema_for_admin          postgres    false    305            .           1255    197100 J   Добавить_Запчасть_В_Заказ(integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE schema_for_admin."Добавить_Запчасть_В_Заказ"(IN "Заказ_id" integer, IN "Запчасть_id" integer, IN "Количество" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Заказы WHERE ID_Заказа = Заказ_ID) THEN
        RAISE EXCEPTION 'Заказ с ID % не существует.', Заказ_ID;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Запчасти WHERE ID_Запчасти = Запчасть_ID) THEN
        RAISE EXCEPTION 'Запчасть с ID % не существует.', Запчасть_ID;
    END IF;

    INSERT INTO Проданные_Запчасти_В_Заказе (ID_Заказа, ID_Запчасти, Количество)
    VALUES (Заказ_ID, Запчасть_ID, Количество);

    UPDATE Заказы SET Статус_Заказа = 'В обработке' WHERE ID_Заказа = Заказ_ID;

END;
$$;
 �   DROP PROCEDURE schema_for_admin."Добавить_Запчасть_В_Заказ"(IN "Заказ_id" integer, IN "Запчасть_id" integer, IN "Количество" integer);
       schema_for_admin          postgres    false    9            �           0    0 �   PROCEDURE "Добавить_Запчасть_В_Заказ"(IN "Заказ_id" integer, IN "Запчасть_id" integer, IN "Количество" integer)    ACL     �  GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Запчасть_В_Заказ"(IN "Заказ_id" integer, IN "Запчасть_id" integer, IN "Количество" integer) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Запчасть_В_Заказ"(IN "Заказ_id" integer, IN "Запчасть_id" integer, IN "Количество" integer) TO "Админ";
          schema_for_admin          postgres    false    302            2           1255    196974 .   Добавить_Марку(character varying) 	   PROCEDURE     �  CREATE PROCEDURE schema_for_admin."Добавить_Марку"(IN "входная_марка" character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    марка_id INTEGER;
BEGIN
    SELECT ID_Марки INTO марка_id FROM Марка WHERE Название = входная_марка;

    IF марка_id IS NULL THEN
        INSERT INTO Марка (Название) VALUES (входная_марка);
    END IF;
END;
$$;
 q   DROP PROCEDURE schema_for_admin."Добавить_Марку"(IN "входная_марка" character varying);
       schema_for_admin          postgres    false    9            �           0    0 Y   PROCEDURE "Добавить_Марку"(IN "входная_марка" character varying)    ACL       GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Марку"(IN "входная_марка" character varying) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Марку"(IN "входная_марка" character varying) TO "Админ";
          schema_for_admin          postgres    false    306            %           1255    196971 C   Добавить_Модель(character varying, character varying) 	   PROCEDURE     w  CREATE PROCEDURE schema_for_admin."Добавить_Модель"(IN "входная_марка" character varying, IN "входная_модель" character varying)
    LANGUAGE plpgsql
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
$$;
 �   DROP PROCEDURE schema_for_admin."Добавить_Модель"(IN "входная_марка" character varying, IN "входная_модель" character varying);
       schema_for_admin          postgres    false    9            �           0    0 �   PROCEDURE "Добавить_Модель"(IN "входная_марка" character varying, IN "входная_модель" character varying)    ACL     �  GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Модель"(IN "входная_марка" character varying, IN "входная_модель" character varying) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_Модель"(IN "входная_марка" character varying, IN "входная_модель" character varying) TO "Админ";
          schema_for_admin          postgres    false    293                       1255    196977 5   Добавить_платеж(numeric, text, integer) 	   PROCEDURE     �  CREATE PROCEDURE schema_for_admin."Добавить_платеж"(IN "Платеж_Сумма" numeric, IN "Платеж_Статус" text, IN "Платеж_id_Заказа" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Платежи ("Сумма_платежа", "Статус_платежа", "id_Заказа")
    VALUES (Платеж_Сумма, Платеж_Статус, Платеж_ID_Заказа);
END;
$$;
 �   DROP PROCEDURE schema_for_admin."Добавить_платеж"(IN "Платеж_Сумма" numeric, IN "Платеж_Статус" text, IN "Платеж_id_Заказа" integer);
       schema_for_admin          postgres    false    9            �           0    0 �   PROCEDURE "Добавить_платеж"(IN "Платеж_Сумма" numeric, IN "Платеж_Статус" text, IN "Платеж_id_Заказа" integer)    ACL     �  GRANT ALL ON PROCEDURE schema_for_admin."Добавить_платеж"(IN "Платеж_Сумма" numeric, IN "Платеж_Статус" text, IN "Платеж_id_Заказа" integer) TO "ГлавМас";
GRANT ALL ON PROCEDURE schema_for_admin."Добавить_платеж"(IN "Платеж_Сумма" numeric, IN "Платеж_Статус" text, IN "Платеж_id_Заказа" integer) TO "Админ";
          schema_for_admin          postgres    false    262            E           1255    196940 ;   Информация_О_Авто_И_Работах(integer)    FUNCTION     d  CREATE FUNCTION schema_for_admin."Информация_О_Авто_И_Работах"("Авто_id" integer) RETURNS TABLE("Модель" character varying, "Год" character varying, "Номер_СТС" character varying, "vin_Номер" character varying, "Имя_Владельца" character varying, "Фамилия_Владельца" character varying, "Дата_Заказа" date, "Статус_Заказа" character varying, "Описание_Проблемы" text, "Вид_Услуги" character varying, "Описание_Услуги" text, "Стоимость_Услуги" numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        CAST(Автомобили.ID_Модели AS VARCHAR(50)),
        Автомобили.Год,
        Автомобили.Номер_СТС,
        Автомобили.VIN_Номер,
        Владелец_Авто.Имя AS Имя,
        Владелец_Авто.Фамилия AS Фамилия,
        Заказы.Дата_Заказа,
        Заказы.Статус_Заказа,
        Заказы.Описание_Проблемы,
        Услуги.Вид_Услуги,
        Услуги.Описание_Услуги,
        Услуги.Стоимость_Услуги
    FROM
        Автомобили
        JOIN Владелец_Авто ON Автомобили.ID_Владельца = Владелец_Авто.ID_Владельца
        LEFT JOIN Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
        LEFT JOIN Услуги_В_Заказе ON Заказы.ID_Заказа = Услуги_В_Заказе.ID_Заказ
        LEFT JOIN Услуги ON Услуги_В_Заказе.ID_Услуги = Услуги.ID_Услуги
    WHERE
        Автомобили.ID_Автомобиля = Авто_ID;
END;
$$;
 l   DROP FUNCTION schema_for_admin."Информация_О_Авто_И_Работах"("Авто_id" integer);
       schema_for_admin          postgres    false    9            �           0    0 T   FUNCTION "Информация_О_Авто_И_Работах"("Авто_id" integer)    ACL       GRANT ALL ON FUNCTION schema_for_admin."Информация_О_Авто_И_Работах"("Авто_id" integer) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Информация_О_Авто_И_Работах"("Авто_id" integer) TO "Админ";
          schema_for_admin          postgres    false    325                       1255    196941 ?   История_Обслуживания_Клиента(integer)    FUNCTION     �  CREATE FUNCTION schema_for_admin."История_Обслуживания_Клиента"("Клиент_id" integer) RETURNS TABLE("Марка" character varying, "Модель" character varying, "Год" character varying, "Номер_СТС" character varying, "vin_Номер" character varying, "Дата_Заказа" date, "Описание_Проблемы" text, "Вид_Услуги" character varying, "Описание_Услуги" text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Марка.Название AS Марка,
        Модель.Название AS Модель,
        Автомобили.Год,
        Автомобили.Номер_СТС,
        Автомобили.VIN_Номер,
        Заказы.Дата_Заказа,
        Заказы.Описание_Проблемы,
        Услуги.Вид_Услуги,
        Услуги.Описание_Услуги
    FROM
        Владелец_Авто
        JOIN Автомобили ON Владелец_Авто.ID_Владельца = Автомобили.ID_Владельца
        LEFT JOIN Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
        LEFT JOIN Услуги_В_Заказе ON Заказы.ID_Заказа = Услуги_В_Заказе.ID_Заказ
        LEFT JOIN Услуги ON Услуги_В_Заказе.ID_Услуги = Услуги.ID_Услуги
        LEFT JOIN Модель ON Автомобили.ID_Модели = Модель.ID_Модели
        LEFT JOIN Марка ON Модель.ID_Марки = Марка.ID_Марки
    WHERE
        Владелец_Авто.ID_Владельца = Клиент_ID;
END;
$$;
 t   DROP FUNCTION schema_for_admin."История_Обслуживания_Клиента"("Клиент_id" integer);
       schema_for_admin          postgres    false    9            �           0    0 \   FUNCTION "История_Обслуживания_Клиента"("Клиент_id" integer)    ACL       GRANT ALL ON FUNCTION schema_for_admin."История_Обслуживания_Клиента"("Клиент_id" integer) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."История_Обслуживания_Клиента"("Клиент_id" integer) TO "Админ";
          schema_for_admin          postgres    false    259            B           1255    197097 !   Маскировка_СТС(text)    FUNCTION     b  CREATE FUNCTION schema_for_admin."Маскировка_СТС"("Номер_СТС" text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ваша логика маскировки, например, замена символов
    RETURN CONCAT(SUBSTRING(Номер_СТС FROM 1 FOR 4), '****', SUBSTRING(Номер_СТС FROM 9));
END;
$$;
 X   DROP FUNCTION schema_for_admin."Маскировка_СТС"("Номер_СТС" text);
       schema_for_admin          postgres    false    9            �           0    0 @   FUNCTION "Маскировка_СТС"("Номер_СТС" text)    ACL     �   GRANT ALL ON FUNCTION schema_for_admin."Маскировка_СТС"("Номер_СТС" text) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Маскировка_СТС"("Номер_СТС" text) TO "Админ";
          schema_for_admin          postgres    false    322            3           1255    196935 F   Найти_Автомобиль_По_Винкоду(character varying)    FUNCTION     m  CREATE FUNCTION schema_for_admin."Найти_Автомобиль_По_Винкоду"("vin_код" character varying) RETURNS TABLE("Год" character varying, "Номер_СТС" character varying, "vin_Номер" character varying, "Название_Марки" character varying, "Название_Модели" character varying, "Имя_Владельца" character varying, "Фамилия_Владельца" character varying, "Отчество_Владельца" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Автомобили.Год,
        Автомобили.Номер_СТС,
        Автомобили.VIN_Номер,
        Марка.Название AS Название_Марки,
        Модель.Название AS Название_Модели,
        Владелец_Авто.Имя,
        Владелец_Авто.Фамилия,
        Владелец_Авто.Отчество
    FROM
        Автомобили
    JOIN Модель ON Автомобили.ID_Модели = Модель.ID_Модели
    JOIN Марка ON Модель.ID_Марки = Марка.ID_Марки
    JOIN Владелец_Авто ON Автомобили.ID_Владельца = Владелец_Авто.ID_Владельца
    WHERE
        Автомобили.VIN_Номер = vin_код;
END;
$$;
 v   DROP FUNCTION schema_for_admin."Найти_Автомобиль_По_Винкоду"("vin_код" character varying);
       schema_for_admin          postgres    false    9            �           0    0 ^   FUNCTION "Найти_Автомобиль_По_Винкоду"("vin_код" character varying)    ACL        GRANT ALL ON FUNCTION schema_for_admin."Найти_Автомобиль_По_Винкоду"("vin_код" character varying) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Найти_Автомобиль_По_Винкоду"("vin_код" character varying) TO "Админ";
          schema_for_admin          postgres    false    307            &           1255    196966 :   Общая_Стоимость_Услуг_В_Заказе()    FUNCTION     d  CREATE FUNCTION schema_for_admin."Общая_Стоимость_Услуг_В_Заказе"() RETURNS TABLE("id_Заказа" integer, "Владелец_Имя" character varying, "Владелец_Фамилия" character varying, "Марка_Автомобиля" character varying, "Общая_Стоимость_Услуг" numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Заказы.ID_Заказа,
		Владелец_Авто.Имя AS Владелец_Имя,
        Владелец_Авто.Фамилия AS Владелец_Фамилия,
        Марка.Название AS Марка_Автомобиля,
        COALESCE(SUM(Услуги.Стоимость_Услуги), 0)::DECIMAL(10, 2) AS Общая_Стоимость_Услуг
    FROM Заказы
    LEFT JOIN Автомобили ON Заказы.ID_Автомобиля = Автомобили.ID_Автомобиля
    LEFT JOIN Модель ON Автомобили.ID_Модели = Модель.ID_Модели
    LEFT JOIN Марка ON Модель.ID_Марки = Марка.ID_Марки
    LEFT JOIN Владелец_Авто ON Автомобили.ID_Владельца = Владелец_Авто.ID_Владельца
    LEFT JOIN Услуги_В_Заказе ON Заказы.ID_Заказа = Услуги_В_Заказе.ID_Заказ
    LEFT JOIN Услуги ON Услуги_В_Заказе.ID_Услуги = Услуги.ID_Услуги
    GROUP BY Заказы.ID_Заказа, Владелец_Авто.Имя, Владелец_Авто.Фамилия, Марка.Название;

END;
$$;
 ]   DROP FUNCTION schema_for_admin."Общая_Стоимость_Услуг_В_Заказе"();
       schema_for_admin          postgres    false    9            �           0    0 E   FUNCTION "Общая_Стоимость_Услуг_В_Заказе"()    ACL     �   GRANT ALL ON FUNCTION schema_for_admin."Общая_Стоимость_Услуг_В_Заказе"() TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Общая_Стоимость_Услуг_В_Заказе"() TO "Админ";
          schema_for_admin          postgres    false    294            D           1255    196960 9   Получить_Информацию_О_Заказах()    FUNCTION       CREATE FUNCTION schema_for_admin."Получить_Информацию_О_Заказах"() RETURNS TABLE("id_Заказа" integer, "Владелец" character varying, "Марка_Автомобиля" character varying, "Общая_Стоимость_Услуг" numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Заказы.ID_Заказа,
        Владелец_Авто.Имя || ' ' || Владелец_Авто.Фамилия AS Владелец,
        Марка.Название AS Марка_Автомобиля,
        COALESCE(SUM(Услуги.Стоимость_Услуги), 0)::DECIMAL(10, 2) AS Общая_Стоимость_Услуг
    FROM Заказы
    LEFT JOIN Автомобили ON Заказы.ID_Автомобиля = Автомобили.ID_Автомобиля
    LEFT JOIN Модель ON Автомобили.ID_Модели = Модель.ID_Модели
    LEFT JOIN Марка ON Модель.ID_Марки = Марка.ID_Марки
    LEFT JOIN Владелец_Авто ON Автомобили.ID_Владельца = Владелец_Авто.ID_Владельца
    LEFT JOIN Услуги_В_Заказе ON Заказы.ID_Заказа = Услуги_В_Заказе.ID_Заказ
    LEFT JOIN Услуги ON Услуги_В_Заказе.ID_Услуги = Услуги.ID_Услуги
    GROUP BY Заказы.ID_Заказа, Владелец_Авто.Имя, Владелец_Авто.Фамилия, Марка.Название;

END;
$$;
 \   DROP FUNCTION schema_for_admin."Получить_Информацию_О_Заказах"();
       schema_for_admin          postgres    false    9                        0    0 D   FUNCTION "Получить_Информацию_О_Заказах"()    ACL     �   GRANT ALL ON FUNCTION schema_for_admin."Получить_Информацию_О_Заказах"() TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Получить_Информацию_О_Заказах"() TO "Админ";
          schema_for_admin          postgres    false    324            A           1255    196954 B   Рассчитать_Остаток_По_Платежам(integer)    FUNCTION     Q  CREATE FUNCTION schema_for_admin."Рассчитать_Остаток_По_Платежам"("id_Владельца_Параметр" integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    Остаток DECIMAL(10, 2) := 0;
BEGIN
    SELECT COALESCE(SUM(Платежи.Сумма_платежа), 0)
    INTO Остаток
    FROM Владелец_Авто
    LEFT JOIN Автомобили ON Владелец_Авто.ID_Владельца = Автомобили.ID_Владельца
    LEFT JOIN Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
    LEFT JOIN Платежи ON Заказы.ID_Заказа = Платежи.ID_Заказа
    WHERE Владелец_Авто.ID_Владельца = ID_Владельца_Параметр;

    RETURN Остаток;
END;
$$;
 �   DROP FUNCTION schema_for_admin."Рассчитать_Остаток_По_Платежам"("id_Владельца_Параметр" integer);
       schema_for_admin          postgres    false    9                       0    0 v   FUNCTION "Рассчитать_Остаток_По_Платежам"("id_Владельца_Параметр" integer)    ACL     P  GRANT ALL ON FUNCTION schema_for_admin."Рассчитать_Остаток_По_Платежам"("id_Владельца_Параметр" integer) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Рассчитать_Остаток_По_Платежам"("id_Владельца_Параметр" integer) TO "Админ";
          schema_for_admin          postgres    false    321            +           1255    197085 B   Расшифровать_Сотрудников(character varying)    FUNCTION       CREATE FUNCTION schema_for_admin."Расшифровать_Сотрудников"("ключ_param" character varying) RETURNS TABLE("id_Сотрудника" integer, "Имя" character varying, "Фамилия" character varying, "Отчество" character varying, "Должность" character varying, "Адрес" character varying, "Номер_Телефона" character varying, "Паспорт" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Сотрудники".ID_Сотрудника,
        "Сотрудники".Имя,
        "Сотрудники".Фамилия,
        "Сотрудники".Отчество,
        "Сотрудники".Должность,
        "Сотрудники".Адрес,
        "Сотрудники".Номер_Телефона,
        pgp_sym_decrypt("Сотрудники"."Паспорт"::bytea, ключ_param, 'compress-algo=0, cipher-algo=aes256')::VARCHAR(10) AS Паспорт
    FROM 
        "Сотрудники";
END;
$$;
 v   DROP FUNCTION schema_for_admin."Расшифровать_Сотрудников"("ключ_param" character varying);
       schema_for_admin          postgres    false    9                       0    0 ^   FUNCTION "Расшифровать_Сотрудников"("ключ_param" character varying)    ACL        GRANT ALL ON FUNCTION schema_for_admin."Расшифровать_Сотрудников"("ключ_param" character varying) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Расшифровать_Сотрудников"("ключ_param" character varying) TO "Админ";
          schema_for_admin          postgres    false    299            C           1255    196942 7   Сотрудники_По_Автомобилю(integer)    FUNCTION     |  CREATE FUNCTION schema_for_admin."Сотрудники_По_Автомобилю"("Автомобиль_id" integer) RETURNS TABLE("Имя_Сотрудника" character varying, "Фамилия_Сотрудника" character varying, "Должность_Сотрудника" character varying, "Вид_Услуги" character varying, "Описание_Услуги" text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Сотрудники.Имя,
        Сотрудники.Фамилия,
        Сотрудники.Должность,
        Услуги.Вид_Услуги,
        Услуги.Описание_Услуги
    FROM
        Сотрудники
        JOIN Услуги_В_Заказе ON Сотрудники.ID_Сотрудника = Услуги_В_Заказе.ID_Сотрудника
        JOIN Услуги ON Услуги_В_Заказе.ID_Услуги = Услуги.ID_Услуги
        JOIN Заказы ON Услуги_В_Заказе.ID_Заказ = Заказы.ID_Заказа
    WHERE
        Заказы.ID_Автомобиля = Автомобиль_ID;
END;
$$;
 t   DROP FUNCTION schema_for_admin."Сотрудники_По_Автомобилю"("Автомобиль_id" integer);
       schema_for_admin          postgres    false    9                       0    0 \   FUNCTION "Сотрудники_По_Автомобилю"("Автомобиль_id" integer)    ACL       GRANT ALL ON FUNCTION schema_for_admin."Сотрудники_По_Автомобилю"("Автомобиль_id" integer) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Сотрудники_По_Автомобилю"("Автомобиль_id" integer) TO "Админ";
          schema_for_admin          postgres    false    323            0           1255    196936 D   Список_Запчастей_По_Модели(character varying)    FUNCTION       CREATE FUNCTION schema_for_admin."Список_Запчастей_По_Модели"("автомобиль_модель" character varying) RETURNS TABLE("id_Запчасти" integer, "Наименование" character varying, "Артикул" character varying, "Описание" text, "Стоимость" numeric)
    LANGUAGE plpgsql
    AS $$
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
$$;
 �   DROP FUNCTION schema_for_admin."Список_Запчастей_По_Модели"("автомобиль_модель" character varying);
       schema_for_admin          postgres    false    9                       0    0 s   FUNCTION "Список_Запчастей_По_Модели"("автомобиль_модель" character varying)    ACL     J  GRANT ALL ON FUNCTION schema_for_admin."Список_Запчастей_По_Модели"("автомобиль_модель" character varying) TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Список_Запчастей_По_Модели"("автомобиль_модель" character varying) TO "Админ";
          schema_for_admin          postgres    false    304            /           1255    196938 A   Суммарная_Стоимость_Запчастей_ЗаП()    FUNCTION     �  CREATE FUNCTION schema_for_admin."Суммарная_Стоимость_Запчастей_ЗаП"() RETURNS TABLE("Суммарная_Стоимость" numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        COALESCE(SUM(z.Стоимость * pz.Количество), 0.00) AS Суммарная_Стоимость
    FROM
        Проданные_Запчасти_В_Заказе pz
    JOIN
        Запчасти z ON pz.ID_Запчасти = z.ID_Запчасти
    JOIN
        Заказы o ON pz.ID_Заказа = o.ID_Заказа
    WHERE
        o.Дата_Заказа >= (CURRENT_DATE - INTERVAL '1 month')
        AND o.Дата_Заказа <= CURRENT_DATE;
END;
$$;
 d   DROP FUNCTION schema_for_admin."Суммарная_Стоимость_Запчастей_ЗаП"();
       schema_for_admin          postgres    false    9                       0    0 L   FUNCTION "Суммарная_Стоимость_Запчастей_ЗаП"()    ACL     �   GRANT ALL ON FUNCTION schema_for_admin."Суммарная_Стоимость_Запчастей_ЗаП"() TO "ГлавМас";
GRANT ALL ON FUNCTION schema_for_admin."Суммарная_Стоимость_Запчастей_ЗаП"() TO "Админ";
          schema_for_admin          postgres    false    303                       1255    196939 &   Выгрузить_заказ(integer)    FUNCTION     �  CREATE FUNCTION schema_for_sadmin."Выгрузить_заказ"("Заказ_id" integer) RETURNS TABLE("id_Заказа" integer, "Дата_Заказа" date, "Статус_Заказа" character varying, "Имя_Владельца" character varying, "Фамилия_Владельца" character varying, "Марка_Авто" character varying, "Модель_Авто" character varying, "Проданная_Запчасть_Наименование" character varying, "Количество_Запчастей" integer, "Сумма_Платежа" numeric, "Дата_Платежа" date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Заказы.ID_Заказа,
        Заказы.Дата_Заказа,
        Заказы.Статус_Заказа,
        Владелец_Авто.Имя,
        Владелец_Авто.Фамилия,
        Марка_Модель.Марка,
        Марка_Модель.Модель,
        Проданные_Запчасти_В_Заказе.Проданная_Запчасть_Наименование,
        Проданные_Запчасти_В_Заказе.Количество,
        Платежи.Сумма_Платежа,
        Платежи.Дата_Платежа
    FROM
        Заказы
        JOIN Автомобили ON Заказы.ID_Автомобиля = Автомобили.ID_Автомобиля
        JOIN Владелец_Авто ON Автомобили.ID_Владельца = Владелец_Авто.ID_Владельца
        LEFT JOIN (
            SELECT
                Проданные_Запчасти_В_Заказе.ID_Заказа,
                Запчасти.Наименование AS Проданная_Запчасть_Наименование,
                Проданные_Запчасти_В_Заказе.Количество
            FROM Проданные_Запчасти_В_Заказе
            LEFT JOIN Запчасти ON Проданные_Запчасти_В_Заказе.ID_Запчасти = Запчасти.ID_Запчасти
        ) AS Проданные_Запчасти_В_Заказе ON Заказы.ID_Заказа = Проданные_Запчасти_В_Заказе.ID_Заказа
        LEFT JOIN (
            SELECT
                Платежи.ID_Заказа,
                SUM(Платежи.Сумма_платежа) AS Сумма_Платежа,
                MAX(Платежи.Дата_платежа) AS Дата_Платежа
            FROM Платежи
            GROUP BY Платежи.ID_Заказа
        ) AS Платежи ON Заказы.ID_Заказа = Платежи.ID_Заказа
        LEFT JOIN (
            SELECT
                Модель.ID_Модели,
                Марка.Название AS Марка,
                Модель.Название AS Модель
            FROM Модель
            JOIN Марка ON Модель.ID_Марки = Марка.ID_Марки
        ) AS Марка_Модель ON Автомобили.ID_Модели = Марка_Модель.ID_Модели
    WHERE
        Заказы.ID_Заказа = Заказ_ID;
END;
$$;
 Z   DROP FUNCTION schema_for_sadmin."Выгрузить_заказ"("Заказ_id" integer);
       schema_for_sadmin          postgres    false    7                       0    0 A   FUNCTION "Выгрузить_заказ"("Заказ_id" integer)    ACL     r   GRANT ALL ON FUNCTION schema_for_sadmin."Выгрузить_заказ"("Заказ_id" integer) TO "Админ";
          schema_for_sadmin          postgres    false    258            F           1255    197132 B   Расшифровать_Сотрудников(character varying)    FUNCTION       CREATE FUNCTION schema_for_sadmin."Расшифровать_Сотрудников"("ключ_param" character varying) RETURNS TABLE("id_Сотрудника" integer, "Имя" character varying, "Фамилия" character varying, "Отчество" character varying, "Должность" character varying, "Адрес" character varying, "Номер_Телефона" character varying, "Паспорт" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        "Сотрудники".ID_Сотрудника,
        "Сотрудники".Имя,
        "Сотрудники".Фамилия,
        "Сотрудники".Отчество,
        "Сотрудники".Должность,
        "Сотрудники".Адрес,
        "Сотрудники".Номер_Телефона,
        pgp_sym_decrypt("Сотрудники"."Паспорт"::bytea, ключ_param, 'compress-algo=0, cipher-algo=aes256')::VARCHAR(255) AS Паспорт
    FROM 
        "Сотрудники";
END;
$$;
 w   DROP FUNCTION schema_for_sadmin."Расшифровать_Сотрудников"("ключ_param" character varying);
       schema_for_sadmin          postgres    false    7                       1255    196950 &   Самая_Частая_Машина()    FUNCTION     9  CREATE FUNCTION schema_for_sadmin."Самая_Частая_Машина"() RETURNS TABLE("Марка" character varying, "Модель" character varying, "Год" character varying, "Количество_Посещений" bigint)
    LANGUAGE plpgsql
    AS $$
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
$$;
 J   DROP FUNCTION schema_for_sadmin."Самая_Частая_Машина"();
       schema_for_sadmin          postgres    false    7                       0    0 1   FUNCTION "Самая_Частая_Машина"()    ACL     b   GRANT ALL ON FUNCTION schema_for_sadmin."Самая_Частая_Машина"() TO "Админ";
          schema_for_sadmin          postgres    false    267            ;           1255    196952 &   Самый_Частый_Клиент()    FUNCTION     O  CREATE FUNCTION schema_for_sadmin."Самый_Частый_Клиент"() RETURNS TABLE("Имя" character varying, "Фамилия" character varying, "Отчество" character varying, "Телефон" character varying, "Количество_Посещений" integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        Владелец_Авто.Имя,
        Владелец_Авто.Фамилия,
        Владелец_Авто.Отчество,
        Владелец_Авто.Телефон,
        COUNT(DISTINCT Заказы.ID_Заказа)::INTEGER AS Количество_Посещений
    FROM
        Владелец_Авто
    LEFT JOIN
        Автомобили ON Владелец_Авто.ID_Владельца = Автомобили.ID_Владельца
    LEFT JOIN
        Заказы ON Автомобили.ID_Автомобиля = Заказы.ID_Автомобиля
    GROUP BY
        Владелец_Авто.ID_Владельца
    ORDER BY
        Количество_Посещений DESC
    LIMIT 1;
END;
$$;
 J   DROP FUNCTION schema_for_sadmin."Самый_Частый_Клиент"();
       schema_for_sadmin          postgres    false    7                       0    0 1   FUNCTION "Самый_Частый_Клиент"()    ACL     b   GRANT ALL ON FUNCTION schema_for_sadmin."Самый_Частый_Клиент"() TO "Админ";
          schema_for_sadmin          postgres    false    315                       1255    196945 ?   Суммарная_Выручка_За_Период(date, date)    FUNCTION     �  CREATE FUNCTION schema_for_sadmin."Суммарная_Выручка_За_Период"("Период_Начало" date, "Период_Конец" date) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    Общая_Сумма DECIMAL(10, 2);
    Общая_Стоимость DECIMAL(10, 2);
BEGIN
    Общая_Сумма := Суммарная_Выручка_От_Платежей(Период_Начало, Период_Конец);
    Общая_Стоимость := Суммарная_Стоимость_Проданных_Запчастей(Период_Начало, Период_Конец);

    RETURN Общая_Сумма + Общая_Стоимость;
END;
$$;
 �   DROP FUNCTION schema_for_sadmin."Суммарная_Выручка_За_Период"("Период_Начало" date, "Период_Конец" date);
       schema_for_sadmin          postgres    false    7            	           0    0 �   FUNCTION "Суммарная_Выручка_За_Период"("Период_Начало" date, "Период_Конец" date)    ACL     �   GRANT ALL ON FUNCTION schema_for_sadmin."Суммарная_Выручка_За_Период"("Период_Начало" date, "Период_Конец" date) TO "Админ";
          schema_for_sadmin          postgres    false    260            :           1255    196948 C   Суммарная_Выручка_От_Платежей(date, date)    FUNCTION     T  CREATE FUNCTION schema_for_sadmin."Суммарная_Выручка_От_Платежей"("Период_Начало" date, "Период_Конец" date) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    Общая_Сумма DECIMAL(10, 2);
BEGIN
    SELECT COALESCE(SUM(Платежи.Сумма_платежа), 0)
    INTO Общая_Сумма
    FROM Платежи
    WHERE
        Дата_платежа BETWEEN Период_Начало AND Период_Конец
        AND Статус_платежа = 'Выполнен';

    RETURN Общая_Сумма;
END;
$$;
 �   DROP FUNCTION schema_for_sadmin."Суммарная_Выручка_От_Платежей"("Период_Начало" date, "Период_Конец" date);
       schema_for_sadmin          postgres    false    7            
           0    0 �   FUNCTION "Суммарная_Выручка_От_Платежей"("Период_Начало" date, "Период_Конец" date)    ACL     �   GRANT ALL ON FUNCTION schema_for_sadmin."Суммарная_Выручка_От_Платежей"("Период_Начало" date, "Период_Конец" date) TO "Админ";
          schema_for_sadmin          postgres    false    314            9           1255    196949 K   Суммарная_Стоимость_Проданных_Зап(date, date)    FUNCTION     �  CREATE FUNCTION schema_for_sadmin."Суммарная_Стоимость_Проданных_Зап"("Период_Начало" date, "Период_Конец" date) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    Общая_Стоимость DECIMAL(10, 2);
BEGIN
    SELECT COALESCE(SUM(Запчасти.Стоимость * Проданные_Запчасти_В_Заказе.Количество), 0)
    INTO Общая_Стоимость
    FROM Проданные_Запчасти_В_Заказе
    LEFT JOIN Запчасти ON Проданные_Запчасти_В_Заказе.ID_Запчасти = Запчасти.ID_Запчасти
    WHERE
        Проданные_Запчасти_В_Заказе.Дата_изменения_статуса BETWEEN Период_Начало AND Период_Конец
        AND Проданные_Запчасти_В_Заказе.Статус = 'Отгружено';

    RETURN Общая_Стоимость;
END;
$$;
 �   DROP FUNCTION schema_for_sadmin."Суммарная_Стоимость_Проданных_Зап"("Период_Начало" date, "Период_Конец" date);
       schema_for_sadmin          postgres    false    7                       0    0 �   FUNCTION "Суммарная_Стоимость_Проданных_Зап"("Период_Начало" date, "Период_Конец" date)    ACL     �   GRANT ALL ON FUNCTION schema_for_sadmin."Суммарная_Стоимость_Проданных_Зап"("Период_Начало" date, "Период_Конец" date) TO "Админ";
          schema_for_sadmin          postgres    false    313            �            1259    196821 0   Автомобили_id_Автомобиля_seq    SEQUENCE     �   CREATE SEQUENCE public."Автомобили_id_Автомобиля_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public."Автомобили_id_Автомобиля_seq";
       public          postgres    false            �            1259    196822    Автомобили    TABLE     x  CREATE TABLE public."Автомобили" (
    "id_Автомобиля" integer DEFAULT nextval('public."Автомобили_id_Автомобиля_seq"'::regclass) NOT NULL,
    "id_Модели" integer,
    "Год" character varying(4),
    "Номер_СТС" character varying(10),
    "vin_Номер" character varying(18),
    "id_Владельца" integer
);
 *   DROP TABLE public."Автомобили";
       public         heap    postgres    false    226                       0    0    TABLE "Автомобили"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Автомобили" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Автомобили" TO "ГлавМас";
GRANT SELECT ON TABLE public."Автомобили" TO "Сотрудник";
          public          postgres    false    227            �            1259    196807 3   Владелец_Авто_id_Владельца_seq    SEQUENCE     �   CREATE SEQUENCE public."Владелец_Авто_id_Владельца_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 L   DROP SEQUENCE public."Владелец_Авто_id_Владельца_seq";
       public          postgres    false            �            1259    196808    Владелец_Авто    TABLE     �  CREATE TABLE public."Владелец_Авто" (
    "id_Владельца" integer DEFAULT nextval('public."Владелец_Авто_id_Владельца_seq"'::regclass) NOT NULL,
    "Имя" character varying(50),
    "Фамилия" character varying(50),
    "Отчество" character varying(50),
    "Телефон" character varying(11),
    "Адрес" character varying(155),
    "Номер_ВУ" character varying(10)
);
 /   DROP TABLE public."Владелец_Авто";
       public         heap    postgres    false    222                       0    0 !   TABLE "Владелец_Авто"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Владелец_Авто" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Владелец_Авто" TO "ГлавМас";
          public          postgres    false    223            �            1259    196902    График_Работы    TABLE     &  CREATE TABLE public."График_Работы" (
    "id_Графика" integer NOT NULL,
    "id_Сотрудника" integer,
    "Дата" date,
    "Время_Начала_Работы" time without time zone,
    "Время_Окончания_Работы" time without time zone
);
 /   DROP TABLE public."График_Работы";
       public         heap    postgres    false                       0    0 !   TABLE "График_Работы"    ACL       GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."График_Работы" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."График_Работы" TO "ГлавМас";
GRANT SELECT ON TABLE public."График_Работы" TO "Сотрудник";
          public          postgres    false    239            �            1259    196901 /   График_Работы_id_Графика_seq    SEQUENCE     �   CREATE SEQUENCE public."График_Работы_id_Графика_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 H   DROP SEQUENCE public."График_Работы_id_Графика_seq";
       public          postgres    false    239                       0    0 /   График_Работы_id_Графика_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."График_Работы_id_Графика_seq" OWNED BY public."График_Работы"."id_Графика";
          public          postgres    false    238            �            1259    196847     Заказы_id_Заказа_seq    SEQUENCE     �   CREATE SEQUENCE public."Заказы_id_Заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."Заказы_id_Заказа_seq";
       public          postgres    false            �            1259    196848    Заказы    TABLE     D  CREATE TABLE public."Заказы" (
    "id_Заказа" integer DEFAULT nextval('public."Заказы_id_Заказа_seq"'::regclass) NOT NULL,
    "Дата_Заказа" date,
    "Статус_Заказа" character varying(50),
    "Описание_Проблемы" text,
    "id_Автомобиля" integer
);
 "   DROP TABLE public."Заказы";
       public         heap    postgres    false    230                       0    0    TABLE "Заказы"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Заказы" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Заказы" TO "ГлавМас";
GRANT SELECT ON TABLE public."Заказы" TO "Сотрудник";
          public          postgres    false    231            �            1259    196839    Запчасти    TABLE     �   CREATE TABLE public."Запчасти" (
    "id_Запчасти" integer NOT NULL,
    "Наименование" character varying(100),
    "Артикул" character varying(8),
    "Описание" text,
    "Стоимость" numeric(10,2)
);
 &   DROP TABLE public."Запчасти";
       public         heap    postgres    false                       0    0    TABLE "Запчасти"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Запчасти" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Запчасти" TO "ГлавМас";
GRANT SELECT ON TABLE public."Запчасти" TO "Сотрудник";
          public          postgres    false    229            �            1259    196838 (   Запчасти_id_Запчасти_seq    SEQUENCE     �   CREATE SEQUENCE public."Запчасти_id_Запчасти_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public."Запчасти_id_Запчасти_seq";
       public          postgres    false    229                       0    0 (   Запчасти_id_Запчасти_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public."Запчасти_id_Запчасти_seq" OWNED BY public."Запчасти"."id_Запчасти";
          public          postgres    false    228            �            1259    196788    Марка_id_Марки_seq    SEQUENCE     �   CREATE SEQUENCE public."Марка_id_Марки_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public."Марка_id_Марки_seq";
       public          postgres    false            �            1259    196789 
   Марка    TABLE     �   CREATE TABLE public."Марка" (
    "id_Марки" integer DEFAULT nextval('public."Марка_id_Марки_seq"'::regclass) NOT NULL,
    "Название" character varying(50) NOT NULL
);
     DROP TABLE public."Марка";
       public         heap    postgres    false    218                       0    0    TABLE "Марка"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Марка" TO "Админ";
GRANT SELECT ON TABLE public."Марка" TO "Сотрудник";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Марка" TO "ГлавМас";
          public          postgres    false    219            �            1259    196795     Модель_id_Модели_seq    SEQUENCE     �   CREATE SEQUENCE public."Модель_id_Модели_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."Модель_id_Модели_seq";
       public          postgres    false            �            1259    196796    Модель    TABLE     �   CREATE TABLE public."Модель" (
    "id_Модели" integer DEFAULT nextval('public."Модель_id_Модели_seq"'::regclass) NOT NULL,
    "id_Марки" integer,
    "Название" character varying(50) NOT NULL
);
 "   DROP TABLE public."Модель";
       public         heap    postgres    false    220                       0    0    TABLE "Модель"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Модель" TO "Админ";
GRANT SELECT ON TABLE public."Модель" TO "Сотрудник";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Модель" TO "ГлавМас";
          public          postgres    false    221            �            1259    196879    Платежи    TABLE     �   CREATE TABLE public."Платежи" (
    "id_Платежа" integer NOT NULL,
    "Сумма_платежа" numeric(10,2),
    "Дата_платежа" date,
    "Статус_платежа" text,
    "id_Заказа" integer
);
 $   DROP TABLE public."Платежи";
       public         heap    postgres    false                       0    0    TABLE "Платежи"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Платежи" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Платежи" TO "ГлавМас";
          public          postgres    false    235            �            1259    196878 $   Платежи_id_Платежа_seq    SEQUENCE     �   CREATE SEQUENCE public."Платежи_id_Платежа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public."Платежи_id_Платежа_seq";
       public          postgres    false    235                       0    0 $   Платежи_id_Платежа_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public."Платежи_id_Платежа_seq" OWNED BY public."Платежи"."id_Платежа";
          public          postgres    false    234            �            1259    196861 >   Проданные_Запча_id_Проданной_Зап_seq    SEQUENCE     �   CREATE SEQUENCE public."Проданные_Запча_id_Проданной_Зап_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 W   DROP SEQUENCE public."Проданные_Запча_id_Проданной_Зап_seq";
       public          postgres    false            �            1259    196862 3   Проданные_Запчасти_В_Заказе    TABLE     �  CREATE TABLE public."Проданные_Запчасти_В_Заказе" (
    "id_Проданной_Запчасти" integer DEFAULT nextval('public."Проданные_Запча_id_Проданной_Зап_seq"'::regclass) NOT NULL,
    "id_Заказа" integer,
    "Статус" character varying(50),
    "Дата_изменения_статуса" timestamp without time zone,
    "id_Запчасти" integer,
    "Количество" integer
);
 I   DROP TABLE public."Проданные_Запчасти_В_Заказе";
       public         heap    postgres    false    232                       0    0 ;   TABLE "Проданные_Запчасти_В_Заказе"    ACL     b  GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Проданные_Запчасти_В_Заказе" TO "Админ";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Проданные_Запчасти_В_Заказе" TO "ГлавМас";
GRANT SELECT ON TABLE public."Проданные_Запчасти_В_Заказе" TO "Сотрудник";
          public          postgres    false    233            �            1259    196815    Сотрудники    TABLE     �  CREATE TABLE public."Сотрудники" (
    "id_Сотрудника" integer NOT NULL,
    "Имя" character varying(50),
    "Фамилия" character varying(50),
    "Отчество" character varying(50),
    "Должность" character varying(50),
    "Адрес" character varying(155),
    "Номер_Телефона" character varying(11),
    "Паспорт" character varying(255)
);
 *   DROP TABLE public."Сотрудники";
       public         heap    postgres    false                       0    0    TABLE "Сотрудники"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Сотрудники" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Сотрудники" TO "ГлавМас";
GRANT SELECT ON TABLE public."Сотрудники" TO "Сотрудник";
          public          postgres    false    225            �            1259    196814 0   Сотрудники_id_Сотрудника_seq    SEQUENCE     �   CREATE SEQUENCE public."Сотрудники_id_Сотрудника_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public."Сотрудники_id_Сотрудника_seq";
       public          postgres    false    225                       0    0 0   Сотрудники_id_Сотрудника_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."Сотрудники_id_Сотрудника_seq" OWNED BY public."Сотрудники"."id_Сотрудника";
          public          postgres    false    224            �            1259    196893    Услуги    TABLE     �   CREATE TABLE public."Услуги" (
    "id_Услуги" integer NOT NULL,
    "Вид_Услуги" character varying(100),
    "Описание_Услуги" text,
    "Стоимость_Услуги" numeric(10,2)
);
 "   DROP TABLE public."Услуги";
       public         heap    postgres    false                       0    0    TABLE "Услуги"    ACL     �   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Услуги" TO "Админ";
GRANT SELECT,INSERT,UPDATE ON TABLE public."Услуги" TO "ГлавМас";
GRANT SELECT ON TABLE public."Услуги" TO "Сотрудник";
          public          postgres    false    237            �            1259    196892     Услуги_id_Услуги_seq    SEQUENCE     �   CREATE SEQUENCE public."Услуги_id_Услуги_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."Услуги_id_Услуги_seq";
       public          postgres    false    237                       0    0     Услуги_id_Услуги_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public."Услуги_id_Услуги_seq" OWNED BY public."Услуги"."id_Услуги";
          public          postgres    false    236            �            1259    196914    Услуги_В_Заказе    TABLE     :  CREATE TABLE public."Услуги_В_Заказе" (
    "id_Истории_Заказа" integer NOT NULL,
    "id_Заказ" integer,
    "Статус" character varying(50),
    "Дата_Изменения" timestamp without time zone,
    "id_Сотрудника" integer,
    "id_Услуги" integer
);
 2   DROP TABLE public."Услуги_В_Заказе";
       public         heap    postgres    false                       0    0 $   TABLE "Услуги_В_Заказе"    ACL       GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Услуги_В_Заказе" TO "Админ";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Услуги_В_Заказе" TO "ГлавМас";
GRANT SELECT ON TABLE public."Услуги_В_Заказе" TO "Сотрудник";
          public          postgres    false    241            �            1259    196913 ?   Услуги_В_Заказе_id_Истории_Заказа_seq    SEQUENCE     �   CREATE SEQUENCE public."Услуги_В_Заказе_id_Истории_Заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 X   DROP SEQUENCE public."Услуги_В_Заказе_id_Истории_Заказа_seq";
       public          postgres    false    241                       0    0 ?   Услуги_В_Заказе_id_Истории_Заказа_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public."Услуги_В_Заказе_id_Истории_Заказа_seq" OWNED BY public."Услуги_В_Заказе"."id_Истории_Заказа";
          public          postgres    false    240            �           2604    196905 +   График_Работы id_Графика    DEFAULT     �   ALTER TABLE ONLY public."График_Работы" ALTER COLUMN "id_Графика" SET DEFAULT nextval('public."График_Работы_id_Графика_seq"'::regclass);
 ^   ALTER TABLE public."График_Работы" ALTER COLUMN "id_Графика" DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    196842 $   Запчасти id_Запчасти    DEFAULT     �   ALTER TABLE ONLY public."Запчасти" ALTER COLUMN "id_Запчасти" SET DEFAULT nextval('public."Запчасти_id_Запчасти_seq"'::regclass);
 W   ALTER TABLE public."Запчасти" ALTER COLUMN "id_Запчасти" DROP DEFAULT;
       public          postgres    false    228    229    229            �           2604    196882     Платежи id_Платежа    DEFAULT     �   ALTER TABLE ONLY public."Платежи" ALTER COLUMN "id_Платежа" SET DEFAULT nextval('public."Платежи_id_Платежа_seq"'::regclass);
 S   ALTER TABLE public."Платежи" ALTER COLUMN "id_Платежа" DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    196818 ,   Сотрудники id_Сотрудника    DEFAULT     �   ALTER TABLE ONLY public."Сотрудники" ALTER COLUMN "id_Сотрудника" SET DEFAULT nextval('public."Сотрудники_id_Сотрудника_seq"'::regclass);
 _   ALTER TABLE public."Сотрудники" ALTER COLUMN "id_Сотрудника" DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    196896    Услуги id_Услуги    DEFAULT     �   ALTER TABLE ONLY public."Услуги" ALTER COLUMN "id_Услуги" SET DEFAULT nextval('public."Услуги_id_Услуги_seq"'::regclass);
 O   ALTER TABLE public."Услуги" ALTER COLUMN "id_Услуги" DROP DEFAULT;
       public          postgres    false    236    237    237            �           2604    196917 ;   Услуги_В_Заказе id_Истории_Заказа    DEFAULT     �   ALTER TABLE ONLY public."Услуги_В_Заказе" ALTER COLUMN "id_Истории_Заказа" SET DEFAULT nextval('public."Услуги_В_Заказе_id_Истории_Заказа_seq"'::regclass);
 n   ALTER TABLE public."Услуги_В_Заказе" ALTER COLUMN "id_Истории_Заказа" DROP DEFAULT;
       public          postgres    false    240    241    241            �          0    196822    Автомобили 
   TABLE DATA           �   COPY public."Автомобили" ("id_Автомобиля", "id_Модели", "Год", "Номер_СТС", "vin_Номер", "id_Владельца") FROM stdin;
    public          postgres    false    227   �      �          0    196808    Владелец_Авто 
   TABLE DATA           �   COPY public."Владелец_Авто" ("id_Владельца", "Имя", "Фамилия", "Отчество", "Телефон", "Адрес", "Номер_ВУ") FROM stdin;
    public          postgres    false    223   Ϳ      �          0    196902    График_Работы 
   TABLE DATA           �   COPY public."График_Работы" ("id_Графика", "id_Сотрудника", "Дата", "Время_Начала_Работы", "Время_Окончания_Работы") FROM stdin;
    public          postgres    false    239   �      �          0    196848    Заказы 
   TABLE DATA           �   COPY public."Заказы" ("id_Заказа", "Дата_Заказа", "Статус_Заказа", "Описание_Проблемы", "id_Автомобиля") FROM stdin;
    public          postgres    false    231   ��      �          0    196839    Запчасти 
   TABLE DATA           �   COPY public."Запчасти" ("id_Запчасти", "Наименование", "Артикул", "Описание", "Стоимость") FROM stdin;
    public          postgres    false    229   �      �          0    196789 
   Марка 
   TABLE DATA           K   COPY public."Марка" ("id_Марки", "Название") FROM stdin;
    public          postgres    false    219   ��      �          0    196796    Модель 
   TABLE DATA           `   COPY public."Модель" ("id_Модели", "id_Марки", "Название") FROM stdin;
    public          postgres    false    221   %�      �          0    196879    Платежи 
   TABLE DATA           �   COPY public."Платежи" ("id_Платежа", "Сумма_платежа", "Дата_платежа", "Статус_платежа", "id_Заказа") FROM stdin;
    public          postgres    false    235   ��      �          0    196862 3   Проданные_Запчасти_В_Заказе 
   TABLE DATA           �   COPY public."Проданные_Запчасти_В_Заказе" ("id_Проданной_Запчасти", "id_Заказа", "Статус", "Дата_изменения_статуса", "id_Запчасти", "Количество") FROM stdin;
    public          postgres    false    233   [�      �          0    196815    Сотрудники 
   TABLE DATA           �   COPY public."Сотрудники" ("id_Сотрудника", "Имя", "Фамилия", "Отчество", "Должность", "Адрес", "Номер_Телефона", "Паспорт") FROM stdin;
    public          postgres    false    225   �      �          0    196893    Услуги 
   TABLE DATA           �   COPY public."Услуги" ("id_Услуги", "Вид_Услуги", "Описание_Услуги", "Стоимость_Услуги") FROM stdin;
    public          postgres    false    237   J�      �          0    196914    Услуги_В_Заказе 
   TABLE DATA           �   COPY public."Услуги_В_Заказе" ("id_Истории_Заказа", "id_Заказ", "Статус", "Дата_Изменения", "id_Сотрудника", "id_Услуги") FROM stdin;
    public          postgres    false    241   !�                 0    0 0   Автомобили_id_Автомобиля_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public."Автомобили_id_Автомобиля_seq"', 16, true);
          public          postgres    false    226                       0    0 3   Владелец_Авто_id_Владельца_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public."Владелец_Авто_id_Владельца_seq"', 13, true);
          public          postgres    false    222                        0    0 /   График_Работы_id_Графика_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public."График_Работы_id_Графика_seq"', 10, true);
          public          postgres    false    238            !           0    0     Заказы_id_Заказа_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."Заказы_id_Заказа_seq"', 12, true);
          public          postgres    false    230            "           0    0 (   Запчасти_id_Запчасти_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public."Запчасти_id_Запчасти_seq"', 10, true);
          public          postgres    false    228            #           0    0    Марка_id_Марки_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."Марка_id_Марки_seq"', 6, true);
          public          postgres    false    218            $           0    0     Модель_id_Модели_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."Модель_id_Модели_seq"', 15, true);
          public          postgres    false    220            %           0    0 $   Платежи_id_Платежа_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public."Платежи_id_Платежа_seq"', 11, true);
          public          postgres    false    234            &           0    0 >   Проданные_Запча_id_Проданной_Зап_seq    SEQUENCE SET     o   SELECT pg_catalog.setval('public."Проданные_Запча_id_Проданной_Зап_seq"', 13, true);
          public          postgres    false    232            '           0    0 0   Сотрудники_id_Сотрудника_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public."Сотрудники_id_Сотрудника_seq"', 10, true);
          public          postgres    false    224            (           0    0     Услуги_id_Услуги_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public."Услуги_id_Услуги_seq"', 10, true);
          public          postgres    false    236            )           0    0 ?   Услуги_В_Заказе_id_Истории_Заказа_seq    SEQUENCE SET     p   SELECT pg_catalog.setval('public."Услуги_В_Заказе_id_Истории_Заказа_seq"', 10, true);
          public          postgres    false    240            �           2606    196827 .   Автомобили Автомобили_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Автомобили"
    ADD CONSTRAINT "Автомобили_pkey" PRIMARY KEY ("id_Автомобиля");
 \   ALTER TABLE ONLY public."Автомобили" DROP CONSTRAINT "Автомобили_pkey";
       public            postgres    false    227            �           2606    196813 8   Владелец_Авто Владелец_Авто_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Владелец_Авто"
    ADD CONSTRAINT "Владелец_Авто_pkey" PRIMARY KEY ("id_Владельца");
 f   ALTER TABLE ONLY public."Владелец_Авто" DROP CONSTRAINT "Владелец_Авто_pkey";
       public            postgres    false    223                       2606    196907 8   График_Работы График_Работы_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."График_Работы"
    ADD CONSTRAINT "График_Работы_pkey" PRIMARY KEY ("id_Графика");
 f   ALTER TABLE ONLY public."График_Работы" DROP CONSTRAINT "График_Работы_pkey";
       public            postgres    false    239                       2606    196855    Заказы Заказы_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Заказы"
    ADD CONSTRAINT "Заказы_pkey" PRIMARY KEY ("id_Заказа");
 L   ALTER TABLE ONLY public."Заказы" DROP CONSTRAINT "Заказы_pkey";
       public            postgres    false    231                       2606    196846 &   Запчасти Запчасти_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public."Запчасти"
    ADD CONSTRAINT "Запчасти_pkey" PRIMARY KEY ("id_Запчасти");
 T   ALTER TABLE ONLY public."Запчасти" DROP CONSTRAINT "Запчасти_pkey";
       public            postgres    false    229            �           2606    196794    Марка Марка_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public."Марка"
    ADD CONSTRAINT "Марка_pkey" PRIMARY KEY ("id_Марки");
 H   ALTER TABLE ONLY public."Марка" DROP CONSTRAINT "Марка_pkey";
       public            postgres    false    219            �           2606    196801    Модель Модель_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Модель"
    ADD CONSTRAINT "Модель_pkey" PRIMARY KEY ("id_Модели");
 L   ALTER TABLE ONLY public."Модель" DROP CONSTRAINT "Модель_pkey";
       public            postgres    false    221                       2606    196886 "   Платежи Платежи_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public."Платежи"
    ADD CONSTRAINT "Платежи_pkey" PRIMARY KEY ("id_Платежа");
 P   ALTER TABLE ONLY public."Платежи" DROP CONSTRAINT "Платежи_pkey";
       public            postgres    false    235                       2606    196867 l   Проданные_Запчасти_В_Заказе Проданные_Запчасти_В_Заказе_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе"
    ADD CONSTRAINT "Проданные_Запчасти_В_Заказе_pkey" PRIMARY KEY ("id_Проданной_Запчасти");
 �   ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе" DROP CONSTRAINT "Проданные_Запчасти_В_Заказе_pkey";
       public            postgres    false    233            �           2606    196820 .   Сотрудники Сотрудники_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Сотрудники"
    ADD CONSTRAINT "Сотрудники_pkey" PRIMARY KEY ("id_Сотрудника");
 \   ALTER TABLE ONLY public."Сотрудники" DROP CONSTRAINT "Сотрудники_pkey";
       public            postgres    false    225            	           2606    196900    Услуги Услуги_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public."Услуги"
    ADD CONSTRAINT "Услуги_pkey" PRIMARY KEY ("id_Услуги");
 L   ALTER TABLE ONLY public."Услуги" DROP CONSTRAINT "Услуги_pkey";
       public            postgres    false    237                       2606    196919 >   Услуги_В_Заказе Услуги_В_Заказе_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Услуги_В_Заказе"
    ADD CONSTRAINT "Услуги_В_Заказе_pkey" PRIMARY KEY ("id_Истории_Заказа");
 l   ALTER TABLE ONLY public."Услуги_В_Заказе" DROP CONSTRAINT "Услуги_В_Заказе_pkey";
       public            postgres    false    241                        2620    196994 '   Заказы check_order_status_trigger    TRIGGER     �   CREATE TRIGGER check_order_status_trigger BEFORE UPDATE ON public."Заказы" FOR EACH ROW EXECUTE FUNCTION hiddent.check_order_status();
 B   DROP TRIGGER check_order_status_trigger ON public."Заказы";
       public          postgres    false    316    231            "           2620    197002 +   Платежи check_payment_amount_trigger    TRIGGER     �   CREATE TRIGGER check_payment_amount_trigger BEFORE INSERT OR UPDATE ON public."Платежи" FOR EACH ROW EXECUTE FUNCTION hiddent.check_payment_amount();
 F   DROP TRIGGER check_payment_amount_trigger ON public."Платежи";
       public          postgres    false    235    317                       2620    196992 4   Владелец_Авто check_phone_number_trigger    TRIGGER     �   CREATE TRIGGER check_phone_number_trigger BEFORE INSERT OR UPDATE ON public."Владелец_Авто" FOR EACH ROW EXECUTE FUNCTION hiddent.check_phone_number();
 O   DROP TRIGGER check_phone_number_trigger ON public."Владелец_Авто";
       public          postgres    false    223    318            !           2620    197004 #   Заказы set_order_date_trigger    TRIGGER     �   CREATE TRIGGER set_order_date_trigger BEFORE INSERT ON public."Заказы" FOR EACH ROW EXECUTE FUNCTION hiddent.set_order_date();
 >   DROP TRIGGER set_order_date_trigger ON public."Заказы";
       public          postgres    false    295    231            #           2620    197006 &   Платежи set_paying_date_trigger    TRIGGER     �   CREATE TRIGGER set_paying_date_trigger BEFORE INSERT ON public."Платежи" FOR EACH ROW EXECUTE FUNCTION hiddent.set_paying_date();
 A   DROP TRIGGER set_paying_date_trigger ON public."Платежи";
       public          postgres    false    296    235                       2620    196990 (   Автомобили trigger_check_brand    TRIGGER     �   CREATE TRIGGER trigger_check_brand BEFORE INSERT ON public."Автомобили" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Марка"();
 C   DROP TRIGGER trigger_check_brand ON public."Автомобили";
       public          postgres    false    227    319                       2620    196995    Марка trigger_check_brand    TRIGGER     �   CREATE TRIGGER trigger_check_brand BEFORE INSERT ON public."Марка" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Марка"();
 9   DROP TRIGGER trigger_check_brand ON public."Марка";
       public          postgres    false    219    319                       2620    196981 .   Владелец_Авто trigger_check_Имя    TRIGGER     �   CREATE TRIGGER "trigger_check_Имя" BEFORE INSERT ON public."Владелец_Авто" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Имя"();
 K   DROP TRIGGER "trigger_check_Имя" ON public."Владелец_Авто";
       public          postgres    false    264    223                       2620    196998 '   Модель trigger_check_Модель    TRIGGER     �   CREATE TRIGGER "trigger_check_Модель" BEFORE INSERT ON public."Модель" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Модель"();
 D   DROP TRIGGER "trigger_check_Модель" ON public."Модель";
       public          postgres    false    221    320                       2620    196987 8   Владелец_Авто trigger_check_Отчество    TRIGGER     �   CREATE TRIGGER "trigger_check_Отчество" BEFORE INSERT ON public."Владелец_Авто" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Отчество"();
 U   DROP TRIGGER "trigger_check_Отчество" ON public."Владелец_Авто";
       public          postgres    false    223    265                       2620    196979 6   Владелец_Авто trigger_check_Фамилия    TRIGGER     �   CREATE TRIGGER "trigger_check_Фамилия" BEFORE INSERT ON public."Владелец_Авто" FOR EACH ROW EXECUTE FUNCTION hiddent."check_Фамилия"();
 S   DROP TRIGGER "trigger_check_Фамилия" ON public."Владелец_Авто";
       public          postgres    false    223    266                       2606    196833 D   Автомобили Автомобили_id_Владельца_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Автомобили"
    ADD CONSTRAINT "Автомобили_id_Владельца_fkey" FOREIGN KEY ("id_Владельца") REFERENCES public."Владелец_Авто"("id_Владельца") ON DELETE CASCADE;
 r   ALTER TABLE ONLY public."Автомобили" DROP CONSTRAINT "Автомобили_id_Владельца_fkey";
       public          postgres    false    3323    227    223                       2606    196828 >   Автомобили Автомобили_id_Модели_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Автомобили"
    ADD CONSTRAINT "Автомобили_id_Модели_fkey" FOREIGN KEY ("id_Модели") REFERENCES public."Модель"("id_Модели") ON DELETE CASCADE;
 l   ALTER TABLE ONLY public."Автомобили" DROP CONSTRAINT "Автомобили_id_Модели_fkey";
       public          postgres    false    221    3321    227                       2606    196908 P   График_Работы График_Работы_id_Сотрудника_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."График_Работы"
    ADD CONSTRAINT "График_Работы_id_Сотрудника_fkey" FOREIGN KEY ("id_Сотрудника") REFERENCES public."Сотрудники"("id_Сотрудника") ON DELETE CASCADE;
 ~   ALTER TABLE ONLY public."График_Работы" DROP CONSTRAINT "График_Работы_id_Сотрудника_fkey";
       public          postgres    false    3325    225    239                       2606    196856 6   Заказы Заказы_id_Автомобиля_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Заказы"
    ADD CONSTRAINT "Заказы_id_Автомобиля_fkey" FOREIGN KEY ("id_Автомобиля") REFERENCES public."Автомобили"("id_Автомобиля") ON DELETE CASCADE;
 d   ALTER TABLE ONLY public."Заказы" DROP CONSTRAINT "Заказы_id_Автомобиля_fkey";
       public          postgres    false    231    3327    227                       2606    196802 ,   Модель Модель_id_Марки_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Модель"
    ADD CONSTRAINT "Модель_id_Марки_fkey" FOREIGN KEY ("id_Марки") REFERENCES public."Марка"("id_Марки") ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public."Модель" DROP CONSTRAINT "Модель_id_Марки_fkey";
       public          postgres    false    221    219    3319                       2606    196887 2   Платежи Платежи_id_Заказа_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Платежи"
    ADD CONSTRAINT "Платежи_id_Заказа_fkey" FOREIGN KEY ("id_Заказа") REFERENCES public."Заказы"("id_Заказа") ON DELETE CASCADE;
 `   ALTER TABLE ONLY public."Платежи" DROP CONSTRAINT "Платежи_id_Заказа_fkey";
       public          postgres    false    231    3331    235                       2606    196873 s   Проданные_Запчасти_В_Заказе Проданные_Запчасти_В_id_Запчасти_fkey    FK CONSTRAINT       ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе"
    ADD CONSTRAINT "Проданные_Запчасти_В_id_Запчасти_fkey" FOREIGN KEY ("id_Запчасти") REFERENCES public."Запчасти"("id_Запчасти") ON DELETE CASCADE;
 �   ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе" DROP CONSTRAINT "Проданные_Запчасти_В_id_Запчасти_fkey";
       public          postgres    false    229    233    3329                       2606    196868 r   Проданные_Запчасти_В_Заказе Проданные_Запчасти_В_З_id_Заказа_fkey    FK CONSTRAINT     	  ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе"
    ADD CONSTRAINT "Проданные_Запчасти_В_З_id_Заказа_fkey" FOREIGN KEY ("id_Заказа") REFERENCES public."Заказы"("id_Заказа") ON DELETE CASCADE;
 �   ALTER TABLE ONLY public."Проданные_Запчасти_В_Заказе" DROP CONSTRAINT "Проданные_Запчасти_В_З_id_Заказа_fkey";
       public          postgres    false    231    233    3331                       2606    196920 L   Услуги_В_Заказе Услуги_В_Заказе_id_Заказ_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Услуги_В_Заказе"
    ADD CONSTRAINT "Услуги_В_Заказе_id_Заказ_fkey" FOREIGN KEY ("id_Заказ") REFERENCES public."Заказы"("id_Заказа") ON DELETE CASCADE;
 z   ALTER TABLE ONLY public."Услуги_В_Заказе" DROP CONSTRAINT "Услуги_В_Заказе_id_Заказ_fkey";
       public          postgres    false    3331    231    241                       2606    196925 V   Услуги_В_Заказе Услуги_В_Заказе_id_Сотрудника_fkey    FK CONSTRAINT       ALTER TABLE ONLY public."Услуги_В_Заказе"
    ADD CONSTRAINT "Услуги_В_Заказе_id_Сотрудника_fkey" FOREIGN KEY ("id_Сотрудника") REFERENCES public."Сотрудники"("id_Сотрудника") ON DELETE CASCADE;
 �   ALTER TABLE ONLY public."Услуги_В_Заказе" DROP CONSTRAINT "Услуги_В_Заказе_id_Сотрудника_fkey";
       public          postgres    false    3325    225    241                       2606    196930 N   Услуги_В_Заказе Услуги_В_Заказе_id_Услуги_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Услуги_В_Заказе"
    ADD CONSTRAINT "Услуги_В_Заказе_id_Услуги_fkey" FOREIGN KEY ("id_Услуги") REFERENCES public."Услуги"("id_Услуги") ON DELETE CASCADE;
 |   ALTER TABLE ONLY public."Услуги_В_Заказе" DROP CONSTRAINT "Услуги_В_Заказе_id_Услуги_fkey";
       public          postgres    false    237    241    3337            �           3256    197149 '   Автомобили rls_Админ_all    POLICY     b   CREATE POLICY "rls_Админ_all" ON public."Автомобили" TO "Админ" USING (true);
 C   DROP POLICY "rls_Админ_all" ON public."Автомобили";
       public          postgres    false    227            �           3256    197137 ,   График_Работы rls_Админ_all    POLICY     g   CREATE POLICY "rls_Админ_all" ON public."График_Работы" TO "Админ" USING (true);
 H   DROP POLICY "rls_Админ_all" ON public."График_Работы";
       public          postgres    false    239            �           3256    197145    Заказы rls_Админ_all    POLICY     Z   CREATE POLICY "rls_Админ_all" ON public."Заказы" TO "Админ" USING (true);
 ;   DROP POLICY "rls_Админ_all" ON public."Заказы";
       public          postgres    false    231            �           3256    197157 #   Запчасти rls_Админ_all    POLICY     ^   CREATE POLICY "rls_Админ_all" ON public."Запчасти" TO "Админ" USING (true);
 ?   DROP POLICY "rls_Админ_all" ON public."Запчасти";
       public          postgres    false    229            �           3256    197152 F   Проданные_Запчасти_В_Заказе rls_Админ_all    POLICY     �   CREATE POLICY "rls_Админ_all" ON public."Проданные_Запчасти_В_Заказе" TO "Админ" USING (true);
 b   DROP POLICY "rls_Админ_all" ON public."Проданные_Запчасти_В_Заказе";
       public          postgres    false    233            �           3256    197134 '   Сотрудники rls_Админ_all    POLICY     b   CREATE POLICY "rls_Админ_all" ON public."Сотрудники" TO "Админ" USING (true);
 C   DROP POLICY "rls_Админ_all" ON public."Сотрудники";
       public          postgres    false    225            �           3256    197140 /   Услуги_В_Заказе rls_Админ_all    POLICY     j   CREATE POLICY "rls_Админ_all" ON public."Услуги_В_Заказе" TO "Админ" USING (true);
 K   DROP POLICY "rls_Админ_all" ON public."Услуги_В_Заказе";
       public          postgres    false    241            �           3256    197155 J   Проданные_Запчасти_В_Заказе rls_ГлавМас_del    POLICY     �   CREATE POLICY "rls_ГлавМас_del" ON public."Проданные_Запчасти_В_Заказе" FOR DELETE TO "ГлавМас" USING (true);
 f   DROP POLICY "rls_ГлавМас_del" ON public."Проданные_Запчасти_В_Заказе";
       public          postgres    false    233            �           3256    197143 3   Услуги_В_Заказе rls_ГлавМас_del    POLICY     }   CREATE POLICY "rls_ГлавМас_del" ON public."Услуги_В_Заказе" FOR DELETE TO "ГлавМас" USING (true);
 O   DROP POLICY "rls_ГлавМас_del" ON public."Услуги_В_Заказе";
       public          postgres    false    241            �           3256    197150 +   Автомобили rls_ГлавМас_sel    POLICY     u   CREATE POLICY "rls_ГлавМас_sel" ON public."Автомобили" FOR SELECT TO "ГлавМас" USING (true);
 G   DROP POLICY "rls_ГлавМас_sel" ON public."Автомобили";
       public          postgres    false    227            �           3256    197138 0   График_Работы rls_ГлавМас_sel    POLICY     z   CREATE POLICY "rls_ГлавМас_sel" ON public."График_Работы" FOR SELECT TO "ГлавМас" USING (true);
 L   DROP POLICY "rls_ГлавМас_sel" ON public."График_Работы";
       public          postgres    false    239            �           3256    197146 #   Заказы rls_ГлавМас_sel    POLICY     m   CREATE POLICY "rls_ГлавМас_sel" ON public."Заказы" FOR SELECT TO "ГлавМас" USING (true);
 ?   DROP POLICY "rls_ГлавМас_sel" ON public."Заказы";
       public          postgres    false    231            �           3256    197158 '   Запчасти rls_ГлавМас_sel    POLICY     q   CREATE POLICY "rls_ГлавМас_sel" ON public."Запчасти" FOR SELECT TO "ГлавМас" USING (true);
 C   DROP POLICY "rls_ГлавМас_sel" ON public."Запчасти";
       public          postgres    false    229            �           3256    197153 J   Проданные_Запчасти_В_Заказе rls_ГлавМас_sel    POLICY     �   CREATE POLICY "rls_ГлавМас_sel" ON public."Проданные_Запчасти_В_Заказе" FOR SELECT TO "ГлавМас" USING (true);
 f   DROP POLICY "rls_ГлавМас_sel" ON public."Проданные_Запчасти_В_Заказе";
       public          postgres    false    233            �           3256    197135 +   Сотрудники rls_ГлавМас_sel    POLICY     u   CREATE POLICY "rls_ГлавМас_sel" ON public."Сотрудники" FOR SELECT TO "ГлавМас" USING (true);
 G   DROP POLICY "rls_ГлавМас_sel" ON public."Сотрудники";
       public          postgres    false    225            �           3256    197141 3   Услуги_В_Заказе rls_ГлавМас_sel    POLICY     }   CREATE POLICY "rls_ГлавМас_sel" ON public."Услуги_В_Заказе" FOR SELECT TO "ГлавМас" USING (true);
 O   DROP POLICY "rls_ГлавМас_sel" ON public."Услуги_В_Заказе";
       public          postgres    false    241            �           3256    197147 "   Заказы rls_ГлавМас_up    POLICY     l   CREATE POLICY "rls_ГлавМас_up" ON public."Заказы" FOR UPDATE TO "ГлавМас" USING (true);
 >   DROP POLICY "rls_ГлавМас_up" ON public."Заказы";
       public          postgres    false    231            �           3256    197154 I   Проданные_Запчасти_В_Заказе rls_ГлавМас_up    POLICY     �   CREATE POLICY "rls_ГлавМас_up" ON public."Проданные_Запчасти_В_Заказе" FOR UPDATE TO "ГлавМас" USING (true);
 e   DROP POLICY "rls_ГлавМас_up" ON public."Проданные_Запчасти_В_Заказе";
       public          postgres    false    233            �           3256    197142 2   Услуги_В_Заказе rls_ГлавМас_up    POLICY     |   CREATE POLICY "rls_ГлавМас_up" ON public."Услуги_В_Заказе" FOR UPDATE TO "ГлавМас" USING (true);
 N   DROP POLICY "rls_ГлавМас_up" ON public."Услуги_В_Заказе";
       public          postgres    false    241            �           3256    197148 /   Автомобили rls_Сотрудник_sel    POLICY       CREATE POLICY "rls_Сотрудник_sel" ON public."Автомобили" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Заказы"
  WHERE ("Заказы"."id_Автомобиля" = "Автомобили"."id_Автомобиля"))));
 K   DROP POLICY "rls_Сотрудник_sel" ON public."Автомобили";
       public          postgres    false    227    231    227            �           3256    197136 4   График_Работы rls_Сотрудник_sel    POLICY     +  CREATE POLICY "rls_Сотрудник_sel" ON public."График_Работы" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Сотрудники"
  WHERE ("Сотрудники"."id_Сотрудника" = "График_Работы"."id_Сотрудника"))));
 P   DROP POLICY "rls_Сотрудник_sel" ON public."График_Работы";
       public          postgres    false    239    239    225            �           3256    197144 '   Заказы rls_Сотрудник_sel    POLICY       CREATE POLICY "rls_Сотрудник_sel" ON public."Заказы" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Услуги_В_Заказе"
  WHERE ("Услуги_В_Заказе"."id_Заказ" = "Заказы"."id_Заказа"))));
 C   DROP POLICY "rls_Сотрудник_sel" ON public."Заказы";
       public          postgres    false    241    231    231            �           3256    197156 +   Запчасти rls_Сотрудник_sel    POLICY     O  CREATE POLICY "rls_Сотрудник_sel" ON public."Запчасти" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Проданные_Запчасти_В_Заказе"
  WHERE ("Проданные_Запчасти_В_Заказе"."id_Запчасти" = "Запчасти"."id_Запчасти"))));
 G   DROP POLICY "rls_Сотрудник_sel" ON public."Запчасти";
       public          postgres    false    229    233    229            �           3256    197151 N   Проданные_Запчасти_В_Заказе rls_Сотрудник_sel    POLICY     ?  CREATE POLICY "rls_Сотрудник_sel" ON public."Проданные_Запчасти_В_Заказе" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Заказы"
  WHERE ("Заказы"."id_Заказа" = "Проданные_Запчасти_В_Заказе"."id_Заказа"))));
 j   DROP POLICY "rls_Сотрудник_sel" ON public."Проданные_Запчасти_В_Заказе";
       public          postgres    false    233    231    233            �           3256    197133 /   Сотрудники rls_Сотрудник_sel    POLICY     �   CREATE POLICY "rls_Сотрудник_sel" ON public."Сотрудники" FOR SELECT TO "Сотрудник" USING ((("Номер_Телефона")::text = CURRENT_USER));
 K   DROP POLICY "rls_Сотрудник_sel" ON public."Сотрудники";
       public          postgres    false    225    225            �           3256    197139 7   Услуги_В_Заказе rls_Сотрудник_sel    POLICY     1  CREATE POLICY "rls_Сотрудник_sel" ON public."Услуги_В_Заказе" FOR SELECT TO "Сотрудник" USING ((EXISTS ( SELECT 1
   FROM public."Сотрудники"
  WHERE ("Сотрудники"."id_Сотрудника" = "Услуги_В_Заказе"."id_Сотрудника"))));
 S   DROP POLICY "rls_Сотрудник_sel" ON public."Услуги_В_Заказе";
       public          postgres    false    241    241    225            �   >  x�]�In�0E��Q�(DR�ҳ��A�vb���$;1m�y��+�0�'����ѳuR�68Q!Q.Sý�\��UM�:�Q�$�%H2d�m9����I�y4�#�*Q!S�[�7ZJk�0�F&i�Sk-�m��EE�.�`Ё}��;UK!�X�$)���v�2��5�:":p�ؗe%늁��8���3����jL-�9ۏA�_9�ʦ~�5�Uͯbч�uYcT)����� 	PހO[[P`��!�H�a/�:*3��Ns�$�@fޞ;,��RڹɃ�K)���L=W��0�(���7"��t9      �   A  x��TMn�0^ۧ�J;��,q Vl8�0��:�E��3�� i3ф�0gx��{�&I��H������XE_�j�{|�=�ԅsUVe�mj�P������$�u8��P^'�R��UQ��d:S��6,����'�?M�s�X��N�wa�,��Y�=hԀ�����Uf�m:W��.���tF��5�l�䊲��RE�`�2k�<I���	�$�d�u�J
���+���E5����8�j>D{�����7��lRW��>lt�nF�_��᜕��X�$}���磽�P3U�Gn�Z���9�����UYx�g֤�~Ҟ���u�P�P3+=,��K)`��ۂC��D��>\J�Ѩ�N���t;t��BLK��:�R��`Ռ�]�4n ��я�t>����)�Z
[fc��j��+�.�[G=D��EWSǣ'��Yzw�i��[�
���u��siX�o@�frz����������p��J��M3_i�D�c{��J�2 qZ�A7��B��s�i�~�)7�T�@X:�Q��_��8/�l���Z?�_�����h�H!��g���K#8�����N�;      �   y   x�m��� E��s/�����_Ǆ����	�Z�C��� m��
��$�%��$�>�����呰HLp�L�#a����%��O���ƛ2>��mv�?"�u�:>      �   U  x���MN�0�מS�E���p�&n�.*��!z��`5�Iz�����"YT������q����'���L��Rp��d�5{�o�5�pwD��+Y��eh��b��gn�s����J���@vh�'���K���'�,:�@ۡ�c�>>0x#�`@�Q�q�K�=�z5�Y�,,���H�	^B�>X�\j�:t4�����<�~�1xǵZ��o��c����6��@Kˤ�8�3y鸆��k.���>����G����@{UZ�K�*������iq:����6��[�d�,�o4���B��Z�]��c��vXS�+�Ԝ�I��>�Ӷn�<N�huGD?i�ޚ      �   �  x��R�N�P]O��~@�N��K(�h˫�g8D�@JE�+��v��$15�#�0�G��DBH]���gΙ3g�G��S��BN%r�s,}\�\�9?��7[���8��<�Gr._��8�5G�)
 
�aX�s)�%�_��!&�J��醍�~,�P�z?T�&�7pL�� �R�hi���*��r���	V�"���ƥ�YΫ� uBko߽_'�F����ξ	N\�{�l��R�@GH�q� 7�{��8�������j�;h.P�Z��`���cw��>F��D�u�����=�?��TD+�Z�u��d������~��R������c]��"U���g�YLGj2�O`��5K@Z`C�l��� ���5��u�E�j<�u���O|O�����BE�^ʅ��^Ѻ:]���cq�w(��k�:Ju\��j�|*�p      �   D   x�3�ɯ�/I�2����KI�2���,.N��2���,).M�,���2�.MJ,*�2�,I-.����� '	y      �   �   x��K�0���Q̣>�� ���'/K$�4eM����ܾ�a4((�MS��;Z-v�a�k������J�y����Lx��ӨvbW^K@��&�ߗ�h[4��%�~r��w��E�?/5&c      �   �   x�m���0E�����v��]�	�7v�
+��H+$j)���'+��"0�<�j����/��7���A%�L�^`LH��;Ǫ�ǭ�^�Y�CJk�I?�+,�����i:R��j���.l;��\�ڟD�������:�� ^�q�      �   �   x����	�0������%�i�p�#u�� h�v��F����K�����>�$dS���b��m+��P;�E+��m�'a_�)p�#��-v���i�l��~��N��<gV��!M9���RS�����q7�;�9���4��]I
(�"�tD�(&�}(&���p`�%��      �   (  x�u�[r����gV��R�F��ދ^p]CE����l�I�����9U���Д�l�� 3�$2V�~��;�����n?mW��n�v�>^n7�W��yu������������Z��nvۿ�wX��vu��>�<�a����v��G�dN{	wϞ��zj$d�{+ԕ{�R�hWk,D�Ť9Y	��)��_��#q��z��p"7pB�WK���g4���س��RZ����K���\U
���V�l!�a��y��F�/��g�W���,�a��_m?_���_��o�a�.5�.�KQ���b���ס<�f���$F�ԂI�">����D�����x��9�*��M�T�b�W���s	���s����>�!ꢌT9[�L�c�Ak�������ﶯW1�]�L�&o�;Hr�۵�?�� pN:=��\���;m����X���	
�<~k�獛uϣ�6���6.6J�M�{��U�d�k�"�r]b��ܓ4-�;ǎ�@�*�!�Qet��>���N�>f�XCTГ����c/�����'��O��o ���ſ_�>����|�W��0?_��8�xj"ty|�	M�����(���xf�^�l������]s�TJ�<�ڣV��F��)i����In��<D�\m)�N�\<�2
.�B+��d1Ta<��æ����D�ӖFTO*=�}�m^�,``*(�z�_�0�G�3I����g��3?<��Kw����x _^�`�${�ޝ�iu �o/p�<u��|`���ɤ� {$�K�#���`�:�8�H�`��IȘ4������$ݍ�j��A��C��`e7ͮ��}f�.�;���SI���CLR�p�����dV�i~�3�'e/(�;H�G����⫕VS��=��.�<�C��k�{�?������*���D=�J÷s�����G���@�#ER�m�}�����f��	�RE\��Fs�֜p�]O�Y���x���V�[�3�9Uǵ��&�2Mew�?�*�����=�矂���)w���a����/WǸY�OgZ����x��	VL�y�����z�� nlSÃ,f&0s2���Q�����n�rM�z�o�$�݂@*�A��p��AS�ݐ0��]V�%�u�tݧ������;�y������4(|���a>�� M5�0}�Q[��>i�u|��nv�[8)� �>QL�|Y��V�O՝S�1�\\�3ahŢje�MFI������\f��^��F�YkS<=����k��0t��эfc��g�����U�L������,�f���b�p���aa�T����۵�nz�#����n�͖v�!�O�e��A������$� $7&�QԳ8�zG(g�!�;�Ɑ�8���{����h����f�z�A4������e~i��\3���U2�/��ҧ�~�!��Y)t���0e,��]�f.=�S��U5�����$���:��D�Pt-:������]���W�I�d�Q\�j�F��!�5A=�PB� ��	���I&�30�t��$W��["�Y0�M�%�cݜ����o���/,-�P      �   �  x��TKn�@]ON���	���0	)bAU6���j/BifW�o�g'�_,� <3~~~��5�EOiG%�`�TQM�����PI��B��%�,)/|���Q!GF*1K�_�n��'��0���3􎇔�����J 9HJ\��*�\4T9^-�IrM>U�|�$yǉ���\pĉ�+w��'�8��x�kf���C��%��>ӄ��Bշ����Bl�̌�vp�
D�؂|�S�[Se�[5I�(\S5��>~��a�v�Zȋ���ꙵ��e�*�W���o�� ��m������Ca^�/�B'�x����5⳦�6p�➮k
YV'u׆8��]�Gb�T��ϊ��*+�2�?�˦n]����c|��WA��T�Ӊ-�-�Ԓ���I�u-d��D%V�=V�np@;��5=��#�s��?od)O@������펡�R�\P�P����<���2p      �   �   x��α�0��Zo
 g	�d�ФI�]\�bV�7��Ʈ|�N�>�~&&}�����_M��ĉ�,�s�9r�	&��z�����T��k�>To�|�}��(�u(`��[#M�Y,���Ko�b�75F��N��ԃ�V���Ը� � Ñ�R     