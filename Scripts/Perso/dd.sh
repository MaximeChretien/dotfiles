#!/usr/bin/env bash
i=0

textI="Disque Source : "
textO="Disque cible : "

while [ $i = 0 ]; do

	echo -e "Liste des disques :"
	lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL

	echo -e ""

	read -p "$textI" inputFile
	read -p "$textO" outputFile

	inputFile=${inputFile#"'"}
	inputFile=${inputFile%"'"}

	outputFile=${outputFile#"'"}
	outputFile=${outputFile%"'"}

	echo -e "\nVerification des données :"
	echo "$textI$inputFile"
	echo -e "$textO$outputFile\n"

	read -p "Ces données sont correctes ? [O/N] " verif

	if [ $verif = "o" ] || [ $verif = "O" ]; then

		echo -e ""
		read -p "Taille des échantillons [defaut : 4] : " bs

		if [ -z $bs ]; then
			bs="4"
		fi

		if [[ $inputFile == /dev/* ]]; then
			sudo umount "$inputFile"*
		fi

		if [[ $outputFile == /dev/* ]]; then
			sudo umount "$outputFile"*
		fi

		echo -e "\nCopie des fichiers : "

		sudo dd bs="$bs"M if="$inputFile" of="$outputFile" status=progress

		echo -e "\nFinalisation de la copie ..."

		sync

		i=1
	fi
echo
done

read -p "Appuyez sur Entrée pour quitter ..."

exit 0
