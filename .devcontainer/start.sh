#!/bin/bash
set -e

echo "🚀 Starting AI Transcript App services in Docker..."

WORKSPACE_DIR="/workspaces/ai-transcript-app"
cd "$WORKSPACE_DIR"

# Wait for Ollama service to be ready
echo "⏳ Waiting for Ollama service..."
for i in {1..30}; do
    if curl -s http://ollama:11434/api/tags > /dev/null 2>&1; then
        echo "✅ Ollama service is ready!"
        break
    fi
    sleep 1
done

# Check and pull model if not present
if curl -s http://ollama:11434/api/tags > /dev/null 2>&1; then
    if ! curl -s http://ollama:11434/api/tags | grep -q "gemma3:4b"; then
        echo "🤖 Downloading Ollama model (gemma3:4b) on initial setup..."
        echo "   This is a one-time download (~3.3 GB). Please wait..."
        curl -X POST http://ollama:11434/api/pull -d '{"name":"gemma3:4b"}'
        echo "✅ Model gemma3:4b downloaded successfully!"
    else
        echo "✅ Ollama model gemma3:4b is ready"
    fi
fi

# Ensure .env exists
if [ ! -f backend/.env ]; then
    cp backend/.env.example backend/.env
fi

# Sync backend dependencies
echo "🐍 Ensuring Python dependencies are installed..."
cd "$WORKSPACE_DIR/backend"
uv sync

# Ensure frontend packages installed for linux container
echo "📦 Ensuring Frontend dependencies are installed..."
cd "$WORKSPACE_DIR/frontend"
if [ ! -d "node_modules" ] || [ ! -d "node_modules/@rollup/rollup-linux-arm64-gnu" ]; then
    npm install
fi

echo "🌟 Launching Backend (FastAPI on :8000) and Frontend (Vite on :3000)..."

cleanup() {
    echo "🛑 Shutting down services..."
    kill $BACKEND_PID $FRONTEND_PID 2>/dev/null || true
    wait $BACKEND_PID $FRONTEND_PID 2>/dev/null || true
    exit 0
}
trap cleanup SIGINT SIGTERM

# Start Backend
cd "$WORKSPACE_DIR/backend"
uv run uvicorn app:app --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!

# Start Frontend
cd "$WORKSPACE_DIR/frontend"
npm run dev -- --host 0.0.0.0 --port 3000 &
FRONTEND_PID=$!

echo ""
echo "================================================="
echo "  🚀 AI Transcript App is running!"
echo "  🌐 Frontend:  http://localhost:3000"
echo "  📡 Backend:   http://localhost:8000"
echo "  🤖 Ollama:    http://localhost:11434"
echo "================================================="
echo ""

wait -n $BACKEND_PID $FRONTEND_PID
