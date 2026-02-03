let
  curtis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKaH3S3XSqFG5nleRdukBtLY9inSJQyXzX+PtTc7Q4m9";
in {
  "eduroam-identity.age".publicKeys = [curtis];
  "eduroam-password.age".publicKeys = [curtis];
}
