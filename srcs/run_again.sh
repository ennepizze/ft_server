echo Per favore inserisci Image ID
read img
if docker run --rm --env AUTOINDEX=off -p 8080:443 $img
then
	clear
	exit
fi
	echo Immagine non valida, ritenta.
	./run_again.sh