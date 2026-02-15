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

2. **Upload Files**:
    - Upload the contents of this repository to your Space.
    - specifically, ensure `Dockerfile`, `requirements.txt`, `main.py`, and the `static/` folder are uploaded.

3. **Port Configuration**:
    - This repository is configured to listen on **port 7860**, which is the default for Hugging Face Spaces.
    - The `Dockerfile` exposes this port automatically.

4. **Access the App**:
    - Once built (approx. 2-5 mins), your app will be live at `https://huggingface.co/spaces/<your-username>/<space-name>`.
