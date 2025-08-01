from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)
model = joblib.load('demand_model.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    features = np.array([[data['center_id'], data['meal_id'], data['week'], data['checkout_price']]])
    prediction = model.predict(features)
    return jsonify({'predicted_demand': int(prediction[0])})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000) 