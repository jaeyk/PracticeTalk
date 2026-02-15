# Deployment Guide (Hugging Face Spaces)

If you don't want to run the app locally, you can deploy it for free on Hugging Face Spaces using Docker.

## Steps

1. **Create a Space**:
    - Go to [huggingface.co/spaces](https://huggingface.co/spaces).
    - Click **Create new Space**.
    - **Name**: `practice-talk` (or similar).
    - **SDK**: Select **Docker**.
    - **Space Hardware**: **Free (CPU basic)** is sufficient.
    - **Visibility**: Public or Private.

### Option 1: Automatic Sync (Recommended)

1. **Get your Token**:
    - Go to [huggingface.co/settings/tokens](https://huggingface.co/settings/tokens).
    - Create a **Write** token (e.g., `GITHUB_ACTION`).
2. **Add Secret to GitHub**:
    - Go to your GitHub repo -> **Settings** -> **Secrets and variables** -> **Actions**.
    - Click **New repository secret**.
    - **Name**: `HF_TOKEN`
    - **Value**: (Paste your token)
3. **Add Space Repo Variable (recommended)**:
    - Go to GitHub repo -> **Settings** -> **Secrets and variables** -> **Actions** -> **Variables**.
    - Click **New repository variable**.
    - **Name**: `HF_SPACE_REPO`
    - **Value**: `<your-hf-username>/<your-space-name>` (example: `jaeykim/PracticeTalk`)
4. **Push**:
    - Once you push this code to GitHub, the Action will run and deploy your app to Spaces automatically!
    - You can also run it manually from **Actions** -> **Deploy to Hugging Face Spaces** -> **Run workflow**.

#### What this workflow does

- Pushes a clean snapshot of your app to Spaces (not full git history).
- Excludes local build artifacts (`dist/`, `build/`, `.venv/`) to avoid large-file deployment failures.

### Option 2: Manual Uploads

1. **Upload Files**:
    - Upload the contents of this repository to your Space.
    - specifically, ensure `Dockerfile`, `requirements.txt`, `main.py`, and the `static/` folder are uploaded.

2. **Port Configuration**:
    - This repository is configured to listen on **port 7860**, which is the default for Hugging Face Spaces.
    - The `Dockerfile` exposes this port automatically.

3. **Access the App**:
    - Once built (approx. 2-5 mins), your app will be live at `https://huggingface.co/spaces/<your-username>/<space-name>`.

## Troubleshooting

- **Action fails with authentication error**:
  - Recreate `HF_TOKEN` with **Write** permission and update the GitHub secret.
- **Action succeeds but wrong Space updates**:
  - Set `HF_SPACE_REPO` correctly to `<username>/<space-name>`.
- **Space build keeps failing with file-size/repo issues**:
  - Confirm large local artifacts are not deployed (this workflow excludes `dist/` and `build/`).
