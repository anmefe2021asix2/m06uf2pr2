#!/bin/bash
clear

if (( EUID != 0 ))
then
  echo "Aquest script ha de ser executat amb prilegis de root"
  exit 9 
fi

if (( $# != 1 )) # Això és un extra.
then
	echo "El programa no s'ha pogut executar!"
	echo "Has d'introduir un paràmetre correcte. On vols que es desin les còpies de seguretat?"
	exit 2
fi
echo "S'està creant la còpia de seguretat de: resolv.conf"

if [[ ! -d /root/$1 ]]
then
	echo -n "Aquest subdirectori no existeix. El vols crear (y/n)?: "
	read opc
	if [[ $opc != "y" ]] && [[ $opc != "Y" ]]
	then
		echo "No s'ha creat el subdirectori"
		exit 1
	else
		mkdir /root/$1
	fi
fi

nom_backup=/root/$1/resolv.conf.backup.$(date +"%Y%m%d%H%M")
cp /etc/resolv.conf $nom_backup 
gzip $nom_backup
if [[ -e $nom_backup ]]; then rm $nom_backup; fi

exit 0
