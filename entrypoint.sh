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
        echo "[ERROR] No meshagent.msh and no enrollment command provided."
        exit 1
    fi
    echo "[INFO] No meshagent.msh found, enrolling with provided command..."
    cd "$AGENT_DIR"
    sh -c "$MESH_CMD"
    echo "[INFO] Enrollment complete, starting agent..."
    exec "$AGENT_DIR/meshagent"
fi
