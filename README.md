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
docker run --gpus all --shm-size 1g energy_star --config-name my_task
```
where `my_task` is the name of a task with a configuration here: https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev/examples/energy_star

You can override the value of a field in a configuration as explained here: https://github.com/huggingface/optimum-benchmark/tree/energy_star_dev?tab=readme-ov-file#configuration-overrides-%EF%B8%8F
