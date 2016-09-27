/* Cette solution simple de traçabilité repose sur un contrat principal (Traceability)
et un contrat ad hoc par objet à tracer (Tracking).
Le contrat principal se comporte comme une liste blanche associant les identifiants
des objets et les contrats de traçabilité.
Une version plus avancée intègrera le déploiement du contrat Tracking à l'intérieur
de Traceability
*/


contract Traceabilityv1 {

    
    mapping ( address => bytes32) public TrackList;

/* Ce mapping associe une adresse à un identifiant (bytes32)  
Il est commode pour cet identifiant de le générer en hachant l'ensemble des 
informations importantes relatives via une fonction comme sha3-256. 
Par exemple pour l'objet à tracer:
"numéro de série: 0001; date de fabrication: 09082016;Lieu de fabrication: 75017PARIS"
sha3(00010908201675017PARIS)=
15905d14d04be568d5e263a664721065a484ffe9c94b474947d601468b2ea744
L'adresse à laquelle sera associée ce haché sera l'adresse de son contrat de traçabilité
*/

    address public Admin;
    
        modifier onlyAdmin() { 
        if (msg.sender != Admin) throw;
        _
    }

/* Ces lignes définissent l'administrateur du contrat, c'est-à-dire la
personne en charge du mapping TrackList. Le modifier permet de restreindre
l'accès à certaines fonctions.
*/


    event Trackchange(address TrackAddress, bytes32 identifier);

/*  cet event fait la publicité de l'attribution d'un identifiant à une adresse
de contrat de traçabilité
*/

    function TrackAdmin() {
        Admin = msg.sender;
    }
    
/* La fonction TrackList est le constructeur du contrat, elle s'exécute à la 
création du contrat et définie par défaut Admin comme étant l'adresse déployant
le contrat*/
    
    
    function Track(address TrackAddress, bytes32 identifier) onlyAdmin() {
        TrackList[TrackAddress] = identifier;
       Trackchange(TrackAddress, identifier);
    }
    
/* la fonction Track ne peut être appelée que par l'Admin, elle modifie le mapping
associant les identifiants à leur contrat de traçabilité et en fait la publicité.
Si le contrat associé à un identifiant devient caduque, par exemple en cas de
rupture, il est possible pour l'Admin d'associer à cette adresse caduque une 
alerte au format bytes32 et d'attribuer l'identifiant concerné à une nouvelle adresse */



    function changeAdmin(address _newAdmin) onlyAdmin()
   {
       Admin = _newAdmin;
   }

    
function kill() onlyAdmin() { 
  selfdestruct(Admin); }
    
/* La fonction changeAdmin permet comme son nom l'indique de changer l'Admin, 
tandis que la fonction kill permet de retirer le code de la blockchain quand
le contrat n'est plus utilisé*/
    }

    


*** Fin du contrat Traceability***
*** Début du contrat Tracking***

