import http.client
import json


def x(y):
    z = y + 1
    return z


def fetch(s):
    pass


# gd go to definition not working
def fetch_weather_data(latitude, longitude):
    conn = http.client.HTTPSConnection("api.open-meteo.com")
    endpoint = (
        f"/v1/forecast?latitude={latitude}&longitude={longitude}&current_weather=true"
    )
    conn.request("GET", endpoint)
    response = conn.getresponse()
    data = response.read().decode("utf-8")
    return json.loads(data)
