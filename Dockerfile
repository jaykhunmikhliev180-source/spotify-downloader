FROM python:3.13-slim-bullseye

RUN apt-get update && apt-get install -y ffmpeg aria2 git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir spotdl

# Eng muhim o'zgarish shu yerda:
# Biz botni shunchaki ishga tushirmaymiz, balki nima xato berayotganini 
# yozib, keyin uxlab qolishini buyuramiz.
CMD ["sh", "-c", "spotdl web --port 10000 --host 0.0.0.0 || { echo 'XATO YUZ BERDI, LOGLARNI OQING'; sleep 600; }"]

