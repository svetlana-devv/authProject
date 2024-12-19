# Laravel Authentication Service

Микросервис аутентификации на Laravel с поддержкой регистрации, входа через email/password и Google OAuth2.

## Требования

- Docker
- Docker Compose

## Быстрый старт

1. Клонируйте репозиторий:
```bash
git clone git@github.com:svetlana-devv/authProject.git
cd nft
```

2. Скопируйте файл .env.example в .env и настройте переменные окружения:
```bash
cp .env.example .env
```

3. Настройте следующие переменные в .env файле:
```
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_CLIENT_SECRET=your_google_client_secret
GOOGLE_REDIRECT_URI=http://localhost/api/auth/google/callback
```

4. Запустите проект:
```bash
docker-compose up -d
```

Это действие автоматически:
- Установит все зависимости
- Выполнит миграции базы данных
- Создаст тестового пользователя
- Запустит тесты
- Запустит приложение

## API Endpoints

### Регистрация
```bash
curl -X POST http://localhost/api/register \
-H "Content-Type: application/json" \
-d '{"name":"Test User","email":"test@example.com","password":"password123","password_confirmation":"password123"}'
```

### Вход
```bash
curl -X POST http://localhost/api/login \
-H "Content-Type: application/json" \
-d '{"email":"test@example.com","password":"password123"}'
```

### Получение информации о пользователе
```bash
curl -X GET http://localhost/api/user \
-H "Authorization: Bearer YOUR_TOKEN" \
-H "Accept: application/json"
```

### Выход
```bash
curl -X POST http://localhost/api/logout \
-H "Authorization: Bearer YOUR_TOKEN" \
-H "Accept: application/json"
```

### Google OAuth
Откройте в браузере:
```
http://localhost/api/auth/google
```

## Тестирование

Для запуска всех тестов API используйте скрипт:
```bash
./test.sh
```

## Доступ к Laravel Tinker

Для входа в интерактивную консоль:
```bash
docker-compose exec app php artisan tinker
```

## База данных

PostgreSQL доступен по следующим параметрам:
- Host: localhost
- Port: 5432
- Database: laravel
- Username: laravel
- Password: password

PGAdmin доступен по адресу:
```
http://localhost:5050
```
- Email: admin@admin.com
- Password: root

## Тестовый пользователь

После запуска в системе будет создан тестовый пользователь:
- Email: test@example.com
- Password: password123
