# EnergyStarAI

A repository for the AI Energy Star Project, aiming to establish energy efficiency ratings for AI models.

> [!NOTE]
> This is still a work in progress.


## Hardware

The Dockerfile provided in this repository is made to be used on NVIDIA H100 GPUs.
If you would like to run benchmarks on other types of hardware, we invite you to take a look at [these configuration examples](https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev/examples/energy_star) that can be run directly with [Optimum Benchmark](https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev).


## Usage

You can build the Docker image with:

```
docker build -t energy_star .
```

Then you can run your benchmark with:

```
docker run --gpus all --shm-size 1g energy_star --config-name my_task backend.model=my_model backend.processor=my_processor 
```
where `my_task` is the name of a task with a configuration here: https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev/examples/energy_star, `my_model` is the name of your model that you want to test (which needs to be compatible with either the Transformers or the Diffusers libraries) and `my_processor` is the name of the tokenizer/processor you want to use. In most cases, `backend.model` and `backend.processor` wil lbe identical, except in cases where a model is using another model's tokenizer (e.g. from a LLaMa model).

The rest of the configuration is explained here: https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev?tab=readme-ov-file#configuration-overrides-%EF%B8%8F
