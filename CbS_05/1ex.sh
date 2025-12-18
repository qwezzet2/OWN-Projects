#!/bin/bash

# Удаление старых файлов, если они есть
rm -f info OS_RESULT.tar

# Сбор списка установленных пакетов
echo "Установленные пакеты" >> info
dpkg --get-selections | grep -v "deinstall" | awk '{print $1}' >> info

# Сбор информации о запущенных процессах
echo -e "\nЗапущенные процессы" >> info
ps aux >> info

# Сбор информации об открытых портах
echo -e "\nОткрытые порты" >> info
ss -tulnp >> info

# Сбор информации о версии ядра и операционной системы
echo -e "\nВерсия ядра и ОС" >> info
uname -a >> info
cat /etc/os-release >> info

# Архивирование файла info
tar cf OS_RESULT.tar info

# Вывод завершающего сообщения
echo "Информация собрана и сохранена в архиве 'OS_RESULT.tar'"
