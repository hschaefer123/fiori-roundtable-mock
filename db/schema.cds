namespace com.example;

type SalesOrderStatus : String enum {
  Open;
  InProgress;
  Shipped;
  Delivered;
  Cancelled;
}

@cds.odata.valuelist
entity SalesOrderStatuses {
  key code : SalesOrderStatus;
      name : String @title: 'Status Name';
}

entity SalesOrders {
  key orderId          : String(10)    @title: 'Order ID';
      customerName     : String(100)   @title: 'Customer';
      orderDate        : Date          @title: 'Order Date';
      netAmount        : Decimal(15,2) @title: 'Net Amount';
      status           : SalesOrderStatus default 'Open'   @title: 'Status';
      items            : Composition of many SalesOrderItems on items.order = $self;
}

entity SalesOrderItems {
  key itemId      : String(5)         @title: 'Item Number';
  key order       : Association to SalesOrders;
      productName : String(100)       @title: 'Product';
      quantity    : Integer           @title: 'Quantity' @assert.range: [0, 10];
      unitPrice   : Decimal(15,2)     @title: 'Unit Price';
      lineTotal   : Decimal(15,2)     @title: 'Line Total';
}
