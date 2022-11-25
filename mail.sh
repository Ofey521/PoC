#!/bin/bash

#Skrypt przesyłający maila z informacją o plikach które są starsze niż czas podany w parametrze
#Podawane są dwa parametry
#path ($1) - ścieżka w której mają zostać sprawdzone pliki
#time ($2) - jak stare pliki mają zostać zwrócone. Parametr podawany jest w dniach 
#Hasło jest przechowywane w osobnym pliku. Jest to wygenerowany kod dla aplikacji na mailu sender

sender="mat.janczura@gmail.com"
receiver="mati09091993@gmail.com"
gapp=$(cat /home/ofey/secret/secret_mail)
sub=$(echo Raport z serwera bazodanowego "$HOSTNAME")
path=$1
time=$2

if [[ -d $path && $time -gt 0 ]]
then
body=$(find $1 -mtime +$time | sed 's/\/root\/PoC\/test\///')


curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
--mail-from $sender \
--mail-rcpt $receiver \
--user $sender:$gapp \
 -T <(echo -e "From:${sender} 
To:${receiver} 
Subject:${sub}

${body}")
else
	echo "Błąd, sprawdź poprawność ścieżki lub parametru"
	echo "Scieżka powinna wskazywać na folder. Podałeś: $path"
	echo "Paramert wskazuje na ilość dni, musi zostać podany i być większy od zera. Podałeś: $time"
fi
