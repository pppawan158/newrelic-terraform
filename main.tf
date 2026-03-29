############################
# VARIABLES
############################

variable "account_id" {
  type = number
}

variable "api_key" {
  type = string
}

variable "enable_high_cpu" {
  description = "Enable High CPU alert"
  type        = bool
  default     = true
}

variable "enable_memory" {
  description = "Enable High Memory alert"
  type        = bool
  default     = false
}

############################
# PROVIDER
############################

provider "newrelic" {
  account_id = var.account_id
  api_key    = var.api_key
  region     = "US"
}

############################
# ALERT POLICY
############################

resource "newrelic_alert_policy" "test_policy" {
  name = "Jenkins Test Policy"
}

############################
# CPU ALERT CONDITION
############################

resource "newrelic_nrql_alert_condition" "high_cpu_test" {
  count = var.enable_high_cpu ? 1 : 0

  policy_id = newrelic_alert_policy.test_policy.id
  name      = "High CPU Test Alert"

  type = "static"

  nrql {
    query = "SELECT average(cpuPercent) FROM SystemSample"
  }

  critical {
    operator              = "above"
    threshold             = 1
    threshold_duration    = 60
    threshold_occurrences = "ALL"
  }
}

############################
# MEMORY ALERT CONDITION
############################

resource "newrelic_nrql_alert_condition" "memory_test" {
  count = var.enable_memory ? 1 : 0

  policy_id = newrelic_alert_policy.test_policy.id
  name      = "High Memory Test Alert"

  type = "static"

  nrql {
    query = "SELECT average(memoryUsedPercent) FROM SystemSample"
  }

  critical {
    operator              = "above"
    threshold             = 1
    threshold_duration    = 60
    threshold_occurrences = "ALL"
  }
}
