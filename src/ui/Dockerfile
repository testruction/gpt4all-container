FROM docker.io/amd64/python:3.10

ARG IMAGE_VERSION \
    ORGANISATION='testruction'

LABEL org.opencontainers.image.title "gpt4all-ui" \
      org.opencontainers.image.description "An ecosystem of open-source chatbots trained on a massive collections of clean assistant data including code, stories and dialogue" \
      org.opencontainers.image.version "${IMAGE_VERSION}" \
      org.opencontainers.image.authors "Florian JUDITH <florian.judith.b@gmail.com>" \
      org.opencontainers.image.source "https://github.com/${ORGANISATION}/gpt4all-container"

# Create gpt4all user
RUN groupadd --system --gid 1234 gpt4all \
	&& useradd --system --create-home --shell /bin/bash --gid 1234 --uid 1234 gpt4all

# USER root

# RUN apt-get update -y \
#     && apt-get install -y --no-install-recommends \
#         'build-essential' \
#         'pkg-config' \
#         'coreutils' \
#         'cmake' \
#         'wget' \
#         'git' \
#     && apt-get autoremove -y --purge \
#     && apt-get clean \
#     && rm -r /var/lib/apt/lists/* \
#     && python3 -m pip install --upgrade pip

# Download and install from upstream sources
ENV DS_BUILD_OPS=0 \
    DS_BUILD_AIO=0

WORKDIR /usr/share/
RUN git clone \
      -b "main" \
      --single-branch https://github.com/nomic-ai/gpt4all-ui \
    && pip3 install --no-cache \
      -r gpt4all-ui/requirements.txt \
      'hypercorn==0.14.3' \
      'opentelemetry-instrumentation-flask==0.38b0' \
    && mkdir -vp \
      gpt4all-ui/data \
      gpt4all-ui/models \
    && chown -R gpt4all:gpt4all ./gpt4all-ui

WORKDIR /usr/share/gpt4all-ui/
COPY --chown=gpt4all:gpt4all ./src/*sgi.py ./

EXPOSE  9600

CMD ["/usr/local/bin/hypercorn", "--bind", "0.0.0.0:9600", "asgi:asyncio_app"]
