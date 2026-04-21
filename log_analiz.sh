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
#!/bin/bash

LOG_FILE="/var/log/auth.log"
OUTPUT_FILE="results.txt"

# Yetki kontrolü
if [ ! -r "$LOG_FILE" ]; then
    echo "Hata: $LOG_FILE okunabilir değil. Lütfen sudo ile çalıştırın."
    exit 1
fi

{
    echo "=================================================="
    echo "       GÜVENLİK ANALİZ RAPORU - $(date)"
    echo "=================================================="

    echo -e "\n[1] EN ÇOK BAŞARISIZ GİRİŞ DENEMESİ YAPAN IP'LER"
    echo "--------------------------------------------------"
    echo "Adet | IP Adresi"
    sudo grep "Failed password" "$LOG_FILE" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort | uniq -c | sort -rn | head -n 10

    echo -e "\n[2] GEÇERSİZ KULLANICI ADI DENEMELERİ (Brute Force İzi)"
    echo "--------------------------------------------------"
    sudo grep "Invalid user" "$LOG_FILE" | awk '{print $NF}' | sort | uniq -c | sort -rn | head -n 10

    echo -e "\n[3] BAŞARILI GİRİŞLER (Sizin oturumlarınız olabilir)"
    echo "--------------------------------------------------"
    sudo grep "Accepted password" "$LOG_FILE" | awk '{print $1, $2, $3, "User:", $9, "IP:", $11}'

    echo -e "\n=================================================="
    echo "Rapor Tamamlandı."
} | tee "$OUTPUT_FILE"

echo -e "\nAnaliz tamamlandı. Sonuçlar '$OUTPUT_FILE' dosyasına kaydedildi."
