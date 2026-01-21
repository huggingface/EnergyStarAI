#!/bin/bash
set -e

# Display container version
if [ -f /VERSION ]; then
    echo "============================================"
    echo "AIEnergyScore Container Version: $(cat /VERSION)"
    echo "============================================"
fi

RESULTS_DIR="/results"
BENCHMARK_BACKEND="${BENCHMARK_BACKEND:-pytorch}"  # Default to pytorch (ai_energy_benchmarks)

python /launch_backend.py
# python /check_h100.py
if [[ $? = 0 ]]; then
    mkdir -p "${RESULTS_DIR}"

    if [[ "${BENCHMARK_BACKEND}" == "optimum" ]]; then
        echo "Using optimum-benchmark (HuggingFace)"
        # Force Hydra (used by optimum-benchmark) to write outputs into /results
        optimum-benchmark --config-dir /optimum-benchmark/energy_star/ "$@" hydra.run.dir="${RESULTS_DIR}"

    elif [[ "${BENCHMARK_BACKEND}" == "pytorch" ]]; then
        echo "Using ai_energy_benchmarks (PyTorch backend)"
        python /run_ai_energy_benchmark.py "$@"

    elif [[ "${BENCHMARK_BACKEND}" == "vllm" ]]; then
        echo "Using ai_energy_benchmarks (vLLM backend)"
        if [[ -z "${VLLM_ENDPOINT}" ]]; then
            echo "Error: VLLM_ENDPOINT environment variable must be set for vLLM backend"
            exit 1
        fi
        python /run_ai_energy_benchmark.py "$@"

    else
        echo "Error: Unknown BENCHMARK_BACKEND=${BENCHMARK_BACKEND}"
        echo "Valid options: optimum, pytorch, vllm"
        exit 1
    fi

    # Post-run summarizer: reads benchmark_report.json and prints/writes GPU_ENERGY_WH
    python /summarize_gpu_wh.py "${RESULTS_DIR}"
fi
