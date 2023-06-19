from gradio_client import Client
import random
from flask import Flask, jsonify, request
import asyncio
import os
import signal


app = Flask(__name__)
app.debug = True

@app.route('/', methods=['POST'])
def index():
    seed = random.uniform(-1, 9999999999)

    client = Client("https://huggingface-projects-qr-code-ai-art-generator--77b4rgzlh.hf.space/")


    result = client.predict(
        request.headers.get('content'),
        request.headers.get('prompt'),
        "ugly, disfigured, low quality, blurry, nsfw",
        float(request.headers.get('guidance-scale')),
        float(request.headers.get('controlnet-condition-scale')),
        float(request.headers.get('strength')),
        seed,
        "",
        "",
        True,
        "DPM++ Karras SDE",
        fn_index=0
    )

    path = result
    # Specify the download folder path
    download_folder = os.path.join(os.path.expanduser("~"), "Downloads", "Artiqr")
    os.makedirs(download_folder, exist_ok=True)

    # Move the file to the download folder
    file_name = os.path.basename(path)
    new_path = os.path.join(download_folder, file_name)
    os.rename(path, new_path)
    
    return jsonify(os.path.basename(new_path))



async def shutdown_server():
    pid = os.getpid()
    os.kill(pid, signal.SIGINT)
    await asyncio.sleep(0)  # Allow other async tasks to run

@app.route('/shutdown', methods=['GET'])
async def shutdown():
    await shutdown_server()
    return 'Server shutting down...'

@app.route('/status', methods=['GET'])
def test():
    return 'online'

if __name__ == "__main__":
    app.run(debug=True)