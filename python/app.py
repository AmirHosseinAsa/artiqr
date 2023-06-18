import argparse
from gradio_client import Client
import random

seed = random.uniform(-1, 9999999999)
# Parse command-line arguments
parser = argparse.ArgumentParser(description="QR Code AI Art Generator Client")
parser.add_argument("-qr_code_content","--qr_code_content", type=str, help="QR Code Content")
parser.add_argument("-prompt","--prompt", type=str, help="Prompt")
parser.add_argument("-guidance_scale","--guidance_scale", type=float, help="Guidance Scale (between 0.0 and 50.0)")
parser.add_argument("-controlnet_condition_scale","--controlnet_condition_scale", type=float, help="Controlnet Conditioning Scale (between 0.0 and 5.0)")
parser.add_argument("-strength","--strength", type=float, help="Strength (between 0.0 and 1.0)")
args = parser.parse_args()

client = Client("https://huggingface-projects-qr-code-ai-art-generator--77b4rgzlh.hf.space/")

result = client.predict(
    args.qr_code_content,
    args.prompt,
    "ugly, disfigured, low quality, blurry, nsfw",
    args.guidance_scale,
    args.controlnet_condition_scale,
    args.strength,
    seed,
    "",
    "",
    True,
    "DPM++ Karras SDE",
    fn_index=0
)
print(result)
