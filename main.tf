provider "newrelic" {
  account_id = var.account_id
  api_key    = var.api_key
  region     = "US"
}

resource "newrelic_alert_policy" "test_policy" {
  name = "Jenkins Test Policy"
}
