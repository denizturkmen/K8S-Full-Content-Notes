from flask import request, Flask
import json
import os

app = Flask(__name__)

# Define the variable before the route function
my_variable = os.environ.get("MY_VARIABLE", "default_value")
print("The value of MY_VARIABLE is:", my_variable)

@app.route('/')
def Load_Balancer():
    return my_variable

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
