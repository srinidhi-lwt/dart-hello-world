# Stage 1: Build the Dart app
FROM dart:stable AS build
WORKDIR /app
COPY . .
RUN dart pub get

# Create bin directory
RUN mkdir -p bin

# Compile Dart app
RUN dart compile exe hello.dart -o bin/server

# Stage 2: Create a minimal runtime image
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/
EXPOSE 8080
CMD ["/app/bin/server"]
