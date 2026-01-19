{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 2;
      };
      auth = {
	fingerprint.enabled = true;
      };
    };
  };
}
