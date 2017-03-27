# Proyecto Ether

Guia de configuracion para la herramienta Geth.

# Instalación
  - Seguir los pasos oficiales según la plataforma a utilizar en [Guia de instalacion]

[Guia de instalacion]: <https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum>
# Configuracion

Para la inicializacion de cada nodo con geth y mantenerlos en una red privada, es necesario entregarle tres elementos escenciales:
  - Network id: entero positivo con el id de la red.
  - DataDir: Donde se guardan los datos para el nodo a ejecutar, debe ser distinto para cada uno.
  - Genesis block: Bloque inicial del BlockChain con ciertos parámetros iniciales
```
{
    "nonce": "0x0000000000000042",
    "timestamp": "0x0",
    "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "extraData": "0x0",
    "gasLimit": "0x8000000",
    "difficulty": "0x400",
    "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
    "coinbase": "0x3333333333333333333333333333333333333333",
    "alloc": {
    } 
}
```

## Scripts
Estos Scripts escritos en bash, facilitan la iniciacion y ejecucion de distintos nodos de forma local.

* inicializar.sh: Inicializa el nodo con el bloque inicial respectivo 
    - ./inicializar.sh -n NUMERO_DE_NODOS
