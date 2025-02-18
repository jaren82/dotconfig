# dotconfig
내 Mac 의 .config 폴더 관리

## HammerSpoon 폴더 변경 명령
```shell
mv ~/.hammerspoon ~/.config/hammerspoon

defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
```


## Tmux
```shell
# plugin 설치
take ~/.config/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.config/.tmux/plugins/tpm
```

# 기타
## 맥북 키 반복 입력 속도 상승
```
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```
