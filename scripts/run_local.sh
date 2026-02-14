#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

URL="http://127.0.0.1:8000"
VENV_DIR=".venv"

if command -v python3 >/dev/null 2>&1; then
  PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_BIN="python"
else
  echo "Error: Python 3 is not installed. Install Python 3.10+ and run again."
  exit 1
fi

echo "Using Python: $($PYTHON_BIN --version 2>&1)"

if [ ! -d "$VENV_DIR" ]; then
  echo "Creating virtual environment..."
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

VENV_PY="$VENV_DIR/bin/python"
if [ ! -x "$VENV_PY" ]; then
  echo "Error: could not find $VENV_PY"
  exit 1
fi

echo "Installing dependencies..."
"$VENV_PY" -m pip install -r requirements.txt

echo "Starting PracticeTalk at $URL"
"$VENV_PY" -m uvicorn main:app --host 127.0.0.1 --port 8000 &
SERVER_PID=$!

cleanup() {
  if kill -0 "$SERVER_PID" >/dev/null 2>&1; then
    kill "$SERVER_PID" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT INT TERM

for _ in $(seq 1 30); do
  if "$VENV_PY" -c "import urllib.request; urllib.request.urlopen('$URL', timeout=1)" >/dev/null 2>&1; then
    break
  fi
  sleep 0.5
done

if command -v open >/dev/null 2>&1; then
  open "$URL"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL" >/dev/null 2>&1 || true
else
  echo "Open this URL in your browser: $URL"
fi

echo "Server is running. Press Ctrl+C to stop."
wait "$SERVER_PID"
