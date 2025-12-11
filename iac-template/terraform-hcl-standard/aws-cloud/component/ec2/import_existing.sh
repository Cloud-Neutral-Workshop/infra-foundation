#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname "$0")" && pwd)
export CONFIG_FILE="$SCRIPT_DIR/../../config/resources/ec2/dev.yaml"
export ACCOUNT_FILE="$SCRIPT_DIR/../../config/accounts/dev.yaml"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Config file not found: $CONFIG_FILE" >&2
  exit 1
fi
if [[ ! -f "$ACCOUNT_FILE" ]]; then
  echo "Account file not found: $ACCOUNT_FILE" >&2
  exit 1
fi

# Extract configuration details via Python/YAML (installing PyYAML on demand).
read -r KEY_NAME SG_NAME VPC_ID REGION <<<"$(python - <<'PY'
import os
import subprocess
import sys
from pathlib import Path
try:
    import yaml  # type: ignore
except ImportError:
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pyyaml'], stdout=subprocess.DEVNULL)
    import yaml  # type: ignore

config_path = Path(os.environ["CONFIG_FILE"])
account_path = Path(os.environ["ACCOUNT_FILE"])
config = yaml.safe_load(config_path.read_text())
account = yaml.safe_load(account_path.read_text())

values = [
    config.get('keypair', {}).get('name', ''),
    config.get('security_group', {}).get('name', ''),
    config.get('vpc_id', ''),
    account.get('region', ''),
]
print(' '.join(values))
PY
)"

export AWS_REGION="${REGION}"
export AWS_PAGER=""

if [[ -z "$REGION" ]]; then
  echo "AWS region missing in account config; cannot continue." >&2
  exit 1
fi

check_state() {
  terraform state show "$1" >/dev/null 2>&1
}

# Import existing key pair if present in AWS but missing from Terraform state.
if aws ec2 describe-key-pairs --key-names "$KEY_NAME" >/dev/null 2>&1; then
  if ! check_state aws_key_pair.this; then
    echo "Importing existing key pair: $KEY_NAME"
    terraform import aws_key_pair.this "$KEY_NAME" >/dev/null
  fi
fi

# Import existing security group if present in AWS but missing from Terraform state.
SG_ID=$(aws ec2 describe-security-groups \
  --filters "Name=group-name,Values=$SG_NAME" "Name=vpc-id,Values=$VPC_ID" \
  --query 'SecurityGroups[0].GroupId' --output text 2>/dev/null | tr -d '\r')
if [[ -n "$SG_ID" && "$SG_ID" != "None" ]]; then
  if ! check_state aws_security_group.this; then
    echo "Importing existing security group: $SG_NAME ($SG_ID)"
    terraform import aws_security_group.this "$SG_ID" >/dev/null
  fi
fi
