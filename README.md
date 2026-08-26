# AI Transcript App

> Developed by **Hugo Sanabria**

AI-powered voice transcription using **faster-whisper** and automatic text cleaning with local or cloud Large Language Models (**LLMs**). Features a sleek modern web interface (React + Vite) backed by a high-performance **FastAPI** service and **Ollama**.

---

## ✨ Features

- 🎤 **Browser-Based Voice Recording:** Record speech directly with interactive controls and keyboard shortcuts (hold `V` to record).
- 📁 **Audio File Upload & Drag-and-Drop:** Transcribe pre-recorded audio files easily.
- 🔊 **Local Speech-to-Text:** Whisper-based offline transcription with fast processing.
- 🤖 **Intelligent LLM Cleaning:** Automatically removes filler words, fixes grammar/punctuation, and polishes the transcript while preserving context and technical terms.
- 🔌 **OpenAI API Compatibility:** Works out-of-the-box with Ollama (default), LM Studio, OpenAI, or any OpenAI-compatible endpoint.
- ⚙️ **Customizable System Prompts:** Edit prompt instructions directly in the interface.
- 📋 **One-Click Copy:** Fast clipboard export with interactive feedback.
- 🐳 **Full Docker Support:** One-command startup for all services (Ollama + Backend + Frontend).

---

## 🏗️ Architecture

```
                               ┌───────────────────────────┐
                               │       Web Frontend        │
                               │      (React + Vite)       │
                               │   http://localhost:3000   │
                               └─────────────┬─────────────┘
                                             │
                                             ▼
                               ┌───────────────────────────┐
                               │      FastAPI Backend      │
                               │   http://localhost:8000   │
                               └───────┬───────────┬───────┘
                                       │           │
                     ┌─────────────────┴─┐       ┌─┴─────────────────┐
                     ▼                   │       │                   ▼
           ┌───────────────────┐         │       │         ┌───────────────────┐
           │   faster-whisper  │         │       │         │   Ollama Service  │
           │ (Local Audio-Text)│         │       │         │ (Local Gemma/LLM) │
           └───────────────────┘         │       │         └───────────────────┘
                                         ▼       ▼
                               ┌───────────────────────────┐
                               │  OpenAI-Compatible APIs   │
                               │   (Optional Cloud LLMs)   │
                               └───────────────────────────┘
```

---

## 🚀 Quick Start (Docker)

The fastest and cleanest way to run the entire project is via Docker Compose:

```bash
docker compose up -d
```

Docker Compose will automatically:
1. Start the **Ollama** service and download the LLM model (`gemma3:4b`).
2. Build and launch the **FastAPI** backend on port `8000`.
3. Launch the **React/Vite** frontend on port `3000`.

### Access the Application

- **Frontend:** [http://localhost:3000](http://localhost:3000)
- **Backend API Docs:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **Ollama API:** [http://localhost:11434](http://localhost:11434)

To view logs:
```bash
docker compose logs -f app
```

To stop all services:
```bash
docker compose down
```

---

## 🛠️ Local Development (Without Docker)

If you prefer running services directly on your host machine:

### Prerequisites

- Python 3.12+ and [uv](https://docs.astral.sh/uv/)
- Node.js 24+ and npm
- [Ollama](https://ollama.com/) (or another OpenAI-compatible LLM provider)

### 1. Setup Backend

```bash
cd backend
cp .env.example .env
uv sync
uv run uvicorn app:app --reload --host 0.0.0.0 --port 8000
```

### 2. Setup Frontend

```bash
cd frontend
npm install
npm run dev
```

---

## ⚙️ Configuration

Settings can be customized in `backend/.env`:

```env
# LLM Endpoint & Provider
LLM_BASE_URL=http://localhost:11434/v1
LLM_API_KEY=ollama
LLM_MODEL=gemma3:4b

# Whisper Speech-to-Text Model
WHISPER_MODEL=base.en
```

### Supported Providers

- **Ollama:** Set `LLM_BASE_URL=http://localhost:11434/v1` (or `http://ollama:11434/v1` inside Docker)
- **LM Studio:** Set `LLM_BASE_URL=http://localhost:1234/v1`
- **OpenAI:** Set `LLM_BASE_URL=https://api.openai.com/v1`, `LLM_API_KEY=your_key`, `LLM_MODEL=gpt-4o-mini`

---

## 👤 Author

- **Hugo Sanabria**

---

## 📄 License

MIT License.
