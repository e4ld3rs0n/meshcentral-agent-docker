#!/bin/sh
set -e

AGENT_DIR=/usr/local/mesh_services/meshagent
MESH_CMD=${MESH_ENROLL_CMD:-}

echo "[INFO] Starting Mesh Agent Entrypoint Script"

if [ -f "$AGENT_DIR/meshagent.msh" ]; then
    echo "[INFO] Found existing meshagent.msh, starting agent..."
    exec "$AGENT_DIR/meshagent"
else
    if [ -z "$MESH_CMD" ]; then
        echo "[WARN] No meshagent.msh and no enrollment command provided."
        echo "[INFO] Falling back to user command."
        exec "$@"
    fi
    echo "[INFO] No meshagent.msh found, please initialize the container first."
fi

