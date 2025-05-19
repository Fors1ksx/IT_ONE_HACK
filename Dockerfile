FROM python:3.9-slim

WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Создание пользователя для запуска приложения
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Копирование и установка Python зависимостей
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копирование кода приложения
COPY --chown=appuser:appuser . .

EXPOSE 5001

CMD ["python", "app.py"] 