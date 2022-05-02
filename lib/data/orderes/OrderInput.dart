import 'OrderItemInput.dart';

class OrderInput{
late String  customerEmailPhone;
late String   customerFullName;
late String   customerAddress1;
late String   customerAddress2;
late String   customerCity;
late String   country;
late String   zipCode;
late List<OrderItemInput>  orderItems;

OrderInput({
 required     this.customerEmailPhone,
  required       this.customerFullName,
  required      this.customerAddress1,
  required     this.customerAddress2,
  required      this.customerCity,
  required      this.country,
  required    this.zipCode,
  required      this.orderItems});
}