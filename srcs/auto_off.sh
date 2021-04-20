docker ps -a
echo Inserire ID container
read container
if docker stop $container
then
	./run_again.sh
fi
	echo Ci hai provato!
	exit