pragma solidity ^0.4.24;

contract MemoContract {

  // contador de jugadas
  uint contadorjugadas = 0;
  

  //Dueño del contrato
  address owner;

  // Representa una jugada realizada
  struct Jugada {
      uint idjugada;
      uint fecha; // timestamp
      string nombre; // nombre de la persona
      string mail; // mail de la persona
      uint intentos; // cantidad de intentos en los que gano
      uint tiempo; // tiempo que demoró en terminar la partida
  }

  // Colección de jugadas  
  Jugada[] public jugadas;


  // map para direcciones activas para informar jugadas
  mapping( address => bool) public direcciones;



  //Constructor del contrato
  constructor() public {

    //Registrar el propietario y que quede habilitado para enviar jugadas
    owner = msg.sender;
    direcciones[owner] = true;

   
  }


 function updateDireccion ( address _direccion , bool _estado)  {
     // Solo el dueño puede habilitar o deshabilitar direcciones que pueden escribir la jugada
     require(msg.sender == owner);

     // Evitar que se quiera modificar el estado del owner
     require(_direccion != owner);

     direcciones[_direccion] = _estado;
 } 

  // Agregar una jugada
  function addJugada ( uint _fecha , string _nombre , string _mail , uint _intentos , uint _tiempo ) public {
      
      require(direcciones[msg.sender] );

      contadorjugadas = contadorjugadas + 1;
      
      jugadas.push (
            Jugada ({
                
                idjugada:contadorjugadas,
                fecha: _fecha,
                nombre:_nombre,
                mail: _mail,
                intentos: _intentos,
                tiempo: _tiempo
                
            }));
        }
    // Devolver todas las jugadas
    function fetchJugadas() constant public returns(uint[], uint[], bytes32[], bytes32[], uint[], uint[]) {
        



            
            
            uint[] memory _idjugadas = new uint[](contadorjugadas);
            uint[] memory _fechas = new uint[](contadorjugadas);
            bytes32[] memory _nombres = new bytes32[](contadorjugadas);
            bytes32[] memory _mails = new bytes32[](contadorjugadas);
            uint[] memory _intentos = new uint[](contadorjugadas);
            uint[] memory _tiempos = new uint[](contadorjugadas);

        
            for (uint8 i = 0; i < jugadas.length; i++) {

                
                 _idjugadas[i] = jugadas[i].idjugada;
                _fechas[i] = jugadas[i].fecha;
                _nombres[i] = stringToBytes32( jugadas[i].nombre );
                _mails[i] = stringToBytes32( jugadas[i].mail );
                _intentos[i] = jugadas[i].intentos;
                _tiempos[i] = jugadas[i].tiempo;
                
                
            }
            
            return ( _idjugadas, _fechas, _nombres, _mails, _intentos, _tiempos);
        
    }
    
    
    function stringToBytes32(string memory source)  returns (bytes32 result)  {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
}
    
}




