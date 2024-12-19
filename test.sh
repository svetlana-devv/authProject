#!/bin/bash

echo "1. Регистрация нового пользователя"
RESPONSE=$(curl -s -X POST http://localhost/api/register \
-H "Content-Type: application/json" \
-d '{"name":"Test User","email":"test@example.com","password":"password123","password_confirmation":"password123"}')
echo $RESPONSE
TOKEN=$(echo $RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

echo -e "\n2. Вход в систему"
curl -X POST http://localhost/api/login \
-H "Content-Type: application/json" \
-d '{"email":"test@example.com","password":"password123"}'

echo -e "\n3. Получение информации о пользователе"
curl -X GET http://localhost/api/user \
-H "Authorization: Bearer $TOKEN" \
-H "Accept: application/json"

echo -e "\n4. Попытка входа с неверным паролем (должна вернуть ошибку)"
curl -X POST http://localhost/api/login \
-H "Content-Type: application/json" \
-d '{"email":"test@example.com","password":"wrong_password"}'

echo -e "\n5. Проверка защищенного маршрута без токена (должна вернуть ошибку)"
curl -X GET http://localhost/api/user \
-H "Accept: application/json"

echo -e "\n6. Выход из системы"
curl -X POST http://localhost/api/logout \
-H "Authorization: Bearer $TOKEN" \
-H "Accept: application/json"
