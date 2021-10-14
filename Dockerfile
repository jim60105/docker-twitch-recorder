FROM python:alpine

# RUN apk --update add --no-cache bash curl ffmpeg dumb-init gcc libc-dev
RUN apk add --no-cache --virtual build-deps \
      gcc \
      libc-dev && \
    apk add --no-cache \
      ffmpeg \
      dumb-init && \
    pip install --no-cache-dir \
      streamlink \
      requests && \
    apk del build-deps

WORKDIR /app
COPY twitch-stream-recorder/twitch-recorder.py .
COPY config.py .

ENV username=
ENV client_id=
ENV client_secret=

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "python3", "-u", "/app/twitch-recorder.py" ]