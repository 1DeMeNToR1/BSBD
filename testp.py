from docx import Document
import psycopg2

# Замените значения подключения на свои
conn = psycopg2.connect(
    database="autoservice",
    user="postgres",
    password="172839",
    host="192.168.0.9"
)

# Замените SQL-запрос на ваш запрос для получения данных о заказе
order_id = 2  # Замените на реальный идентификатор заказа
sql_query = f"SELECT * FROM Выгрузить_заказ({order_id});"

with conn.cursor() as cursor:
    cursor.execute(sql_query)
    order_data = cursor.fetchone()

# Создаем новый документ
new_document = Document()
print(order_data)
# Генерируем текст договора на основе данных заказа
contract_text = (
    f"Договор по заказу #{order_data[0]}\n\n"
    f"Дата: {order_data[1]}\n"
    f"Статус заказа: {order_data[2]}\n"
    f"Клиент: {order_data[3]} {order_data[4]}\n"
    f"Автомобиль: {order_data[5]} {order_data[6]}\n\n"
    f"Детали заказа:\n"
    f"Проданная запчасть: {order_data[7]}\n"
    f"Количество запчастей: {order_data[8]}\n"
    f"Сумма платежа: {order_data[9]}\n"
    f"Дата платежа: {order_data[10]}"
)

# Вставляем текст договора в новый документ
new_document.add_paragraph(contract_text)

# Сохраняем результаты в новый файл
new_document.save("договор_по_заказу_результат.docx")

conn.close()
