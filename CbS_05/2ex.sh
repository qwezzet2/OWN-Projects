#!/bin/bash


echo "1. Создание группы default_users и пользователя user"
groupadd default_users
useradd -m -g default_users -s /bin/bash user

echo
echo "2. Создание группы secret_users и пользователей"
groupadd secret_users

for username in secret_agent secret_spy secret_boss; do
  useradd -m -g secret_users -s /bin/bash $username
  echo "Пользователь '$username' создан и добавлен в группу 'secret_users'."
done

echo
echo "3. Настройка прав на домашние директории для группы secret_users"
for username in secret_agent secret_spy secret_boss; do
  chmod 770 /home/$username
  chown $username:secret_users /home/$username
  echo "Домашняя директория '/home/$username' теперь доступна только владельцу и группе secret_users."
done

echo
echo "4. Открытие доступа ко всей директории /var для всех пользователей и групп"
chmod -R 777 /var

echo
echo "5. Установка пакета apache2 и проверка его состояния"
apt update > /dev/null 2>&1
apt install -y apache2 > /dev/null 2>&1
systemctl enable apache2 > /dev/null 2>&1
systemctl start apache2 > /dev/null 2>&1

if systemctl is-active --quiet apache2; then
  echo "Сервис apache2 установлен и запущен."
fi

echo
echo "6. Настройка sudo для группы default_users без пароля"
echo "%default_users ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/default_users > /dev/null
chmod 440 /etc/sudoers.d/default_users
echo "Пользователи группы 'default_users' могут использовать sudo без пароля."
