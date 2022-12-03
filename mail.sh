#!/bin/bash

#Skrypt przesyłający maila z informacją o plikach które są starsze niż czas podany w parametrze
#Podawane są dwa parametry
#path ($1) - ścieżka w której mają zostać sprawdzone pliki
#time ($2) - jak stare pliki mają zostać zwrócone. Parametr podawany jest w dniach 
#Hasło jest przechowywane w osobnym pliku. Jest to wygenerowany kod dla aplikacji na mailu sender

smtp_server="smtps://smtp.gmail.com:465"
from_email="mat.janczura@gmail.com"
user_acc="mat.janczura@gmail.com"
user_pass=$(cat /home/ofey/secret/secret_mail)
path=$1
time=$2

mail_subject=$(echo Raport z serwera bazodanowego "$HOSTNAME")




send_email() {
  recipient="$1"


  result=$(curl --url $smtp_server --ssl-reqd \
  --mail-from $from_email \
  --mail-rcpt $recipient \
  --user $user_acc:$user_pass \
  -T <(echo -e "From: $from_email\nTo: $recipient\nSubject: $mail_subject\n\n $mail_template_text"))

  echo "email for user $recipient has been sent"
}

if [[ -d $path && $time -gt 0 ]]
then
mail_template_text=$(find $1 -mtime +$time | sed 's/\/root\/PoC\/test\///')
send_email "mati09091993@gmail.com"

else
	echo "Błąd, sprawdź poprawność ścieżki lub parametru"
	echo "Scieżka powinna wskazywać na folder. Podałeś: $path"
	echo "Paramert wskazuje na ilość dni, musi zostać podany i być większy od zera. Podałeś: $time"
fi