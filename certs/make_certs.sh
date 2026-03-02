#!/bin/bash
# Copyright (C) 2026 Alexander Wolz <mail@alexanderwolz.de>

set -euo pipefail

CURRENT_FILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

openssl req -x509 -newkey rsa:2048 \
  -keyout "$CURRENT_FILE_DIR/key.pem" \
  -out "$CURRENT_FILE_DIR/cert.pem" \
  -days 365 -nodes \
  -subj "/CN=localhost"

openssl pkcs12 -export \
  -in "$CURRENT_FILE_DIR/cert.pem" \
  -inkey "$CURRENT_FILE_DIR/key.pem" \
  -out "$CURRENT_FILE_DIR/keystore.p12" \
  -name keycloak \
  -password pass:changeit
