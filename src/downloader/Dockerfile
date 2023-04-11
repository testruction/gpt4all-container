FROM docker.io/amd64/alpine:3

ARG IMAGE_VERSION \
    ORGANISATION='testruction'

LABEL org.opencontainers.image.title "gpt4all-downloader"
LABEL org.opencontainers.image.description "An ecosystem of open-source chatbots trained on a massive collections of clean assistant data including code, stories and dialogue"
LABEL org.opencontainers.image.version "${IMAGE_VERSION}"
LABEL org.opencontainers.image.authors "Florian JUDITH <florian.judith.b@gmail.com>"
LABEL org.opencontainers.image.source "https://github.com/${ORGANISATION}/gpt4all-container"

COPY ./download.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/download.sh

CMD ["/usr/local/bin/download.sh"]
