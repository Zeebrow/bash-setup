FROM python

ENV LOL_PORT=8000
ENV LOL_HOST=0.0.0.0

EXPOSE 8000

WORKDIR /app
COPY lolserver.py .

ENTRYPOINT ["python3", "-m", "lolserver.py"]
