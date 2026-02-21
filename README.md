# dotconfig
내 Mac 의 .config 폴더 관리

## Ghostty
`ghostty.conf` 파일이 원본이며, `ghostty/config`는 심볼릭 링크로 연결
```shell
ln -sf ~/.config/ghostty.conf ~/.config/ghostty/config
```

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

### 플러그인 목록
| 플러그인 | 설명 |
|---------|------|
| [tpm](https://github.com/tmux-plugins/tpm) | Tmux Plugin Manager |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | 기본 설정 모음 |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | 세션 저장/복원 |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | 자동 세션 저장 및 부팅 시 자동 복원 |

### 플러그인 설치/관리
```shell
# 플러그인 설치: prefix + I
# 플러그인 업데이트: prefix + U
# 플러그인 제거: prefix + alt + u
```

# 기타
## 맥북 키 반복 입력 속도 상승
```
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
```

```
brew install --cask font-jetbrains-mono-nerd-font
```
