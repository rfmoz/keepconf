#!/bin/bash

# This script converts .csv files from Keepconf monitor to Prometheus textfile collector format.
# Add it to a cron schedule execution after keepconf run.

# Origin Keepconf path
dkeep='/var/tmp/keepconf/'

# Destination Prometheus file
dfile='/var/lib/prometheus/node-exporter/keepconf.prom'

# Init file
echo keepconf_enable 1 > $dfile

# Loop along all csv files
for fcsv in ${dkeep}*.csv; do

        # Replace underscore chars
        fbase=`basename -s '.csv' $fcsv | tr '-' '_'`

        (echo -n "keepconf_ok{file=\"$fbase\"} " && grep OK $fcsv | awk -F "\"*\"*" '{print $4}') >> $dfile
        (echo -n "keepconf_bad{file=\"$fbase\"} " && grep BAD $fcsv | awk -F "\"*\"*" '{print $4}') >> $dfile
        (echo -n "keepconf_fetch_time{file=\"$fbase\"} " && grep FETCH-T $fcsv | awk -F "\"*\"*" '{print $4}') >> $dfile
        (echo -n "keepconf_commit_time{file=\"$fbase\"} " && grep COMMIT-T $fcsv | awk -F "\"*\"*" '{print $4}') >> $dfile
        (echo -n "keepconf_total_time{file=\"$fbase\"} " && grep TOTAL-T $fcsv | awk -F "\"*\"*" '{print $4}') >> $dfile
done
