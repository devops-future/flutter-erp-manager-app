import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Category {
  int id;
  String title;
  String image;

  Category(this.id, this.title, this.image);

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
  };
}

class AncalmoOrder {
  String order_no;
  String article;
  String provider;
  String applicant;
  String department = "Informatica";
  int state;

  AncalmoOrder(this.order_no, this.article, this.provider, this.applicant, this.state);

  factory AncalmoOrder.fromRawJson(String str) =>
      AncalmoOrder.fromJson(json.decode(str));

  AncalmoOrder.fromJson(Map<String, dynamic> json)
      : order_no = json['numero_orden'] == null ? '0' : json['numero_orden'],
        article = json['articulo'] == null ? '' : json['articulo'],
        provider = json['nombre'] == null ? '' : json['nombre'],
        applicant = json['solicitante'] == null ? '' : json['solicitante'],
        state = json['estado_orden'] == "PEN" ? 0 : json['estado_orden'] == "APR" ? 1 : 2;
}

class OrderItem {
  int item_no;
  String article;
  String medida;
  double price;
  int cantidad;

  OrderItem(this.item_no, this.article, this.medida, this.price, this.cantidad);

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  OrderItem.fromJson(Map<String, dynamic> json)
      : item_no = json['numero_item'] == null ? 0 : int.parse(json['numero_item']),
        article = json['descripcion_articulo'] == null ? '' : json['descripcion_articulo'],
        medida = json['codigo_medida'] == null ? '' : json['codigo_medida'],
        price = json['precio_unitario'] == null ? 0.0 : double.parse(json['precio_unitario']),
        cantidad = json['cantidad'] == null ? 0.0 : int.parse(json['cantidad']);

  Map<String, dynamic> toJson() => {
    "item_no": item_no == null ? null : item_no,
    "article": article == null ? null : article,
    "medida": medida == null ? null : medida,
    "price": price == null ? null : price,
    "cantidad": cantidad == null ? null : cantidad,
  };
}
