Для работы требуется отредактировать информацию с 206 по 211 строку. Программа расчитана на работу с postgresql. Её функционал в автоматической подгрузке таблиц, а также получение функций и процедур, в последствие они будут активироваться через интерфейс по кнопке, сама функция/представление выполняется на самом сервере, а это значит, что для ограничения отображения таблиц и функций требуется прописать сами ограничения со стороны БД.
Также для работы требуется установить:
  PyQt
  traceback
  psycopg2