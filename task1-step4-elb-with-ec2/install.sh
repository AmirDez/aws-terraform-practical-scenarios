#!/bin/sh
apt-get update
apt-get install -y apache2
service start apache2
chkonfig apache2 on
echo "<html><body style=""text-align: center;""><h1>Hi BestSeller :)</h1><br><h4>Server HostName: `hostname`</h4><h6>AmirDez.me</h6></body></html>" > /var/www/index.html