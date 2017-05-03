# Proyecto Ether

Guia de configuracion para la herramienta Geth.

# Instalación
  - Seguir los pasos oficiales según la plataforma a utilizar en [Guia de instalacion]
  - Alternativamente, se puede ejecutar el archivo install.sh el cual instala (por defecto) en la carpeta de usuario de Ubuntu:
    - Ethereum
    - Geth
    - Node.js

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

* ejecutarVariosNodos.sh: Inicializa el nodo con el bloque inicial respectivo y abrirá varias ventanas de terminal con el modo consola de geth
    - ```./ejecutarVariosNodos.sh -n NUMERO_DE_NODOS```
* ejecutarNodo.sh: Inicializa el nodo dado como parametro y mostrará el modo consola
    - ```./ejecutarNodo.sh -n NODO_A_INICIAR```

En caso de utilizar Vagrant o algún entorno donde no se tiene acceso directo a una aplicación de terminal, se recomienda utilizar el segundo script.
## Consola

Una vez inciada la consola de algún nodo es posible verificar el funcionamiento observando los datos del mismo:
```sh
> admin.nodeInfo
{
  enode: "enode://29fe884133ad4aec583468b949efc4d06e2cd00dfcfdc99f17c613abd4b0d7cc80f85460a78c72fdc6a3ad08e3a6e33271252095ad9504fe2e3c1f76e3fe083f@192.168.24.3:30300",
  id: "29fe884133ad4aec583468b949efc4d06e2cd00dfcfdc99f17c613abd4b0d7cc80f85460a78c72fdc6a3ad08e3a6e33271252095ad9504fe2e3c1f76e3fe083f",
  ip: "192.168.24.3",
  listenAddr: "[::]:30300",
  name: "Geth/v1.5.9-stable-a07539fb/darwin/go1.8",
  ports: {
    discovery: 30300,
    listener: 30300
  },
  protocols: {
    eth: {
      difficulty: 131072,
      genesis: "0x15ecb41043149b2259c148131a137e842401c93fc7818a23787dc4d2d4d3338b",
      head: "0x15ecb41043149b2259c148131a137e842401c93fc7818a23787dc4d2d4d3338b",
      network: 1326
    }
  }
}
```
Ya que la dificultad dada en el Genesis Block se ve reflejada en la configuracion del nodo, se puede decir que la ejecucion del script fue correcta.

## Comunicación entre nodos
Para que los nodos iniciados interactúen entre sí, es necesario que se descubran en la misma red. Para verificar los nodos pares se utiliza el comando:
```sh
> admin.peers
[]
```
Si no existen nodos agregados, se puede utlizar el siguiente comando con el **enode** del nodo a agregar:
```sh
> admin.addPeer("enode://c21ed538e264fc78c2dcfab3c0233b98645c51c00843a18d9ba820511a9ab9df9f6e77fb8b6f8db8ada507692dd95a48be5b536cd9e0ba8c216dbb405f701262@192.168.24.3:30301")
true
```
La conexión se establece de forma bidireccional con el nodo pero es necesario hacerlo entre los demás nodos 

Ejemplo: 
* Nodo A agrega a nodo B
* Nodo A agrega a nodo C
* Resultado: 
  * A se encuentra conectado con B y C
  * B se encuentra conectado con A
  * C se encuentra conectado con A
* B y C no se encuentran conectados entre ellos, es necesario realizar esa conexión aún

## Crear cuenta

Para poder minar Ether y realizar transacciones es necesario tener una cuenta asociada al nodo, cada nodo puede tener las cuentas que sean necesarias. Para crear una cuenta se puede utilizar cualquiera de los siguientes comandos:
```sh
> personal.newAccount("password")
> personal.newAccount()
```
Con cualquiera de los dos es necesario entregar una contraseña para la cuenta. El resultado es el siguiente donde en la última linea se muestra el identificador de la cuenta creada:
```sh
I0326 22:40:42.756853 cmd/geth/main.go:286] New wallet appeared: keystore:///Users/luis/GitHub/Proyecto-Ether/NODES_DATA/DATA0/keystore/UTC--2017-03-27T01-40-41.450137871Z--1fba612f5ee926367abe000dcf635ed6cd6488f3, Locked
"0x1fba612f5ee926367abe000dcf635ed6cd6488f3"
```

## Minar Ether
Minar Ether agrega **wei** a la cuenta en el coinbase, para cambiar de cuenta se puede usar el siguiente comando, sin embargo por defecto la cuenta creada queda como etherbase:
```sh
> miner.setEtherbase("0x1fba612f5ee926367abe000dcf635ed6cd6488f3")
```
Las cuentas en el nodo pueden ser listadas usando:
```sh
> personal.listAccounts
["0x1fba612f5ee926367abe000dcf635ed6cd6488f3"]
```
Y finalmente para minar se utilizan los siguientes comandos:
```sh
> miner.start()
> miner.stop()
```
**Nota**: La primera vez que se mina, es necesario generar el [DAG], esto se hace automaticamente pero suele tomar un largo periodo de tiempo.

## Transacciones
Para realizar transacciones se utiliza el siguiente comando donde el valor a transferir está en la unidad **Wei**, por lo que se puede usar la función **toWei()** para convertir de Ether a Wei:
```sh
> eth.sendTransaction({from:eth.coinbase, to:"0xb214997679ca98f350c04b8890b74fe1e88c4eac", value: web3.toWei(1.5, "ether")})

I0326 23:13:27.433058 internal/ethapi/api.go:1143] Tx(0x563d01b502e0471895ae76ae98020a688bc84b8d567e87c4da4b45e74a1deeaa) to: 0xb214997679ca98f350c04b8890b74fe1e88c4eac
"0x563d01b502e0471895ae76ae98020a688bc84b8d567e87c4da4b45e74a1deeaa"
```
Sin embargo primero es necesario desbloquear la cuenta usando:
```sh
> personal.unlockAccount(eth.coinbase)
```
La duración del desbloqueo por defecto es de 300 segundos, luego de esto se vuelve a bloquear (por motivos de seguridad); esto puede ser molesto al realizar pruebas, por lo que alternativamente se puede utilizar el comando de la forma:
```sh
personal.unlockAccount(addr, pswd, duration)
```
Indicando para la cuenta una duración 0 mantendrá el desbloqueo por la sesión de geth.
Con la contraseña "1234" como ejemplo, este comando quedaría de la forma:
```sh
personal.unlockAccount(eth.coinbase, "1234", 0)
```
Cabe notar que los comandos en consola quedan en un historial por lo que no es seguro exponer la contraseña de esta forma.

**Nota**: Cuando se realiza una transacción esta no se ve reflejada inmediatamente si no hasta que alguien mine, ya que es en este proceso donde se agrega un nuevo bloque al BlockChain.

Para revisar el balance de la cuenta en un nodo se puede utilizar:
```sh
eth.getBalance(eth.coinbase).toNumber();
```
Esto obtiene la cantidad de Wei (la unidad más granular de moneda) en la cuenta, para verlo en Ether se usa:
```sh
web3.fromWei(eth.getBalance(eth.coinbase), "ether")
```
## JSON RPC API

Existe una API con la que es posible comuncarse con Geth, el puerto por defecto es el **800n** donde n es el indice del nodo con el que se quiere interactuar. Entonces el EndPoint de esta API sería
```
http://localhost:800n/
```
Para mas informacion acerca de la estructura de las peticiones y los metodos disponibles puede leer la documentacion de la [API JSON RPC] de Geth


# Contratos
Antes de comenzar a trabajar con contratos, hay que instalar un compilador. En este caso usaremos Solidity, para la instalacion deben seguir las instrucciones del OS respectivo. [Instrucciones de instalacion de Solidity]
Es posible verificar los compiladores disponibles con el comando.
``` js
> eth.getCompilers()
["Solidity"]
```
Para la creacion de un contrato es necesario seguir los siguientes pasos.
* Compilar el contrato
* Crear Contrato
* Instanciar Contrato
* Publicar contrato

## Compilar contrato
Para compilar se usa el comando:
```js
> var contratoCompilado = eth.compile.solidity("CODIGODECONTRATO")
```
***Nota**: Para compilar desde la terminal es necesario utilizar herramientas que quiten los saltos de linea y otros caracteres que puedan interferir con las entradas de la terminal usada. Ej: [TextFixer]*

## Crear contrato
Usando el comando:
```js
var contrato = eth.contract(contratoCompilado["<stdin>:greeter"].info.abiDefinition)
```
Donde *Greeter* corresponde a la clase del contrato que se quiere utilizar.

## Instanciar contrato
Para crear una instancia del contrato y poder interactuar con este se utiliza:
```js
> var contratoInstanciado = contrato.new("Saludo1", {from: eth.coinbase, data: contratoCompilado["<stdin>:greeter"].code, gas: 1000000})
```
Donde **"Saludo1"** es el primer argumento del constructor de ***Greeter***.  ***from*** es la cuenta con la que se quiere publicar el contrato, ***data*** es el codigo del contrato compilado y finalmente ***gas*** corresponde al limite de gas a usar por el contrato, para mas informacion sobre el funcionamiento de este ver en el siguiente link: [GAS].

*Nota: Si el ***gas*** no es sufiente para correr el contrato, nunca tendrá una direccion con la cual acceder a el ni será ejecutado en la red.*

*Nota 2: Una vez instanciado el contrato, este debe ser minado por lo que mientras nadie en la red miner el contrato no podrá ser utilizado.*

Para probar el contrato se puede correr la funcion ***greet()*** la que deberia devolver el saludo entregado en un principio.
```js
> contratoInstanciado.greet()
```

## Enviar transacciones al contrato
Para llamar a funciones del contrato que requieran cambios en el mismo, es necesario realizar una transacción por ejemplo:
```js
> contratoInstanciado.cambiar.sendTransaction("Nuevo Saludo", {from:eth.coinbase})
```
Una vez minada la transaccion, el cambio debería reflejarse en todos los nodos con el contrato instanciado.

## Obtener el contrato en otros nodos
Para obtener el contrato en un nuevo nodo se necesitan 2 elementos escenciales:
* ABI DEFINITION
* CODIGO


### Obtener ABI DEFINITION y Dirección

Desde el primer nodo donde se creó el contrato se puede obtener mediante cualquiera de los siguientes comandos:
```js
> contratoInstanciado.abi
> contratoCompilado["<stdin>:greeter"].info.abiDefinition
```
Lo que devuelve es un arreglo de diccionarios con la interfaz para hacer uso del contrato.

Es posible obtener la direccion mediante:
```js
> contratoInstanciado.address
"0x15a974b2208bff48ff21cb62fcc4c3ae8f0e5994"
```

Con esta direccion es posible usar:

```js
> var contratoN = eth.contract(contratoABI)
> var contratoInstanciado = contratoN.at("0x15a974b2208bff48ff21cb62fcc4c3ae8f0e5994")
```




[GAS]:<http://ethdocs.org/en/latest/contracts-and-transactions/account-types-gas-and-transactions.html#what-is-gas>
[TextFixer]:<http://www.textfixer.com/tools/remove-line-breaks.php>
[Instrucciones de instalacion de Solidity]:<http://solidity.readthedocs.io/en/develop/installing-solidity.html#binary-packages>
[Guia de instalacion]: <https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum>
[DAG]: <https://github.com/ethereum/wiki/wiki/Ethash-DAG>
[API JSON RPC]: <https://github.com/ethereum/wiki/wiki/JSON-RPC#json-rpc-methods>
