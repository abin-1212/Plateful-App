import pandas as pd
from sklearn.ensemble import RandomForestRegressor
import joblib

# Load data (ensure train.csv is in the same directory)
df = pd.read_csv('train.csv')

# Simple preprocessing (customize as needed)
X = df[['center_id', 'meal_id', 'week', 'checkout_price']]
y = df['num_orders']

# Train model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X, y)

# Save model
joblib.dump(model, 'demand_model.pkl')
print("Model saved as demand_model.pkl") 