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
	geth --datadir "$NODES_DIRECTORY/DATA$nodo" --networkid 1326 init CustomGenesis.json
fi
#geth --identity "EYNODES$nodo" --rpc --rpcport "800$nodo" --rpccorsdomain "*" --datadir "$NODES_DIRECTORY/DATA$nodo" --port "3030$nodo" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" --exec "admin.nodeInfo.enode;exit" console
#TODO: Iniciar Bootnode y entregar enode e ip como argumento

geth --maxpeers=112 --maxpendpeers=112 --verbosity 3 --port "3030$nodo" --identity "EYNODES$nodo" --rpc --rpcport "800$nodo" --rpccorsdomain "*" --rpcapi "eth,web3,personal,admin" --datadir "$NODES_DIRECTORY/DATA$nodo" --networkid 1326 --nat "any" --bootnodes=enode://5987cf142983063d4c75224f807ff9284e6f0c5280128218a8d8204fcaf71f4fb35e1440c4b932a0ac4243f614a6014d11ad3c19e591da4d9450f846479ebb18@192.168.0.111:30301 console

