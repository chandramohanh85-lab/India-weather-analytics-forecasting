
import pandas as pd
import requests

cities = {
    "Ahmedabad": [23.02, 72.57],
    "Bengaluru": [12.97, 77.59],
    "Chennai": [13.08, 80.27],
    "Hyderabad": [17.39, 78.49],
    "Jaipur": [26.91, 75.79],
    "Kolkata": [22.57, 88.36],
    "Lucknow": [26.85, 80.95],
    "Mumbai": [19.08, 72.85]
}

data = []

for city, loc in cities.items():
    url = "https://api.open-meteo.com/v1/forecast"
    params = {
        "latitude": loc[0],
        "longitude": loc[1],
        "daily": "temperature_2m_max,temperature_2m_min,precipitation_sum",
        "forecast_days": 7,
        "timezone": "Asia/Kolkata"
    }

    res = requests.get(url, params=params)
    js = res.json()

    for i in range(7):
        data.append({
            "city": city,
            "date": js["daily"]["time"][i],
            "max_temp": js["daily"]["temperature_2m_max"][i],
            "min_temp": js["daily"]["temperature_2m_min"][i],
            "rain": js["daily"]["precipitation_sum"][i]
        })

df = pd.DataFrame(data)
df.to_csv("india_forecast.csv", index=False)

print("Forecast rows:", len(df))
print("Cities:", df["city"].nunique())
print("Done!")

