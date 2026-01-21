{ ... }:
{
  programs.nvf.settings.vim = {
    keymaps = [
      # ============================================
      # User's Custom Keymaps (from original config)
      # ============================================

      # Move highlighted text up/down in visual mode
      { key = "J"; mode = "v"; action = ":m '>+1<CR>gv=gv"; silent = true; desc = "Move selection down"; }
      { key = "K"; mode = "v"; action = ":m '<-2<CR>gv=gv"; silent = true; desc = "Move selection up"; }

      # J in normal mode keeps cursor in place
      { key = "J"; mode = "n"; action = "mzJ`z"; silent = true; desc = "Join lines (cursor stays)"; }

      # Half-page jumping keeps cursor centered
      { key = "<C-d>"; mode = "n"; action = "<C-d>zz"; silent = true; desc = "Half page down (centered)"; }
      { key = "<C-u>"; mode = "n"; action = "<C-u>zz"; silent = true; desc = "Half page up (centered)"; }

      # Paragraph jumping keeps cursor centered
      { key = "{"; mode = "n"; action = "{zz"; silent = true; desc = "Previous paragraph (centered)"; }
      { key = "}"; mode = "n"; action = "}zz"; silent = true; desc = "Next paragraph (centered)"; }

      # Search navigation keeps cursor centered
      { key = "n"; mode = "n"; action = "nzzzv"; silent = true; desc = "Next search result (centered)"; }
      { key = "N"; mode = "n"; action = "Nzzzv"; silent = true; desc = "Previous search result (centered)"; }

      # Paste without overwriting register
      { key = "<leader>p"; mode = "x"; action = "\"_dP"; silent = true; desc = "Paste (keep register)"; }

      # System clipboard yank
      { key = "<leader>y"; mode = ["n" "v"]; action = "\"+y"; silent = true; desc = "Yank to clipboard"; }
      { key = "<leader>Y"; mode = "n"; action = "\"+Y"; silent = true; desc = "Yank line to clipboard"; }

      # Delete without overwriting register
      { key = "<leader>d"; mode = ["n" "v"]; action = "\"_d"; silent = true; desc = "Delete (keep register)"; }

      # ============================================
      # General / Save / Quit (LazyVim style)
      # ============================================

      { key = "<C-s>"; mode = ["n" "i" "v" "x" "s"]; action = "<cmd>w<CR><Esc>"; silent = true; desc = "Save file"; }
      { key = "<leader>qq"; mode = "n"; action = "<cmd>qa<CR>"; silent = true; desc = "Quit all"; }
      { key = "<leader>fn"; mode = "n"; action = "<cmd>enew<CR>"; silent = true; desc = "New file"; }

      # ============================================
      # Window Navigation (LazyVim style)
      # ============================================

      { key = "<C-h>"; mode = "n"; action = "<C-w>h"; silent = true; desc = "Go to left window"; }
      { key = "<C-j>"; mode = "n"; action = "<C-w>j"; silent = true; desc = "Go to lower window"; }
      { key = "<C-k>"; mode = "n"; action = "<C-w>k"; silent = true; desc = "Go to upper window"; }
      { key = "<C-l>"; mode = "n"; action = "<C-w>l"; silent = true; desc = "Go to right window"; }

      # Window resize
      { key = "<C-Up>"; mode = "n"; action = "<cmd>resize +2<CR>"; silent = true; desc = "Increase window height"; }
      { key = "<C-Down>"; mode = "n"; action = "<cmd>resize -2<CR>"; silent = true; desc = "Decrease window height"; }
      { key = "<C-Left>"; mode = "n"; action = "<cmd>vertical resize -2<CR>"; silent = true; desc = "Decrease window width"; }
      { key = "<C-Right>"; mode = "n"; action = "<cmd>vertical resize +2<CR>"; silent = true; desc = "Increase window width"; }

      # Window splits
      { key = "<leader>ww"; mode = "n"; action = "<C-w>p"; silent = true; desc = "Other window"; }
      { key = "<leader>wd"; mode = "n"; action = "<C-w>c"; silent = true; desc = "Delete window"; }
      { key = "<leader>w-"; mode = "n"; action = "<C-w>s"; silent = true; desc = "Split window below"; }
      { key = "<leader>w|"; mode = "n"; action = "<C-w>v"; silent = true; desc = "Split window right"; }
      { key = "<leader>-"; mode = "n"; action = "<C-w>s"; silent = true; desc = "Split window below"; }
      { key = "<leader>|"; mode = "n"; action = "<C-w>v"; silent = true; desc = "Split window right"; }

      # ============================================
      # Buffer Navigation (LazyVim style)
      # ============================================

      { key = "<S-h>"; mode = "n"; action = "<cmd>bprevious<CR>"; silent = true; desc = "Previous buffer"; }
      { key = "<S-l>"; mode = "n"; action = "<cmd>bnext<CR>"; silent = true; desc = "Next buffer"; }
      { key = "[b"; mode = "n"; action = "<cmd>bprevious<CR>"; silent = true; desc = "Previous buffer"; }
      { key = "]b"; mode = "n"; action = "<cmd>bnext<CR>"; silent = true; desc = "Next buffer"; }
      { key = "<leader>bb"; mode = "n"; action = "<cmd>e #<CR>"; silent = true; desc = "Switch to other buffer"; }
      { key = "<leader>bd"; mode = "n"; action = "<cmd>bdelete<CR>"; silent = true; desc = "Delete buffer"; }
      { key = "<leader>bD"; mode = "n"; action = "<cmd>bdelete!<CR>"; silent = true; desc = "Delete buffer (force)"; }

      # ============================================
      # Telescope (LazyVim style)
      # ============================================

      { key = "<leader><space>"; mode = "n"; action = "<cmd>Telescope find_files<CR>"; silent = true; desc = "Find files"; }
      { key = "<leader>ff"; mode = "n"; action = "<cmd>Telescope find_files<CR>"; silent = true; desc = "Find files"; }
      { key = "<leader>fg"; mode = "n"; action = "<cmd>Telescope live_grep<CR>"; silent = true; desc = "Grep"; }
      { key = "<leader>/"; mode = "n"; action = "<cmd>Telescope live_grep<CR>"; silent = true; desc = "Grep (root dir)"; }
      { key = "<leader>fb"; mode = "n"; action = "<cmd>Telescope buffers<CR>"; silent = true; desc = "Buffers"; }
      { key = "<leader>,"; mode = "n"; action = "<cmd>Telescope buffers<CR>"; silent = true; desc = "Switch buffer"; }
      { key = "<leader>fr"; mode = "n"; action = "<cmd>Telescope oldfiles<CR>"; silent = true; desc = "Recent files"; }
      { key = "<leader>fh"; mode = "n"; action = "<cmd>Telescope help_tags<CR>"; silent = true; desc = "Help tags"; }
      { key = "<leader>fc"; mode = "n"; action = "<cmd>Telescope colorscheme<CR>"; silent = true; desc = "Colorscheme"; }
      { key = "<leader>:"; mode = "n"; action = "<cmd>Telescope command_history<CR>"; silent = true; desc = "Command history"; }
      { key = "<leader>sk"; mode = "n"; action = "<cmd>Telescope keymaps<CR>"; silent = true; desc = "Keymaps"; }
      { key = "<leader>ss"; mode = "n"; action = "<cmd>Telescope lsp_document_symbols<CR>"; silent = true; desc = "Document symbols"; }
      { key = "<leader>sS"; mode = "n"; action = "<cmd>Telescope lsp_workspace_symbols<CR>"; silent = true; desc = "Workspace symbols"; }
      { key = "<leader>sd"; mode = "n"; action = "<cmd>Telescope diagnostics bufnr=0<CR>"; silent = true; desc = "Document diagnostics"; }
      { key = "<leader>sD"; mode = "n"; action = "<cmd>Telescope diagnostics<CR>"; silent = true; desc = "Workspace diagnostics"; }
      { key = "<leader>sw"; mode = "n"; action = "<cmd>Telescope grep_string<CR>"; silent = true; desc = "Search word under cursor"; }
      { key = "<leader>gc"; mode = "n"; action = "<cmd>Telescope git_commits<CR>"; silent = true; desc = "Git commits"; }
      { key = "<leader>gs"; mode = "n"; action = "<cmd>Telescope git_status<CR>"; silent = true; desc = "Git status"; }

      # ============================================
      # Neo-tree (LazyVim style)
      # ============================================

      { key = "<leader>e"; mode = "n"; action = "<cmd>Neotree toggle<CR>"; silent = true; desc = "Explorer toggle"; }
      { key = "<leader>fe"; mode = "n"; action = "<cmd>Neotree toggle<CR>"; silent = true; desc = "Explorer toggle"; }
      { key = "<leader>fE"; mode = "n"; action = "<cmd>Neotree reveal<CR>"; silent = true; desc = "Explorer reveal file"; }
      { key = "<leader>ge"; mode = "n"; action = "<cmd>Neotree git_status<CR>"; silent = true; desc = "Git explorer"; }
      { key = "<leader>be"; mode = "n"; action = "<cmd>Neotree buffers<CR>"; silent = true; desc = "Buffer explorer"; }

      # ============================================
      # LSP (LazyVim style)
      # ============================================

      { key = "gd"; mode = "n"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; silent = true; desc = "Go to definition"; }
      { key = "gD"; mode = "n"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; silent = true; desc = "Go to declaration"; }
      { key = "gr"; mode = "n"; action = "<cmd>Telescope lsp_references<CR>"; silent = true; desc = "References"; }
      { key = "gI"; mode = "n"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; silent = true; desc = "Go to implementation"; }
      { key = "gy"; mode = "n"; action = "<cmd>lua vim.lsp.buf.type_definition()<CR>"; silent = true; desc = "Go to type definition"; }
      { key = "K"; mode = "n"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; silent = true; desc = "Hover"; }
      { key = "gK"; mode = "n"; action = "<cmd>lua vim.lsp.buf.signature_help()<CR>"; silent = true; desc = "Signature help"; }
      { key = "<C-k>"; mode = "i"; action = "<cmd>lua vim.lsp.buf.signature_help()<CR>"; silent = true; desc = "Signature help"; }
      { key = "<leader>ca"; mode = ["n" "v"]; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; silent = true; desc = "Code action"; }
      { key = "<leader>cr"; mode = "n"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; silent = true; desc = "Rename"; }
      { key = "<leader>cf"; mode = "n"; action = "<cmd>lua vim.lsp.buf.format()<CR>"; silent = true; desc = "Format"; }
      { key = "<leader>cl"; mode = "n"; action = "<cmd>LspInfo<CR>"; silent = true; desc = "LSP info"; }
      { key = "<leader>lr"; mode = "n"; action = "<cmd>LspRestart<CR>"; silent = true; desc = "LSP restart"; }

      # Diagnostics navigation
      { key = "]d"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; silent = true; desc = "Next diagnostic"; }
      { key = "[d"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; silent = true; desc = "Previous diagnostic"; }
      { key = "]e"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>"; silent = true; desc = "Next error"; }
      { key = "[e"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>"; silent = true; desc = "Previous error"; }
      { key = "]w"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<CR>"; silent = true; desc = "Next warning"; }
      { key = "[w"; mode = "n"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<CR>"; silent = true; desc = "Previous warning"; }
      { key = "<leader>cd"; mode = "n"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; silent = true; desc = "Line diagnostics"; }

      # ============================================
      # Git / Gitsigns (LazyVim style)
      # ============================================

      { key = "]h"; mode = "n"; action = "<cmd>Gitsigns next_hunk<CR>"; silent = true; desc = "Next hunk"; }
      { key = "[h"; mode = "n"; action = "<cmd>Gitsigns prev_hunk<CR>"; silent = true; desc = "Previous hunk"; }
      { key = "<leader>ghs"; mode = ["n" "v"]; action = "<cmd>Gitsigns stage_hunk<CR>"; silent = true; desc = "Stage hunk"; }
      { key = "<leader>ghr"; mode = ["n" "v"]; action = "<cmd>Gitsigns reset_hunk<CR>"; silent = true; desc = "Reset hunk"; }
      { key = "<leader>ghS"; mode = "n"; action = "<cmd>Gitsigns stage_buffer<CR>"; silent = true; desc = "Stage buffer"; }
      { key = "<leader>ghu"; mode = "n"; action = "<cmd>Gitsigns undo_stage_hunk<CR>"; silent = true; desc = "Undo stage hunk"; }
      { key = "<leader>ghR"; mode = "n"; action = "<cmd>Gitsigns reset_buffer<CR>"; silent = true; desc = "Reset buffer"; }
      { key = "<leader>ghp"; mode = "n"; action = "<cmd>Gitsigns preview_hunk<CR>"; silent = true; desc = "Preview hunk"; }
      { key = "<leader>ghb"; mode = "n"; action = "<cmd>Gitsigns blame_line<CR>"; silent = true; desc = "Blame line"; }
      { key = "<leader>ghd"; mode = "n"; action = "<cmd>Gitsigns diffthis<CR>"; silent = true; desc = "Diff this"; }
      { key = "<leader>gg"; mode = "n"; action = "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd = 'lazygit', direction = 'float'}):toggle()<CR>"; silent = true; desc = "Lazygit"; }

      # ============================================
      # Trouble (LazyVim style)
      # ============================================

      { key = "<leader>xx"; mode = "n"; action = "<cmd>Trouble diagnostics toggle<CR>"; silent = true; desc = "Diagnostics (Trouble)"; }
      { key = "<leader>xX"; mode = "n"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>"; silent = true; desc = "Buffer diagnostics (Trouble)"; }
      { key = "<leader>cs"; mode = "n"; action = "<cmd>Trouble symbols toggle<CR>"; silent = true; desc = "Symbols (Trouble)"; }
      { key = "<leader>xL"; mode = "n"; action = "<cmd>Trouble loclist toggle<CR>"; silent = true; desc = "Location list (Trouble)"; }
      { key = "<leader>xQ"; mode = "n"; action = "<cmd>Trouble qflist toggle<CR>"; silent = true; desc = "Quickfix list (Trouble)"; }
      { key = "[q"; mode = "n"; action = "<cmd>cprev<CR>"; silent = true; desc = "Previous quickfix"; }
      { key = "]q"; mode = "n"; action = "<cmd>cnext<CR>"; silent = true; desc = "Next quickfix"; }

      # ============================================
      # Terminal (LazyVim style)
      # ============================================

      { key = "<leader>ft"; mode = "n"; action = "<cmd>ToggleTerm<CR>"; silent = true; desc = "Terminal"; }
      { key = "<C-/>"; mode = "n"; action = "<cmd>ToggleTerm<CR>"; silent = true; desc = "Terminal"; }
      { key = "<C-_>"; mode = "n"; action = "<cmd>ToggleTerm<CR>"; silent = true; desc = "Terminal"; }
      { key = "<Esc><Esc>"; mode = "t"; action = "<C-\\><C-n>"; silent = true; desc = "Exit terminal mode"; }
      { key = "<C-h>"; mode = "t"; action = "<cmd>wincmd h<CR>"; silent = true; desc = "Go to left window"; }
      { key = "<C-j>"; mode = "t"; action = "<cmd>wincmd j<CR>"; silent = true; desc = "Go to lower window"; }
      { key = "<C-k>"; mode = "t"; action = "<cmd>wincmd k<CR>"; silent = true; desc = "Go to upper window"; }
      { key = "<C-l>"; mode = "t"; action = "<cmd>wincmd l<CR>"; silent = true; desc = "Go to right window"; }

      # ============================================
      # Move lines (LazyVim style - Alt+j/k)
      # ============================================

      { key = "<A-j>"; mode = "n"; action = "<cmd>m .+1<CR>=="; silent = true; desc = "Move line down"; }
      { key = "<A-k>"; mode = "n"; action = "<cmd>m .-2<CR>=="; silent = true; desc = "Move line up"; }
      { key = "<A-j>"; mode = "i"; action = "<Esc><cmd>m .+1<CR>==gi"; silent = true; desc = "Move line down"; }
      { key = "<A-k>"; mode = "i"; action = "<Esc><cmd>m .-2<CR>==gi"; silent = true; desc = "Move line up"; }
      { key = "<A-j>"; mode = "v"; action = ":m '>+1<CR>gv=gv"; silent = true; desc = "Move selection down"; }
      { key = "<A-k>"; mode = "v"; action = ":m '<-2<CR>gv=gv"; silent = true; desc = "Move selection up"; }

      # ============================================
      # Better indenting (stay in visual mode)
      # ============================================

      { key = "<"; mode = "v"; action = "<gv"; silent = true; desc = "Indent left"; }
      { key = ">"; mode = "v"; action = ">gv"; silent = true; desc = "Indent right"; }

      # ============================================
      # Clear search highlight
      # ============================================

      { key = "<Esc>"; mode = "n"; action = "<cmd>noh<CR><Esc>"; silent = true; desc = "Clear search highlight"; }
      { key = "<leader>ur"; mode = "n"; action = "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"; silent = true; desc = "Redraw / clear hlsearch"; }
    ];
  };
}
