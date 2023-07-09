" MacVim 설정

set nocompatible
set number
set clipboard=unnamed

set smartindent
set tabstop=2
set expandtab
" >> 또는 << 키로 들여 쓰기 할때 스페이스의 갯수. 기본값 8
set shiftwidth=2 

" 색상 변경
set background=light

set laststatus=2

let g:airline_theme='solarized'

" 리더키 스페이스 설정
let mapleader="\<Space>"
map <Space> <Leader>

nnoremap <C-s> :w!<CR>
vnoremap <C-s> :w!<CR>

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bb :bprevious<CR>
nnoremap <Leader>b :<C-u>execute 'b' . v:count1<CR>

nnoremap <Leader>t :CommandT %:h<CR>

" vimrc 변경되면 즉시 리로딩
au! BufWritePost .vimrc so %
au! BufWritePost gvimrc so %

" Edit vimr configuration file
nnoremap <Leader>lc :e $MYVIMRC<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'vimwiki/vimwiki'

Plugin 'jamshedvesuna/vim-markdown-preview'

Plugin 'tpope/vim-surround'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" colorscheme
Plugin 'habamax/vim-polar'

Plugin 'chrisbra/vim-commentary'

Plugin 'wincent/command-t'

Plugin 'unicornrainbow/vim-image_paste'

" Plugin 'itchyny/calendar.vim'
Plugin 'mattn/calendar-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_highlighting_cache = 1

" Command T 설정 (파일 찾기)
let g:CommandTMaxFiles=20000
let g:CommandTPreferredImplementation='ruby'
let g:CommandTMatchWindowAtTop=1
let g:CommandTMatchWindowReverse=0
let g:CommandTMaxHeight = 30
set rubydll=/Users/hansoonmo/.rbenv/versions/3.2.2/lib/libruby.dylib

source $HOME/.config/mvim/vimwiki.vim


" Calendar itchyny/calendar.vim
" TODO vimwiki 랑 연동 시키기
" https://github.com/itchyny/calendar.vim/issues/49
"
" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1

" let g:calendar_google_api_key = '...'
" let g:calendar_google_client_id = '....apps.googleusercontent.com'
" let g:calendar_google_client_secret = '...'

