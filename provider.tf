provider "vault" {
  address         = "http://vault-internal.rdevopsb72.shop:8200"
  token           = var.vault_token
  skip_tls_verify = true
}