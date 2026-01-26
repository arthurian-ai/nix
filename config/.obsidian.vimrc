" set scrolloff=999 " Not working locally
" Unmap space so it can be used as a leader key
unmap <Space>

" Simulate scrolloff by centering after movement
" Using noremap to prevent recursive mapping loops (which cause freezing)
noremap j jzz
noremap k kzz
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
noremap n nzz
noremap N Nzz
noremap G Gzz
noremap gg ggzz
noremap { {zz
noremap } }zz

" Replace 'shellsession' line with code block
" Usage: Place cursor on the 'shellsession' line and press Space+s
noremap <Space>s S```sh<Esc>}O```<Esc>

" Replace ALL 'shellsession' blocks (Recursive)
" Usage: Press Space+S (Space + Shift + s) to replace all occurrences from the cursor downwards.
" Works by finding a match, triggering the single replace, and calling itself again.
nmap <Space>S /shellsession<CR><Space>s<Space>S
