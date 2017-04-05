set NODES_DIRECTORY=NODES_DATA
set nodo=%1
geth --datadir "%NODES_DIRECTORY%/DATA%nodo%" init CustomGenesis.json 
