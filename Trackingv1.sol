/* Cette solution simple de traçabilité repose sur un contrat principal (Traceability)
et un contrat supplémentaire par objet à tracer (Tracking).
Le contrat principal se comporte comme une liste blanche associant les identifiants
des objets et les contrats de traçabilité..
Une version plus avancée intègrera le déploiement du contrat Tracking à l'intérieur
de Traceability
*/

contract Trackingv1 {


    /*address public Owner;
    bytes32 public identifier;*/
    address Owner = 0xdedb49385ad5b94a16f236a6890cf9e0b1e30392 ;
    bytes32 identifier = 'azerty';
    
/* Ce contrat de traçabilité expose publiquement l'identifiant surveillé ainsi 
que le propriétaire actuel "Owner". D'autres informations peuvent être ajoutées
Notez que l'idenfier sera un bytes32 si produit par sha3-256 comme suggéré dans 
le contrat Traceability; nous utiliserons sha3-256(azerty)*/

    event Trackchange(address Owner);

/* Cet event fait la publicité du changement de propriétaire. On peut définir 
autant d'event qu'il y a d'information à tracer */

/*    function TrackId() {
        Owner = 0xdedb49385ad5b94a16f236a6890cf9e0b1e30392 ;
        identifier = 'azerty';
    }
*/
/* La fonction TrackId est le constructeur du contrat, elle s'exécute à la 
création du contrat et définie par défaut Owner comme étant l'adresse déployant
le contrat, elle définit également l'identifier comme les données (msg.data en 
bytes) ajoutées à la transaction de déploiement. Remarquez que le contrat peut
être déployé par n'importe qui et avec n'importe quel identifiant, l'authenticité
est subordonnée à l'association de l'adresse du contrat Tracking avec l'identifiant
dans le mapping de Traceability. Cette association ne peut être faite que par 
l'Admin du contrat Traceability.*/
    
        modifier onlyOwner() { 
        if (msg.sender != Owner) throw;
        _
    }


    function changeOwner(address _newOwner) onlyOwner()
   {
       Owner = _newOwner;
       Trackchange(Owner);
   }

/* La fonction changeOwner réalise la traçabilité du propriétaire "Owner" et en 
fait la publicité par l'even Trackchange.*/
   
    
function kill() onlyOwner() { 
  selfdestruct(Owner); }
 
      
/* La fonction changeOwner permet comme son nom l'indique de changer l'Owner, 
tandis que la fonction kill permet de retirer le code de la blockchain quand
le contrat n'est plus utilisé*/

    
}
