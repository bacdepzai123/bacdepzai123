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
set mouse=a

" =============================
" 2. Cài đặt Plugin Manager - vim-plug
" =============================
call plug#begin('~/.vim/plugged')
" Theme OneDark
Plug 'joshdick/onedark.vim'
Plug 'kassio/neoterm'  " Thêm plugin neoterm
Plug 'nvim-tree/nvim-web-devicons'   " Icons cho lualine
" Quản lý cây thư mục (NERDTree)
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons' " Biểu tượng file đẹp hơn

Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" =============================
" 3. Cấu hình giao diện
" =============================
set background=dark
colorscheme onedark

set nobackup      
set noswapfile
set nowritebackup

" =============================
" 5. Cấu hình NERDTree (Quản lý file)
" =============================
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1  " Hiện file ẩn
let g:NERDTreeQuitOnOpen=1 " Đóng tự động khi mở file

" =============================
" 6. Cấu hình phím tắt hữu ích
" =============================
nnoremap <C-s> :w<CR>   
nnoremap <C-h> :nohl<CR> 
nnoremap <C-p> :Files<CR> 

set guifont=Consolas:h10
" =============================
" 7. Tắt tự động đóng ngoặc (Auto Pairs)
" =============================
" Không cài bất kỳ plugin auto-close brackets nào
autocmd filetype cpp nnoremap <F9> :w <bar> !g++ -std=c++17 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F10> :!%:r<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $

" Cấu hình Lualine đầy đủ (bao gồm tabline hiển thị buffer)
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
    lualine_c = {'filename' , 'filetype'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
EOF

" =============================
" 8. Cấu hình Neoterm với Vị trí cố định
" =============================
" Mở terminal mới (Ctrl + T)
nnoremap <F12> :Ttoggle<CR>

" Đảm bảo terminal luôn mở ở góc phải trên cùng
autocmd TermOpen * call PositionTerminal()

" Hàm di chuyển terminal đến góc phải trên cùng
function! PositionTerminal()
  " Lấy kích thước của terminal và cửa sổ Neovim
  let l:width = &columns
  let l:height = &lines

  " Đặt vị trí của terminal
  " Điều chỉnh để đặt cửa sổ terminal ở góc phải trên
  call nvim_win_set_config(0, {'relative': 'editor', 'row': 0, 'col': l:width - 20, 'width': 80, 'height': 20})
endfunction

" Đóng terminal
tnoremap <C-q> <C-\><C-n>:Tclose<CR>

" Di chuyển giữa các terminal (nếu bạn mở nhiều)
nnoremap <C-j> :Tnext<CR>
nnoremap <C-k> :Tprev<CR>


" Overwrite some color highlight 
if (has("autocmd"))
  augroup colorextend
    autocmd ColorScheme 
      \ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
    autocmd ColorScheme 
      \ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
  augroup END
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
