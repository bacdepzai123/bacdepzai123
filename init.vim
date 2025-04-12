" ============================= 
" 1. Cấu hình cơ bản
" ============================= 
set nocompatible            " Tắt chế độ tương thích với Vi
set number                  " Hiển thị số dòng
set relativenumber          " Bật số dòng tương đối
set tabstop=4               " Đặt tab = 4 spaces
set shiftwidth=4            " Dùng 4 spaces khi thụt dòng
set expandtab               " Tab sẽ được thay thế bằng spaces
set smartindent             " Tự động thụt đầu dòng thông minh
set cursorline              " Highlight dòng hiện tại
set clipboard=unnamedplus   " Copy/Paste với clipboard của hệ thống
set hidden                  " Cho phép chuyển buffer mà không cần lưu
set nowrap                  " Không tự động xuống dòng
set mouse=a                 " Kích hoạt chuột trong mọi chế độ
set termguicolors         " Tắt màu sắc trong terminal
set guicursor=i:ver100
set showtabline=2
set nocursorline
" ============================= 
" 2. Cài đặt Plugin Manager - vim-plug
" ============================= 
call plug#begin('~/.vim/plugged')
" Code intellisense
Plug 'neoclide/coc.nvim', 
    \ {'branch': 'release'}                     " Language server protocol (LSP) 
" Các plugin đã có
" " Using Vim-Plug
Plug 'shaunsingh/solarized.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/which-key.nvim'
Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'   " Icons cho lualine
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm' 
" Tìm file (tùy chọn cho các nút hoạt động)
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'goolord/alpha-nvim'
call plug#end()
" Gọi file Lua
lua require('alpha_config')
" ============================= 
" 3. Cấu hình giao diện
" ============================= 
syntax on

set nobackup      
set noswapfile
set nowritebackup
"set termguicolors
set synmaxcol=3000    " Prevent breaking syntax highlight when string too long. Max = 3000

" ============================= 
" 5. Cấu hình NERDTree (Quản lý file)
" ============================= 
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1  " Hiện file ẩn
let g:NERDTreeQuitOnOpen=1 " Đóng tự động khi mở file

syntax match cppFunction /\v\w+\s*(.*)\s*\{/
highlight cppFunction ctermfg=blue guifg=#0000FF

let g:python3_host_prog = 'C:/Users/Admin/AppData/Local/Programs/Python/Python313/python.exe'

set background=light
" ============================= 
" 6. Cấu hình phím tắt hữu ích
" ============================= 
nnoremap <C-s> :w<CR>   
nnoremap <C-h> :nohl<CR> 
nnoremap <C-p> :Files<CR> 

set guifont=Consolas:h10
" Mở danh sách diagnostics (lỗi/warning) với phím tắt <leader>d
nnoremap <silent> <leader>d :CocDiagnostics<CR>

" Hoặc nếu muốn xem diagnostics ngay tại vị trí con trỏ (popup)
nnoremap <silent> <leader>D :CocCommand diagnostics.show<CR>

"Bonus Jump qua lại giữa các lỗi
nnoremap <silent> [d <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]d <Plug>(coc-diagnostic-next)
" ============================= 
" 7. Tắt tự động đóng ngoặc (Auto Pairs)
" ============================= 
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $
nnoremap <leader>s :w<CR>
nnoremap <leader>c :%y+<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qi :q!<CR>

" ============================= 
" Cấu hình Lualine đầy đủ
" ============================= 

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'solarized',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename' , 'filetype'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename' , 'filetype'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'tabs'},
    lualine_b = {'buffers'},
    lualine_c = {'filename', 'filetype'},
    lualine_x = {'location'},
    lualine_y = {'filetype'},
    lualine_z = {}
  },
  extensions = {'fugitive'},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
EOF
" ============================= 
" 3. Cấu hình LSP với clangd
" ============================= 

" ============================= 
" 4. Cấu hình nvim-cmp
" ============================= 

" ============================= 
" 10. Cấu hình Terminal với Floaterm
" ============================= 
let g:floaterm_position = 'topright'
nnoremap <silent> <leader>f :FloatermNew<CR>
tnoremap <silent> <leader>q <C-\><C-n>:FloatermKill<CR>
nnoremap <C-g> :FloatermToggle<CR>
tnoremap <C-g> <C-\><C-n>:FloatermToggle<CR>
nnoremap <C-j> :FloatermNext<CR>
nnoremap <C-k> :FloatermPrev<CR>



" Close buffer without exitting vim 
nnoremap <silent> <leader>bd :bp \| sp \| bn \| bd<CR>





" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by "suggest.noselect": true in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


lua << EOF
require("which-key").setup {}
EOF



"let &shell = 'pwsh'
"let &shellcmdflag = '-NoLogo -NoProfile -Command'
"let &shellquote = ''
"let &shellxquote = ''


" Example config in Vim-Script
let g:solarized_italic_comments = v:true
let g:solarized_italic_keywords = v:true
let g:solarized_italic_functions = v:true
let g:solarized_italic_variables = v:false
let g:solarized_contrast = v:true
let g:solarized_borders = v:false
let g:solarized_disable_background = v:false

" Load the colorsheme
colorscheme solarized

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

