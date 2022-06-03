using { SIIL.db as db } from '../db/schema';

service ManageShipments {

    entity Shipments 
        as projection on db.Shipments 
            annotate ID with @assert.notNull: false;

    entity ShipmentItems 
        as projection on db.ShipmentItems;

    entity ShipmentIssues 
        as projection on db.Shipments.issues;    

}

service ManageMaterials {

    entity Materials 
        as projection on db.Materials;    
        
}