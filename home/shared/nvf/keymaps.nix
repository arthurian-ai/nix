{ ... }:
{
  programs.nvf.settings.vim = {
    keymaps = [
      # Move highlighted text up/down in visual mode
      {
        key = "J";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
        silent = true;
        desc = "Move selection down";
      }
      {
        key = "K";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
        silent = true;
        desc = "Move selection up";
      }

      # J in normal mode keeps cursor in place
      {
        key = "J";
        mode = "n";
        action = "mzJ`z";
        silent = true;
        desc = "Join lines (cursor stays)";
      }

      # Half-page jumping keeps cursor centered
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
        silent = true;
        desc = "Half page down (centered)";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
        silent = true;
        desc = "Half page up (centered)";
      }

      # Paragraph jumping keeps cursor centered
      {
        key = "{";
        mode = "n";
        action = "{zz";
        silent = true;
        desc = "Previous paragraph (centered)";
      }
      {
        key = "}";
        mode = "n";
        action = "}zz";
        silent = true;
        desc = "Next paragraph (centered)";
      }

      # Search navigation keeps cursor centered
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
        silent = true;
        desc = "Next search result (centered)";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
        silent = true;
        desc = "Previous search result (centered)";
      }

      # Paste without overwriting register
      {
        key = "<leader>p";
        mode = "x";
        action = "\"_dP";
        silent = true;
        desc = "Paste (keep register)";
      }

      # System clipboard yank
      {
        key = "<leader>y";
        mode = ["n" "v"];
        action = "\"+y";
        silent = true;
        desc = "Yank to clipboard";
      }
      {
        key = "<leader>Y";
        mode = "n";
        action = "\"+Y";
        silent = true;
        desc = "Yank line to clipboard";
      }

      # Delete without overwriting register
      {
        key = "<leader>d";
        mode = ["n" "v"];
        action = "\"_d";
        silent = true;
        desc = "Delete (keep register)";
      }

      # LSP restart
      {
        key = "<leader>lr";
        mode = "n";
        action = "<cmd>LspRestart<CR>";
        silent = true;
        desc = "LSP Restart";
      }
    ];
  };
}
