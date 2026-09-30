#!/usr/bin/env bash
# Each ISO week randomly runs 3, 4, or 5 weekdays (never fewer than 3).
# Writes should_run to GITHUB_OUTPUT (arg: output) or GITHUB_ENV (arg: env).
# Always exits 0. Also prints true/false as the last stdout line.

set -euo pipefail

TARGET="${1:-env}"
NAMES=(Mon Tue Wed Thu Fri)

write_result() {
  local value=$1
  local msg=$2
  echo "$msg" >&2
  if [ "$TARGET" = "output" ]; then
    echo "should_run=$value" >> "$GITHUB_OUTPUT"
  else
    echo "should_run=$value" >> "$GITHUB_ENV"
  fi
  echo "$value"
}

if [ "${GITHUB_EVENT_NAME:-}" != "schedule" ]; then
  write_result true "Manual run. Proceeding."
  exit 0
fi

TODAY=$(date -u +%u)
if [ "$TODAY" -ge 6 ]; then
  write_result false "Weekend. Skipping."
  exit 0
fi

SEED=$(printf '%s' "$(date -u +%G-W%V)" | cksum | cut -d ' ' -f 1)
DAYS_COUNT=$(( 3 + SEED % 3 ))
DAYS=(1 2 3 4 5)

for (( i = 4; i > 0; i-- )); do
  SEED=$(( (SEED * 1103515245 + 12345) & 0x7fffffff ))
  j=$(( SEED % (i + 1) ))
  tmp=${DAYS[i]}
  DAYS[i]=${DAYS[j]}
  DAYS[j]=$tmp
done

SELECTED=()
RUN_TODAY=false
for (( i = 0; i < DAYS_COUNT; i++ )); do
  SELECTED+=("${NAMES[DAYS[i] - 1]}")
  if [ "${DAYS[i]}" -eq "$TODAY" ]; then
    RUN_TODAY=true
  fi
done

if [ "$RUN_TODAY" = true ]; then
  write_result true "This week runs ${DAYS_COUNT} days (${SELECTED[*]}). Today is a run day."
else
  write_result false "This week runs ${DAYS_COUNT} days (${SELECTED[*]}). Today is an off day."
fi
