FROM python:3.12

WORKDIR /app

COPY requirements/base.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

RUN chmod +x ./start.sh
CMD ["./start.sh"]
