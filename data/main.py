from llama_cpp import Llama
import argparse

parser = argparse.ArgumentParser(description='Process images with Llama model')
parser.add_argument(
    '--model', 
    type=str, 
    default="Meta-Llama-3.1-8B-Instruct-Q8_0.gguf",
    help='Path to the model file'
)

args = parser.parse_args()

# Initialize the model with parameters matching your llama-server configuration
llm = Llama(
    model_path=args.model,  # Using your model file
    n_ctx=8192,           # Matching your ctx-size
    n_gpu_layers=100,     # Matching your n-gpu-layers
)

print("TEST THE MODEL")

messages = [
    {"role": "system", "content": """You are a helpful AI assistant."""},
    {"role": "user", "content": "Please tell me a story!"},
]

output = llm.create_chat_completion(
                messages = messages,
                max_tokens=128,      # Equivalent to n_predict
                temperature=0.2,
            )

print(output)
print("TEST THE MODEL END")