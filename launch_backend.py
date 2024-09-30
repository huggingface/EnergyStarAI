from huggingface_hub import HfApi
import os

TOKEN = os.environ.get("DEBUG")


API = HfApi(token=TOKEN)
def start_space():
    API.pause_space("meg/launching-test-3")
    API.restart_space("meg/launching-test-3")


if __name__ == "__main__":
  start_space()
