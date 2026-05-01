#!/bin/bash
# Script för att skapa användare och sätta upp katalogstruktur
# Skapad av Hugo
# Datum 2026-05-03

#Kontrollera att scriptet körs som root
if [ "$EUID" -ne 0 ]; then
	echo "Fel: Detta script måste köras som root!"
	exit 1
fi

# Loopa igenom alla argument och skapa användare
for anvandare in "$@"; do
	echo "Skapar användare: $anvandare"
	useradd -m "$anvandare"
	# Skapa mappar för användare
	 mkdir /home/$anvandare/Documents
	 mkdir /home/$anvandare/Downloads
	 mkdir /home/$anvandare/Work
	# Sätt rättigheter så bara ägaren kan läsa och skriva
	 chmod 700 /home/$anvandare
	 chmod 700 /home/$anvandare/Documents
	 chmod 700 /home/$anvandare/Downloads
	 chmod 700 /home/$anvandare/Work
	# Skapa welcome.txt med välkomstmeddelande
	 echo "Välkommen $anvandare" > /home/$anvandare/welcome.txt
	# Lägg till lista på befintliga användare
	 echo "Befintliga användare på systemet:" >> /home/$anvandare/welcome.txt
	 cut -d: -fi /etc/passwd >> /home/$anvandare/welcome.txt
done
