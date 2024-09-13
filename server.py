                                                                                                                                     
from flask import Flask, request
import logging

app = Flask(__name__)

# Set up logging
logging.basicConfig(level=logging.DEBUG)

@app.route('/uploadenv', methods=['POST'])
def upload_env():
    try:
        logging.debug(f"Request headers: {request.headers}")
        # Log the size of the incoming data
        data = request.data.decode('utf-8')
        logging.debug(f"Decoded  data size: {len(data)} bytes")
        # Log the actual data (optional, be careful with sensitive information)
        logging.debug(f"Received data: {data}")
        # Write to the file
        with open('env_data.txt', 'w') as f:
            f.write(data)
        return 'Environment data received', 200
    except Exception as e:
        logging.error(f"Error writing to file: {e}")
        return 'Internal Server Error', 500

@app.route('/uploadzip', methods=['POST'])
def upload_zip():
    filename = request.args.get('filename')
    with open(filename, 'wb') as f:
        f.write(request.data)
    return 'File received', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
