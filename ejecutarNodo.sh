NODES_DIRECTORY="NODES_DATA"
while [ "$1" != "" ]; do
    case $1 in
        -n | --nodo )           shift
                                nodo=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ ! -d "$NODES_DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir "$NODES_DIRECTORY";
fi
if [ ! -d "$NODES_DIRECTORY/DATA$nodo" ]; then
	# Control will enter here if $DIRECTORY doesn't exist.
	mkdir "$NODES_DIRECTORY/DATA$nodo";
	geth --rpc --rpcport "800$nodo" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$nodo" --port "3030$nodo" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" init CustomGenesis.json
fi

geth --rpc --rpcport "800$nodo" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$nodo" --port "3030$nodo" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" console

