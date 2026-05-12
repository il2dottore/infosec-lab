Turn on snort3:
sudo snort -c /usr/local/etc/snort/snort.lua -i ens33 -A alert_fast -l /var/log/snort -k none

Snort3 - Alert fast for Discord:
sudo snort -c /usr/local/etc/snort/snort.lua \
  -i ens33 \
  -A alert_fast \
  -l /var/log/snort \
  -k none

View local config:
sudo cat /usr/local/etc/snort/rules/local.rules

View global config:
sudo cat /usr/local/etc/snort/snort.lua