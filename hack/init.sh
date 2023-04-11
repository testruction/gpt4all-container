#!/usr/bin/env bash
set -euo pipefail

source hack/libraries/custom-logger.sh -v

function init_env()
{
    if [ ! -f .env ]
    then
        ewarn 'Environment ".env" file not found'
        ewarn 'Creating using default settings from ".env.example"'
        cp .env.example .env
    fi

    grep -qxF "APP_VERSION=$(cat ./VERSION)" .env \
    || echo "APP_VERSION=$(cat ./VERSION)" | tee -a .env

    set -o allexport
    source .env
    set +o allexport
    eok "Environment variables initialized from \"${PWD}/.env\""
}

function init_venv()
{
    if [ ! -d ${HOME}/micromamba/envs/${PROJECT_NAME} ]
    then
        micromamba create --name ${PROJECT_NAME} --channel conda-forge python=3.11 --yes
    fi

    if ! micromamba env list | grep -E "$PROJECT_NAME\s*\*"
    then
        eerror "Run first \"micromamba activate ${PROJECT_NAME}\""
        eerror "Then re-run \"${BASH_SOURCE[0]}\""
        exit 1
    fi


    python3 -m pip install --upgrade pip --quiet
    pip3 install --upgrade -r requirements.txt --quiet
    
    eok 'Python virtual environment initialized'
}

function start_infrastructure()
{
    ENV_FILE=${PWD}/.env
    docker compose --env-file=${ENV_FILE} up \
        --detach \
        --build \
        --remove-orphans
    eok "Local environment started"
}

init_env
# init_venv
start_infrastructure