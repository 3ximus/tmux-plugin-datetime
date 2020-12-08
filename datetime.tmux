#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

date_status="#($CURRENT_DIR/scripts/date.sh)"
date_status_interpolation="\#{date}"

time_status="#($CURRENT_DIR/scripts/time.sh)"
time_status_interpolation="\#{time}"

update_tmux_option() {
  local option_value="$(tmux show-option -gqv "$1")"
  tmux set-option -gq "$1" "${option_value/$date_status_interpolation/$date_status}"
  option_value="$(tmux show-option -gqv "$1")"
  tmux set-option -gq "$1" "${option_value/$time_status_interpolation/$time_status}"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}

main
