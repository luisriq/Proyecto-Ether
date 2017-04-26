set NODES_DIRECTORY=NODES_DATA
set nodo=%1
geth --rpc --rpcport "800%nodo%" --rpccorsdomain "*" --datadir "%NODES_DIRECTORY%/DATA%nodo%" --port "3030%nodo%" --ipcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcapi "db,eth,net,web3" --networkid 1326 --nat "any" console
