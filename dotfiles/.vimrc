

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Bundles {
    
    Bundle 'VundleVim/Vundle.vim'
    Bundle 'tpope/vim-unimpaired'               
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'scrooloose/nerdtree'
    Bundle 'wincent/command-t'
    Bundle 'kien/ctrlp.vim'
    Bundle 'kana/vim-textobj-user'
    Bundle 'bling/vim-airline'
    Bundle 'majutsushi/tagbar'
    Bundle 'godlygeek/tabular'
    Bundle 'sandeepcr529/Buffet.vim'
    Bundle 'rbgrouleff/bclose.vim'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'marijnh/tern_for_vim'
    Bundle 'SirVer/ultisnips'

    Bundle 'sheerun/vim-polyglot'
    Bundle 'pangloss/vim-javascript'                                                                             
    Bundle 'scrooloose/syntastic'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'ervandew/supertab'
    Bundle 'hallettj/jslint.vim'
    Bundle 'walm/jshint.vim'
    Bundle 'digitaltoad/vim-jade'
    Bundle 'guileen/vim-node'
    Bundle 'myhere/vim-nodejs-complete'
    Bundle 'maksimr/vim-jsbeautify'
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'Raimondi/delimitMate'

    Bundle 'fatih/vim-go'
    Bundle 'nsf/gocode', {'rtp': 'vim/'}

    Bundle 'sumpygump/php-documentor-vim'
    Bundle 'spf13/PIV'
    Bundle 'Shougo/vimproc.vim', {
         \ 'build' : {
         \     'windows' : 'tools\\update-dll-mingw',
         \     'cygwin' : 'make -f make_cygwin.mak',
         \     'mac' : 'make -f make_mac.mak',
         \     'linux' : 'make',
         \     'unix' : 'gmake',
         \    },
         \ }
    Bundle 'Shougo/unite.vim'

    Bundle 'slim-template/vim-slim'

    Bundle 'fatih/molokai'
    Bundle 'chriskempson/vim-tomorrow-theme'

    Bundle 'plasticboy/vim-markdown'
    Bundle 'nelstrom/vim-markdown-folding'
    Bundle 'mikewest/vimroom'
    Bundle 'reedes/vim-pencil'
    Bundle 'reedes/vim-colors-pencil'
    Bundle 'reedes/vim-wordy'
    Bundle 'reedes/vim-lexical'
    Bundle 'reedes/vim-quotable'
    Bundle 'reedes/vim-textobj-sentence'
    Bundle 'reedes/vim-litecorrect'
    Bundle 'vim-scripts/LanguageTool' 
    Bundle 'exvim/ex-autocomplpop'
"}

let mapleader=","

"call pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set modelines=0
set backspace=indent,eol,start
set foldmethod=syntax
set foldlevelstart=1

set virtualedit=all
set history=1000

set clipboard=unnamed
set synmaxcol=128
set hlsearch
set smarttab
set tags=tags


set encoding=utf-8 nobomb
set fileencoding=utf-8 nobomb
scriptencoding utf-8

set autoread
set binary
set noeol
set showmode
set showcmd
set number
set hidden
set wildmenu
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent
set visualbell
set cursorline
set ttyfast
set ttyscroll=10
set undofile
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set nowrap

set t_Co=256
set laststatus=2
colorscheme molokai

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
        set undodir=~/.vim/undo
endif


imap <C-e> <C-y>,
nnoremap / /\v
vnoremap / /\v
nnoremap D d$
map <Leader>b :MBEOpen<cr>
nmap <F8> :TagbarToggle<CR>

autocmd vimenter * if !argc() | NERDTree | endif

let g:miniBufExplMapCTabSwitchBufs = 1

if has("statusline")
     set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
 endif

" Plugins {
    " pdv-standalone {
        " use "" as parameter to turn tag off
        let g:pdv_cfg_php4guess=0
        let g:pdv_cfg_Package=" "
        let g:pdv_cfg_Author=" "
        let g:pdv_cfg_Version=" "
    " }

    " CtrlP {
        let g:ctrlp_max_files=50000
    " }

    " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " }

    " phpcomplete-extended {
        let g:phpcomplete_index_composer_command = 'composer'
    " }

    " NERDTree
        nmap <leader>n :NERDTreeToggle<CR>
        let NERDTreeHighlightCursorline=1
        let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg']
    " }
    
    " vim-markdown {
    "   Highlight YAML frontmatter as used by Jekyll 
        let g:vim_markdown_frontmatter=1        
    " }

    " Syntastic
        let g:syntastic_mode_map = { 'mode': 'passive' }
        let g:syntastic_ruby_exec = '~/.rvm/rubies/ruby-2.0.0-p0/bin/ruby'
    " }
    
    " SuperTab {
        let g:SuperTabDefaultCompletionType = "context"
    " }

" }

" Automatic settings {
    autocmd BufWritePre *.rb :%s/\s\+$//e
    autocmd BufWritePre *.go :%s/\s\+$//e
    autocmd BufWritePre *.haml :%s/\s\+$//e
    autocmd BufWritePre *.html :%s/\s\+$//e
    autocmd BufWritePre *.scss :%s/\s\+$//e
    autocmd BufWritePre *.slim :%s/\s\+$//e
    autocmd BufWritePre *.php :%s/\s\+$//e

    au BufNewFile * set noeol
    au BufRead,BufNewFile *.go set filetype=go

    " Configurations for Markdown files
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    "
    " Automatically remove trailing whitespace on Markdown files
    autocmd BufWritePre *.md :%s/\s\+$//e

    " Also setting text files as Markdown, effectively, as the same rules
    " largely apply
    autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

    " Configurations for PHP files
    autocmd BufNewFile,BufReadPost *.php set filetype=php

    " No show command
    "autocmd VimEnter * set nosc

    " enable spell checking in git commit messages
    autocmd FileType gitcommit setlocal spell

    " PHP settings {
        " PHP shortcuts
        "autocmd FileType php inoremap <C--> ->
        "autocmd FileType php inoremap <C-=>> =>

        " phpDoc
        autocmd FileType php inoremap <buffer> <LocalLeader>d <ESC>:call PhpDocSingle()<CR>i 
        autocmd FileType php nnoremap <buffer> <LocalLeader>d :call PhpDocSingle()<CR> 
        autocmd FileType php vnoremap <buffer> <LocalLeader>d :call PhpDocRange()<CR>

        " PHP Namespace remaps
        autocmd FileType php noremap <buffer> <LocalLeader>n :call PhpInsertUse()<CR>
        autocmd FileType php noremap <buffer> <LocalLeader>e :call PhpExpandClass()<CR>

        " PHP Parsing & Checking commands
        autocmd FileType php noremap <buffer> <C-M> :w!<CR>:!php %<CR>
        autocmd FileType php noremap <buffer> <LocalLeader>l :w!<CR>:!php -l %<CR>
        autocmd FileType php noremap <buffer> <LocalLeader>b :w!<CR>:!vendor/bin/behat<CR>
        autocmd FileType php noremap <buffer> <LocalLeader>u :w!<CR>:!vendor/bin/phpunit<CR>
        autocmd FileType php noremap <buffer> <LocalLeader>s :w!<CR>:!vendor/bin/phpspec run -v<CR>

        " Cucumber
        autocmd FileType cucumber noremap <buffer> <LocalLeader>b :w!<CR>:!vendor/bin/behat %<CR>

        autocmd FileType php nnoremap <buffer> <f8> :exe ':!phpctags --flags="+aim" --exclude=".git" --exclude="vendor/pdepend" --exclude="composer.phar" --sort=yes --memory=-1 --recurse=yes -f "' . g:project_tags .'" .'<CR>
        autocmd FileType php nnoremap <buffer> execute "set tags=" . g:project_tags

        autocmd FileType php setlocal ts=4 sts=4 sw=4

        " Strip trailing white space from .php files
        autocmd BufWritePre *.php :%s/\s\+$//e

        " Indentation rules
        autocmd FileType php set expandtab

        " PHPDoc settings
        if !exists("g:pdv_cfg_Author")
            let g:pdv_cfg_Author = "Matthew Setter <matthew.setter@gmail.com>"
        endif

        " Set up syntax checker
        let g:syntastic_php_checkers=['php', 'vendor/bin/phpcs', 'vendor/bin/phpmd']

        " Refactoring
        let g:php_refactor_command='php ~/bin/refactor.phar'

        " CS Fixer
        let g:php_cs_fixer_path = "php-cs-fixer" 
        let g:php_cs_fixer_level = "all"       
        let g:php_cs_fixer_config = "default" 
        let g:php_cs_fixer_php_path = "php"     
        let g:php_cs_fixer_enable_default_mapping = 1
        let g:php_cs_fixer_dry_run = 0
        let g:php_cs_fixer_verbose = 1
    " }

    " Javascript {
        " 2 space indents
        autocmd FileType javascript setlocal ts=2 sts=2 sw=2
    " }

    " Coffeescript {
        " 2 space indents
        autocmd FileType coffee setlocal ts=2 sts=2 sw=2
    " }

    " HTML {
        " 2 space indents
        autocmd FileType html setlocal ts=2 sts=2 sw=2
    " }

    " Go {
        au FileType go nmap <Leader>s <Plug>(go-implements)
        au FileType go nmap <Leader>i <Plug>(go-info)
        au FileType go nmap <Leader>gd <Plug>(go-doc)
        au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
        au FileType go nmap <leader>r <Plug>(go-run)
        au FileType go nmap <leader>b <Plug>(go-build)
        au FileType go nmap <leader>t <Plug>(go-test)
        au FileType go nmap <leader>c <Plug>(go-coverage)
        au FileType go nmap <Leader>ds <Plug>(go-def-split)
        au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
        au FileType go nmap <Leader>dt <Plug>(go-def-tab)
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
    " }
" }

" Key (re)Mappings {

    " Quick ESC
    imap jj <ESC>

    " Jump to the next row on long lines
    map <Down> gj
    map <Up>   gk
    nnoremap j gj
    nnoremap k gk

    " Resize buffers
    if bufwinnr(1)
      nmap Ä <C-W><<C-W><
      nmap Ö <C-W>><C-W>>
      nmap ö <C-W>-<C-W>-
      nmap ä <C-W>+<C-W>+
    endif

    " Map the space bar to open/close a fold
    nnoremap <Space> za

    " format the entire file
    nmap <leader>fef ggVG=

    " Map the buffer list
    nmap <leader>l :ls
    
    " Fast saves
    nmap <leader>w :w!<cr>

    " Edit todo list for project
    nmap ,todo :e todo.txt<cr>

    " Edit composer.json
    nmap <leader>lc :e composer.json<cr>

    "Load the current buffer in Chrome
    nmap ,c :!open -a Google\ Chrome<cr>

    " Open new buffers
    nmap <leader>s<left>   :leftabove  vnew<cr>
    nmap <leader>s<right>  :rightbelow vnew<cr>
    nmap <leader>s<up>     :leftabove  new<cr>
    nmap <leader>s<down>   :rightbelow new<cr>

    " Not quite working yet.
    nmap <leader>l <Plug>Ysurroundiw]%a(<C-R>*)<Esc>
    vmap <leader>l <Plug>Vsurroundiw]%a(<C-R>*)<Esc>

    " Tab between buffers
    noremap <tab> <c-w><c-w>

    " Switch between last two buffers
    nnoremap <leader><leader> <C-^>

    " Toggle numbers.vim
    nnoremap <F3> :NumbersToggle<CR>
                    
"  }

" Go programming
set rtp+=/usr/local/Cellar/go/1.0.3/misc/vim

" Quit with :Q
command -nargs=0 Quit :qa!

" vim-pencil configuration
" For further options see https://github.com/reedes/vim-pencil
" let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md call pencil#init({'wrap': 'soft'})
                              \ | call lexical#init()
                              \ | call litecorrect#init()
                              \ | call textobj#quote#init()
                              \ | call textobj#sentence#init()
  autocmd FileType markdown,mkd,md call SetMarkdownOptions() 
  autocmd FileType text            call pencil#init({'wrap': 'soft'})
augroup END

function SetMarkdownOptions()
  setlocal spell spelllang=en_us
  nmap <leader>l <Plug>Ysurroundiw]%a(<C-R>*)<Esc>
endfunction
