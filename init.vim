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
set notermguicolors         " Tắt màu sắc trong terminal
set colorcolumn=120
set guicursor=i:ver100
set showtabline=2
" ============================= 
" 2. Cài đặt Plugin Manager - vim-plug
" ============================= 
call plug#begin('~/.vim/plugged')
" Code intellisense
Plug 'neoclide/coc.nvim', 
    \ {'branch': 'release'}                     " Language server protocol (LSP) 
" Các plugin đã có
Plug 'joshdick/onedark.vim'
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
set background=dark
colorscheme onedark

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

" ============================= 
" 6. Cấu hình phím tắt hữu ích
" ============================= 
nnoremap <C-s> :w<CR>   
nnoremap <C-h> :nohl<CR> 
nnoremap <C-p> :Files<CR> 

set guifont=Consolas:h10
" Mở danh sách diagnostics (lỗi/warning) với phím tắt <leader>d
nnoremap <silent> <leader>d :CocList diagnostics<CR>

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

" ============================= 
" Cấu hình Lualine đầy đủ
" ============================= 

lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
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
    lualine_y = {'branch'},
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
nnoremap <F12> :FloatermNew<CR>
tnoremap <C-q> <C-\><C-n>:FloatermKill<CR>
nnoremap <C-g> :FloatermToggle<CR>
tnoremap <C-g> <C-\><C-n>:FloatermToggle<CR>
nnoremap <C-j> :FloatermNext<CR>
nnoremap <C-k> :FloatermPrev<CR>



" ============================= 
" Overwrite some color highlight 
" ============================= 
if (has("autocmd"))
  augroup colorextend
    autocmd ColorScheme * call onedark#extend_highlight("Comment",{"fg": {"ctermfg": "#728083"}})
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", {"fg": {"ctermfg": "#728083"}})
  augroup END
endif

" Close buffer without exitting vim 
nnoremap <silent> <leader>bd :bp \| sp \| bn \| bd<CR>


let g:onedark_color_overrides = {
\ "background": {"gui": "#2F343F", "cterm": "235", "cterm16": "0" },
\ "purple": { "gui": "#C678DF", "cterm": "170", "cterm16": "5" }
\}

if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Make `Function`s bold in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Function", { "cterm": "bold" })
    " Override the `Statement` foreground color in 256-color mode
    autocmd ColorScheme * call onedark#extend_highlight("Statement", { "fg": { "cterm": 128 } })
    " Override the `Identifier` background color in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Identifier", { "bg": { "cterm": "#333333" } })
  augroup END
endif
