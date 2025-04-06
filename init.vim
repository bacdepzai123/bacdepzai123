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
" ============================= 
" 2. Cài đặt Plugin Manager - vim-plug
" ============================= 
call plug#begin('~/.vim/plugged')
" Các plugin đã có
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'   " Icons cho lualine
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'voldikss/vim-floaterm' 
Plug 'neovim/nvim-lspconfig'        " LSP Configuration
Plug 'hrsh7th/cmp-nvim-lsp'         " LSP Source cho nvim-cmp
Plug 'hrsh7th/nvim-cmp'             " Plugin hoàn thành mã
Plug 'hrsh7th/cmp-buffer'           " Source buffer cho nvim-cmp
Plug 'hrsh7th/cmp-path'             " Source path cho nvim-cmp
Plug 'hrsh7th/cmp-cmdline'          " Source cmdline cho nvim-cmp
Plug 'hrsh7th/vim-vsnip'            " Plugin snippets
Plug 'saadparwaiz1/cmp_luasnip'     " Source snippet cho nvim-cmp
call plug#end()

" ============================= 
" 3. Cấu hình giao diện
" ============================= 
syntax on
set background=dark
colorscheme onedark

set nobackup      
set noswapfile
set nowritebackup
set termguicolors
set synmaxcol=3000    " Prevent breaking syntax highlight when string too long. Max = 3000
" Tùy chỉnh màu sắc của colorcolumn
highlight ColorColumn ctermbg=darkgray 
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
" 3. Cấu hình LSP với clangd
" ============================= 
lua << EOF
require'lspconfig'.clangd.setup{
  cmd = { "clangd", "--compile-commands-dir=C:/Users/Admin/Documents/Competitive_Programming/Codeforces" },  -- Đảm bảo rằng bạn thay đổi đúng đường dẫn
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = require('lspconfig').util.root_pattern(".git", "compile_commands.json", "CMakeLists.txt"),
}
EOF

" ============================= 
" 4. Cấu hình nvim-cmp
" ============================= 
lua << EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)  -- Dùng với vsnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
EOF

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
    autocmd ColorScheme * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
  augroup END
endif
