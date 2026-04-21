# Log Analiz Aracı

Bu basit Bash scripti, Linux sistemlerindeki `/var/log/auth.log` dosyasını inceleyerek güvenlik analizleri yapar.

## Özellikler
- Başarısız giriş denemelerini IP bazlı listeler.
- Brute-force saldırılarını tespit etmek için geçersiz kullanıcı adlarını raporlar.
- Başarılı girişleri (Accepted sessions) takip eder.
- Çıktıları hem terminale basar hem de `results.txt` dosyasına kaydeder.

## Kullanım
Scripti çalıştırmak için çalışma izni verin ve sudo yetkisiyle çalıştırın:

```bash
chmod +x log_analiz.sh
sudo ./log_analiz.sh
```

## Çıktı
Analiz sonuçları projenin ana dizinindeki `results.txt` dosyasında saklanır.
