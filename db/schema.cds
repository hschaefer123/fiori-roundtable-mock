namespace com.example;

entity SalesOrders {
  key orderId          : String(10)   @title: 'Order ID';
      customerName     : String(100)  @title: 'Customer';
      orderDate        : Date         @title: 'Order Date';
      netAmount        : Decimal(15,2) @title: 'Net Amount';
      status           : String(100)  @title: 'Status';
}
