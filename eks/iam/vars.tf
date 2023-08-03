# The below variable is my pgp public key base64 encoded.  This is used to create the password
# and secret_key of the iam user below.  You can change this to be your own key.
# use `gpg export <email of key> | base64` if you have your gpg installed. 
variable "pgp_key" {
  type    = string
  default = env("GAIA_GPG_KEY")

}
