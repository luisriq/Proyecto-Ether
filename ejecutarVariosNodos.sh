NODES_DIRECTORY="NODES_DATA"

while [ "$1" != "" ]; do
    case $1 in
        -n | --nodos )           shift
                                nodos=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

pwd=$PWD

#Inicializacion de nodos
if [ ! -d "$NODES_DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir "$NODES_DIRECTORY";
fi

absolutePath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/"


for ((i=0;i<$nodos;i++))
do
	echo "Iniciando->$i" 
	
	echo $absolutePath " AND " $absolutePath$NODES_DIRECTORY"/DATA"
	if [ ! -d "$NODES_DIRECTORY/DATA$i" ]; then
  		# Control will enter here if $DIRECTORY doesn't exist.
  		mkdir "$NODES_DIRECTORY/DATA$i";
  		geth --rpc --rpcport "800$i" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$i" --port "3030$i" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" init "CustomGenesis.json"
	fi
	#continue
	case "$OSTYPE" in
	  solaris*) echo "SOLARIS" ;;
	  linux*)  echo "Linux" 
				x-terminal-emulator -e geth --rpc --rpcport "800$i" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$i" --port "3030$i" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" console
				;;
	  darwin*)  echo "MacOS"
				osascript -e 'tell application "Terminal" to activate' -e 'tell application "Terminal" to do script "geth --rpc --rpcport \"800'$i'\" --rpccorsdomain \"*\" --datadir \"'$absolutePath$NODES_DIRECTORY'/DATA'$i'\" --port \"3030'$i'\" --ipcapi \"admin,db,eth,debug,miner,net,shh,txpool,personal,web3\" --rpcapi \"db,eth,net,web3\" --networkid 1326 --nat \"any\" console" ' #"geth --rpc --rpcport "800$i" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$i" --port "3030$i" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" console" in selected tab of the front window'
				;;
	  bsd*)     echo "BSD" ;;
	  msys*)    echo "WINDOWS-> TODO" ;;
	  *)        echo "unknown: $OSTYPE" ;;
	esac
done

