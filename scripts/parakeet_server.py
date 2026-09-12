#!/usr/bin/env python3
"""Tiny persistent Parakeet v3 transcription server for e6/readback-mode.

Loads NVIDIA parakeet-tdt-0.6b-v3 ONCE, then transcribes WAV files on demand.
Started by Emacs when `e6/readback-mode' is enabled and killed when it's
disabled, so the model only occupies memory while you're actually using the
read-aloud / dictation workflow.

Protocol (kept dead simple, localhost only):
  POST /transcribe   body = absolute path to a 16kHz mono WAV file
  ->  200, body = the transcript as UTF-8 text

Env:
  E6_STT_PORT   port to listen on (default 8123)
  E6_STT_MODEL  HF model id (default nvidia/parakeet-tdt-0.6b-v3)

Requirements (Linux):  pip install -U "nemo_toolkit[asr]"
Parakeet v3 is multilingual (auto-detects language), so English and Spanish
both work with the same model.
"""
import os
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = int(os.environ.get("E6_STT_PORT", "8123"))
MODEL_ID = os.environ.get("E6_STT_MODEL", "nvidia/parakeet-tdt-0.6b-v3")

print(f"[e6-stt] loading {MODEL_ID} ...", flush=True)
import nemo.collections.asr as nemo_asr  # noqa: E402

_model = nemo_asr.models.ASRModel.from_pretrained(model_name=MODEL_ID)
print(f"[e6-stt] model loaded; listening on 127.0.0.1:{PORT}", flush=True)


def _transcribe(path: str) -> str:
    out = _model.transcribe([path])
    if not out:
        return ""
    first = out[0]
    # NeMo returns objects with .text (newer) or plain strings (older).
    return getattr(first, "text", first if isinstance(first, str) else str(first))


class Handler(BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        path = self.rfile.read(length).decode("utf-8").strip()
        text = ""
        try:
            if path and os.path.exists(path):
                text = (_transcribe(path) or "").strip()
            else:
                sys.stderr.write(f"[e6-stt] missing file: {path!r}\n")
        except Exception as exc:  # keep the server alive on any error
            sys.stderr.write(f"[e6-stt] error: {exc}\n")
        body = text.encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):  # silence per-request logging
        pass


if __name__ == "__main__":
    HTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
