using { com.example as ns } from '../db/schema';

service SalesOrderService {
  entity SalesOrders as projection on ns.SalesOrders;
}
