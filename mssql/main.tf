##################
#    PROVIDER    #
##################

provider "datadog" {
  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}

##################
# DATADOG CHECKS #
##################

resource "datadog_monitor" "common_free_disk" {
  name    = "${var.application_owner} - ${var.application_name} - Common Cluster Disk Usage"
  type    = "metric alert"
  message = "${var.application_name} disk usage on {{device.name}} ({{host.name}}) is high. Notify: ${join(" ", var.notify)}"

  query = "avg(last_1h):system.disk.in_use{role:mssql-common} by {device,host} > 0.75"

  notify_no_data = false
  include_tags   = true
}
