FROM python:3.12-slim as builder

WORKDIR /app

COPY ./requirements /app/requirements
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements/dev.txt

FROM python:3.12-slim

RUN groupadd -r django && useradd -d /app -r -g django django

WORKDIR /app

COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements /requirements
RUN pip install --no-cache /wheels/*

COPY . /app

RUN chown -R django:django /app

USER django

CMD ["/app/start.sh"]

