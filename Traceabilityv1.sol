contract Traceabilityv1 {

    
    mapping ( bytes32 => address) public TrackList;
    

/* Ce mapping associe un identifiant (bytes32) à une adresse. 
Il est commode pour cet identifiant de le générer en hachant l'ensemble des 
informations importantes relatives via une fonction comme sha3-256. 
Par exemple pour l'objet à tracer:
"numéro de série: 0001; date de fabrication: 09082016;Lieu de fabrication: 75017PARIS"
sha3(00010908201675017PARIS)=
15905d14d04be568d5e263a664721065a484ffe9c94b474947d601468b2ea744
L'adresse associée à ce haché sera l'adresse de son contrat de traçabilité
*/

/*    address public Admin;*/
    
    
    address Admin = 0xdedb49385ad5b94a16f236a6890cf9e0b1e30392 ;
    
        modifier onlyAdmin() { 
        if (msg.sender != Admin) throw;
        _
    }

/* Ces lignes définissent l'administrateur du contrat Tracklist, c'est-à-dire la
personne en charge du mapping TrackList
*/


    event Trackchange(bytes32 identifier, address TrackAddress);

/*  cet event fait la publicité de l'attribution d'un identifiant à une adresse
de contrat de traçabilité
*/

    /*function Traceabilityv1 () {
        Admin = 0xdedb49385ad5b94a16f236a6890cf9e0b1e30392;
    }*/
    
/* La fonction TrackList est le constructeur du contrat, elle s'exécute à la 
création du contrat et définie par défaut Admin comme étant l'adresse déployant
le contrat*/
    
    
    function Track( bytes32 identifier, address TrackAddress) onlyAdmin() {
        TrackList[identifier] = TrackAddress;
       Trackchange(identifier, TrackAddress);
    }
    
/* la fonction Track ne peut être appelée que par l'Admin, elle modifie le mapping
associant les identifiants à leur contrat de traçabilité et en fait la publicité.
Si le contrat associé à un identifiant devient caduque, par exemple du fait d'une 
rupture, il est possible pour l'Admin d'associer à cette adresse caduque une 
alerte au format bytes32 et d'attribuer une nouvelle adresse à l'identifiant
concerné */



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

