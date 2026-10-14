FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ARG APP_VERSION=local
ENV APP_VERSION=${APP_VERSION}

WORKDIR /app

COPY src/requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .

RUN useradd --create-home --uid 10001 appuser
USER 10001

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "app:app"]
