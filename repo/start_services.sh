#!/bin/bash
# Установка супервизора отдельно от сборки связана с ошибками установки supervisor при сборке (supervisor не найден)
echo "Install supervisor"
yum install supervisor -y

echo "Запуск конфигурации supervisor..."
/usr/bin/supervisord -c /etc/supervisord.d/nginxssh.conf

