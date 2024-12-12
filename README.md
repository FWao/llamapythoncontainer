# Build & Run llama-cpp-python in a Docker container

Clone this repository!

Modify the volumes in docker-compose.yml to match your local directory. Change the file names / paths accordingly!

Run: `docker compose up`

Optional, build the image: `docker compose build .`


### Download a model from huggingface

`huggingface-cli download bartowski/Llama-3.2-3B-Instruct-GGUF Llama-3.2-3B-Instruct-Q8_0.gguf --local-dir-use-symlinks False --local-dir /where/to/put/the/model/file/`