resource "incapsula_incap_rule" "nel" {
    action        = "RULE_ACTION_RESPONSE_REWRITE_HEADER"
    add_missing   = true
    dc_id         = 0
    name          = "NEL_Header"
    rate_interval = 0
    response_code = 0
    rewrite_name  = "NEL"
    site_id       = var.site_id
    to            = jsonencode(
        {
            failure_fraction   = 1
            include_subdomains = true
            max_age            = 3600
            report_to          = "default"
            success_fraction   = 0.01
        }
    )
}

resource "incapsula_incap_rule" "nel_report_to" {
    action        = "RULE_ACTION_RESPONSE_REWRITE_HEADER"
    add_missing   = true
    dc_id         = 0
    name          = "Report_To_NEL_Header"
    rate_interval = 0
    response_code = 0
    rewrite_name  = "Report-To"
    site_id       = var.site_id
    to            = jsonencode(
        {
            endpoints          = [
                {
                    url = "https://5btd6su0lb.execute-api.us-east-1.amazonaws.com/Stage?asn=$asn&account=2398&city=$city&country=$country&postalcode=$postalcode&state=$state&epoch=$epoch&longitude=$longitude&latitude=$latitude&site=${var.site_id}"
                },
            ]
            group              = "default"
            include_subdomains = true
            max_age            = 3600
        }
    )
}
