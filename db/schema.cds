namespace SIIL.db;

using { managed, cuid, sap.common as SAP, User, temporal } from '@sap/cds/common';

@assert.range
type ShipmentStatus : String enum {
    notPrepared = '1';
    prepared = '2';
}

entity ShipmentStatuses : SAP.CodeList {
    key code : ShipmentStatus @( title : '{ i18n>Code }' );
}

entity AppUser : managed, temporal {
    key user : User;
}

entity Shipments : cuid, managed {
    fromPlant : String(4) not null;
    fromStorage : String(4) not null;
    toPlant : String(4);
    toStorage : String(4);
    plannedOn : Timestamp; //maybe 86400000
    startedOn : Timestamp;
    finishedOn : type of startedOn;
    status : ShipmentStatus; 
    itinerary : Association to one Itineraries;
    notes : array of String;
    virtual package_sum : Integer @readonly;
    items : Composition of many ShipmentItems on items.shipment = $self;
    issues : Composition of many ShipmentIssues;
}

entity Itineraries : cuid {
    forDate : Date @mandatory;
    shipments : Association to many Shipments on shipments.itinerary = $self;
}

entity ShipmentItems : managed {
    key shipment : Association to one Shipments;
    key ID : Integer;
    quantity : Decimal @mandatory;
    unitOfMeasure : Association to one UnitOfMeasures @mandatory; 
    material : Association to one Materials @mandatory;
}

aspect ShipmentIssues {
	key shipment : Association to Shipments;
    text : String @mandatory;
}

entity UnitOfMeasures : cuid, SAP.CodeList {//pasar a lectura de objeto de hana si existe (y si no existe crearlo)
}

entity Materials : cuid, SAP.CodeList {//pasar a lectura de objeto de hana si existe (y si no existe crearlo)
}

//crear aspecto de algo, probar tipos enum