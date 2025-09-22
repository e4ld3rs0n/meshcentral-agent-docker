#!/bin/sh
set -e

AGENT_DIR=/usr/local/mesh_services/meshagent
MESH_CMD=${MESH_ENROLL_CMD:-}

echo "[INFO] Starting Mesh Agent Entrypoint Script"

if [ -n "$MESH_HOSTNAME" ]; then
    echo "[INFO] Setting container hostname to $MESH_HOSTNAME"
    hostname "$MESH_HOSTNAME"
fi

if [ -f "$AGENT_DIR/meshagent.msh" ]; then
    echo "[INFO] Found existing meshagent.msh, starting agent..."
    exec "$AGENT_DIR/meshagent"
else
    if [ -z "$MESH_CMD" ]; then
        echo "[WARN] No meshagent.msh and no enrollment command provided."
        echo "[INFO] Falling back to user command."
        exec "$@"
    fi
    echo "[INFO] No meshagent.msh found, enrolling with provided command..."
    cd "$AGENT_DIR"

    # Run the exact command string safely
    # Note the double quotes around $MESH_CMD to preserve spaces, quotes, $...
    sh -c "$MESH_CMD"

    echo "[INFO] Enrollment complete, starting agent..."
    if [ -x "$AGENT_DIR/meshagent" ]; then
        exec "$AGENT_DIR/meshagent"
    elif [ -x ./meshagent ]; then
        exec ./meshagent
    else
        echo "[ERROR] meshagent binary not found after install"
        exit 1
    fi
fi

