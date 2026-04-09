# שימוש בתמונת בסיס רשמית וקלה של פייתון
FROM python:3.12-slim

# מניעת כתיבת קבצי קומפילציה מיותרים
ENV PYTHONDONTWRITEBYTECODE=1
# מניעת אגירת לוגים בזיכרון, להדפסה מיידית
ENV PYTHONUNBUFFERED=1

# הגדרת תיקיית העבודה בתוך הקונטיינר
WORKDIR /app

# העתקת קובץ הדרישות והתקנת הספריות
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# העתקת קוד השרת וקובץ המודל שלנו
COPY app.py .
COPY model.pkl .

# חשיפת הפורט שעליו השרת ירוץ
EXPOSE 8000

# הפקודה שתרוץ כשנדליק את הקונטיינר
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]