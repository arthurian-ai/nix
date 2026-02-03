{
  config,
  lib,
  ...
}: {
  age.secrets = {
    eduroam-identity.file = ../../secrets/eduroam-identity.age;
    eduroam-password.file = ../../secrets/eduroam-password.age;
  };

  networking.networkmanager.ensureProfiles = {
    # Create identity secret (enter: EDUROAM_IDENTITY=curtismitchell@berkeley.edu)
    # agenix -e eduroam-identity.age
    # Create password secret (enter: EDUROAM_PASSWORD=hash:4f3875ca7132ac8b51f82394465ee711)
    # agenix -e eduroam-password.age
    environmentFiles = [
      config.age.secrets.eduroam-identity.path
      config.age.secrets.eduroam-password.path
    ];
    profiles.eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };
      wifi = {
        ssid = "eduroam";
        mode = "infrastructure";
      };
      wifi-security = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "peap;";
        identity = "$EDUROAM_IDENTITY";
        password = "$EDUROAM_PASSWORD";
        phase1-peaplabel = "0";
        phase2-auth = "mschapv2";
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        method = "auto";
      };
    };
  };
}
