
class Product {

  int? id;
  String? name;
  String? description;
  double? price;

  Product({this.id, this.name, this.description, this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price
    };
  }

  Product.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        age = doc.data()!["age"],
        salary = doc.data()!["salary"],
        address = Address.fromMap(doc.data()!["address"]),
        employeeTraits = doc.data()?["employeeTraits"] == null
            ? null
            : doc.data()?["employeeTraits"].cast<String>();

}