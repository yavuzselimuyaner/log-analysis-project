#!/bin/bash
LOG_FILE="/var/log/auth.log"

echo "--------------------------------------------------"
echo "   GÜVENLİK ANALİZİ: TÜM BAĞLANTI DENEMELERİ"
echo "--------------------------------------------------"
echo "Adet | IP Adresi"
echo "----------------"

# Hem 'Failed' hem de 'Connection reset' içerenleri yakalar
sudo grep -E "Failed|Connection reset" $LOG_FILE | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort | uniq -c | sort -rn

echo "--------------------------------------------------"
