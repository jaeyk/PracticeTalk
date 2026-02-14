# PracticeTalk

PracticeTalk is a lightweight local speech synthesis tool with a web interface that turns your talk script into audio so you can review flow and narrative.

Jae Yeon Kim and Codex (2026).

## Recommended Mode

Run locally and use one URL only:

- `http://127.0.0.1:8000`

## Requirements

- Python 3.10+
- Internet connection (needed when synthesizing speech via `edge-tts`)

Python package dependencies are in `requirements.txt`:

- `fastapi`
- `uvicorn[standard]`
- `edge-tts`
- `python-multipart`

You do not need to install these manually if you use the launcher scripts below.

## Quick Start (Script-Based)

### Mac / Linux

macOS (double-click):

- Double-click `run_local.command` in Finder.

Run:

```bash
bash scripts/run_local.sh
```

What this script does:

1. Finds Python 3
2. Creates `.venv` if missing
3. Installs dependencies from `requirements.txt`
4. Starts server on `127.0.0.1:8000`
5. Opens your browser automatically

### Windows (Command Prompt)

Run:

```bat
scripts\run_local.bat
```

What this script does:

1. Finds `py` or `python`
2. Creates `.venv` if missing
3. Installs dependencies from `requirements.txt`
4. Starts server on `127.0.0.1:8000`
5. Opens your browser automatically

## Manual Start (Advanced)

If you prefer manual control:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --host 127.0.0.1 --port 8000
```

Then open:

- `http://127.0.0.1:8000`

Stop the app with `Ctrl + C`.

## Troubleshooting

- Python not found: install Python 3.10+ from `https://www.python.org/downloads/`, then run the launcher script again.
- macOS blocked `run_local.command`: right-click the file, choose `Open`, then confirm `Open`.
- Port `8000` already in use: stop the other app using port 8000, then restart the launcher script.

## Features

- Upload a `.txt` file or paste text and synthesize speech.
- Supports `en-US-AvaMultilingualNeural` (default) plus additional voices in the UI.
- Chunked synthesis for long texts.
- Optional streaming (MP3) for long inputs.
- Adjustable `pace` (Slow, Normal, Fast, Faster).
- Slide markers like `Slide 1 Slide 2` are automatically skipped.
- Output formats: `MP3` and `WAV`.

## Docker

- Build: `docker build -t talk-practice .`
- Run: `docker run -p 8000:8000 talk-practice`

## GitHub Pages (Frontend Only)

- Workflow `publish.yml` deploys `static/` to `https://jaeyk.github.io/PracticeTalk/`.
- GitHub Pages is frontend-only.
- On that page, set **Backend URL** to your running FastAPI server.
- If you do not have a backend URL, use local mode at `http://127.0.0.1:8000`.

## Notes

- Uploaded text must be UTF-8.
- Max input is about 200k characters (configurable in `main.py`).
- Long scripts may take time to process.
