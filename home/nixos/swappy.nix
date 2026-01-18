{ pkgs, ... }:
{
    programs.swappy = {
        enable = true;
        settings = {
            Default = {
                save_dir = "$HOME/screenshots";
                save_filename_format = "screenshot-%Y%m%d-%H%M%S.png";
                show_panel = true;
                line_size = 5;
                text_size = 20;
                early_exit = false;
                fill_shape = false;
            };
        };
    };
}
