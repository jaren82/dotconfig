#!/bin/bash
# tmux 윈도우 전환 시 팝업에 표시할 윈도우 목록
echo ""
tmux list-windows -F "#{window_active} #I #W" | while read -r active idx name; do
  if [ "$active" = "1" ]; then
    printf "  \033[1;33m ★  %s: %s \033[0m\n" "$idx" "$name"
  else
    printf "  \033[2m    %s: %s\033[0m\n" "$idx" "$name"
  fi
done
echo ""
sleep 0.8
