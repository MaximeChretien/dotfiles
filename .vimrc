set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'ap/vim-buftabline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set number
set smartindent
colorscheme molokaiCustom
set t_Co=256
set mouse=a
set hidden

set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set encoding=utf-8
set fileencoding=utf-8

set lazyredraw
set showmatch
set wildmenu
set incsearch
set hlsearch
set completeopt-=preview

set foldenable
set foldmethod=syntax
set foldlevelstart=10

set colorcolumn=80,100,120

set clipboard=unnamedplus

let g:instant_markdown_autostart = 1

let g:buttabline_show=1
let g:buftabline_numbers=1
let g:buftabline_indicators=1

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufEnter * syntax match ExtraWhitespace "\s\+$"

set list
set listchars=tab:>-,nbsp:␣,lead:·

map gn :bn<cr>
map gN :bp<cr>

filetype plugin on

vmap <C-c> y
vmap <C-x> c
vmap <C-v> d<ESC>p
imap <C-v> <ESC>pa
