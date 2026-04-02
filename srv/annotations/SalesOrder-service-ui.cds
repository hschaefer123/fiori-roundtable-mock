using { SalesOrderService } from '../SalesOrder-service';

annotate SalesOrderService.SalesOrders with @(
  UI.SelectionFields: [
    status,
    customerName,
    orderDate
  ],
);

annotate SalesOrderService.SalesOrders.status with @(
  Common.ValueList: {
    CollectionPath: 'SalesOrderStatuses',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: status,
        ValueListProperty: 'code'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      }
    ]
  }
);
