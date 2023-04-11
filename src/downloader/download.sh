#!/usr/bin/env sh

MODELS_PATH="/usr/share/gpt4all/models"
MODELS_URL="https://the-eye.eu/public/AI/models/nomic-ai/gpt4all"
LORA_QUANTIZED_GGML_MODEL="gpt4all-lora-quantized-ggml.bin"

mkdir -vp ${MODELS_PATH}

if ! echo "$(cat ${MODELS_PATH}/${LORA_QUANTIZED_GGML_MODEL}.md5)  ${MODELS_PATH}/${LORA_QUANTIZED_GGML_MODEL}" | md5sum -c
then
    wget -P ${MODELS_PATH}/ ${MODELS_URL}/${LORA_QUANTIZED_GGML_MODEL}.md5 \
    && wget -P ${MODELS_PATH}/ ${MODELS_URL}/${LORA_QUANTIZED_GGML_MODEL}
fi
