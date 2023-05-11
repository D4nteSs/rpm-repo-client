#!/bin/bash

# Запуск первого контейнера
sleep 60 

# Проверка на установку пакета с локального репо
while true; do
  if dnf install -y dnf-automatic; then
    echo "dnf установлен"
    break
  else
    sleep 20
  fi
done

# Устанавливаем утилиту для автоматического обновления пактов репо
dnf install -y dnf-automatic

# Меняем параметры утилиты
sed -i 's/apply_updates = no/apply_updates = yes/' /etc/dnf/automatic.conf

# Задаем бесконечный цикл, который будет автоматически обновлять пакеты доступных репо (то есть первого контейнера) 
while :
do 
	dnf-automatic
	sleep 1000
done

