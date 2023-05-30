
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa

ARG flutter_version="2.2.3-stable"

ENV FLUTTER_HOME="/flutter"
ENV PATH="$FLUTTER_HOME/bin:$FLUTTER_HOME/bin/cache/dart-sdk/bin:$PATH"

RUN git clone https://github.com/flutter/flutter.git --branch $flutter_version --depth 1 $FLUTTER_HOME

RUN flutter config --no-analytics && flutter config --enable-web

RUN flutter precache

WORKDIR /app

COPY pubspec.yaml .

RUN flutter pub get

COPY . .

RUN flutter build web

CMD ["flutter", "run --web-renderer html", "-d", "web-server", "--web-hostname", "0.0.0.0", "--web-port", "8080"]