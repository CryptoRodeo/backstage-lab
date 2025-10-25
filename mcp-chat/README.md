# MCP-Chat

Run an LLM locally.

```bash
docker compose up -d
```

Pull a model:
```bash
# Small model, no tooling enabled
docker exec -it ollama ollama pull tinyllama
# Tooling enabled, good for MCP-Chat plugin
docker exec -it ollama ollama pull llama3.2:1b
```

You also have an LLM Dashboard on <host>:3000 (e.g. localhost:3000)


