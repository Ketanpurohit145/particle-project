from flask import Flask, jsonify
from datetime import datetime
import socket
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

@app.route("/", methods=["GET"])
def get_time_info():
    """
    Handle the root URL path and return the JSON response.
    """
    current_time = datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC")
    hostname = socket.gethostname()

    response = {
        "current_time": current_time,
        "hostname": hostname,
    }

    return jsonify(response)

if __name__ == "__main__":
      # Read the port from the .env file or use 5000 as a default
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
