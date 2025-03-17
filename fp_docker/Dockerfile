FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .


FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=builder /app /app
ENV AWS_ACCESS_KEY_ID="AKIAXLEKZJVVSTPGSZ6O"
ENV AWS_SECRET_ACCESS_KEY="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"
EXPOSE 5001
CMD ["python", "app.py"]