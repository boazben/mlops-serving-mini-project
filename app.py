from fastapi import FastAPI
import pickle
import pandas as pd

app = FastAPI()

# טעינת המודל לזיכרון בזמן עליית השרת
with open('model.pkl', 'rb') as f:
    model = pickle.load(f)

@app.get("/")
def read_root():
    return {"status": "Model API is up and running!"}

@app.post("/predict")
def predict(feature1: float, feature2: float):
    # יצירת טבלה (DataFrame) מהנתונים שהגיעו בבקשת הרשת
    df = pd.DataFrame([{'feature1': feature1, 'feature2': feature2}])
    
    # הפעלת המודל לקבלת תחזית
    prediction = model.predict(df)
    
    return {"prediction": int(prediction[0])}