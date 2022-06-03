//using { cds } from './manageShipments';

annotate ManageShipments.Shipments 
    with @(
      restrict:[
        {
          grant: '*',
          to: 'any'
        }
        /*{ 
          grant: 'READ', 
          where: 'buyer = $user', 
          to: 'any' 
        },*/
      ]
    );