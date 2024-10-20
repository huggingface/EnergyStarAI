import subprocess
import re
from pathlib import Path


# This is the path to Optimum Benchmark's config dir
PATH_TO_CONFIG_DIR = Path(__file__).resolve().parents[2] / "optimum-benchmark" / "examples" / "energy_star"


# List of all configurations to benchmark
# One item is a tuple (model name, task)
MODELS_TO_BENCHMARK = [
    ("openai-community/gpt2", "text_generation"),
    ("google/vit-base-patch16-224", "image_classification"),
    ("openai/whisper-small", "automatic_speech_recognition"),
]

if __name__ == "__main__":
    for config in MODELS_TO_BENCHMARK:
        model, task = config
        print()
        print(f"Benchmarking model {model} for task {task}")

        # Build the command
        command_to_run = [
            "optimum-benchmark",
            f"--config-dir {PATH_TO_CONFIG_DIR}",
            f"--config-name {task}",
            f"backend.model={model}",
        ]
        pattern = re.compile(r"([\"\'].+?[\"\'])|\s")
        command_to_run = [x for y in command_to_run for x in re.split(pattern, y) if x]

        # Run the command
        subprocess.run(
            command_to_run,
            # stdout=subprocess.PIPE,
            # stderr=subprocess.PIPE,
            # check=True,
            text=True,
        )
