{ ... }:
{
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control, esc)";
	    "leftshift+leftmeta+f23" = "layer(meta)";
          };
        };
      };
    };
}
