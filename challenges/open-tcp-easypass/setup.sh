#!/bin/bash
set -e

# Generate a random 6-character password
PASS=$(LC_ALL=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 6)
echo "$PASS" > /tmp/passwd

# Update the root password
echo "root:$PASS" | chpasswd

# Create a python script to serve the password
mkdir -p /app
cat <<EOF > /app/server.py

import socket
import os

def run_server():
    host = '0.0.0.0'
    port = 10051
    
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((host, port))
        s.listen(1)
        print(f"Server listening on port {port}...")
        while True:
            conn, addr = s.accept()
            with conn:
                with open('/tmp/passwd', 'rb') as f:
                    conn.sendall(f.read())

if __name__ == "__main__":
    run_server()
EOF

# Run the python server
# Since it's a simple script, we can just run it
exec python3 /app/server.py
