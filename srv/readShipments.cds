using { SIIL.db as db } from '../db/schema';

service ReadShipments {

    @readonly
    entity Shipments as projection on db.Shipments;

    @readonly
    entity ShipmentItems as projection on db.ShipmentItems;
    //    entity ShipmentIssues as projection on db.Shipments.issues; no se expone solo
}