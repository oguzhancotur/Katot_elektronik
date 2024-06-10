import 'dart:convert';

class StockTrackingModel {
  String? image;
  String title;
  String stockId;
  int quantity;
  String shelfNumber;
  String valueE;
  String voltage;
  String watt;
  String tolerans;
  String footPrint;
  String current;

  StockTrackingModel({
    required this.image,
    required this.title,
    required this.stockId,
    required this.quantity,
    required this.shelfNumber,
    required this.valueE,
    required this.voltage,
    required this.watt,
    required this.tolerans,
    required this.footPrint,
    required this.current,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'image': image});
    result.addAll({'title': title});
    result.addAll({'quantity': quantity});
    result.addAll({'shelfNumber': shelfNumber});
    result.addAll({'valueE': valueE});
    result.addAll({'voltage': voltage});
    result.addAll({'quantity': quantity});
    result.addAll({'watt': watt});
    result.addAll({'tolerans': tolerans});
    result.addAll({'footPrint': footPrint});
    result.addAll({'current': current});

    return result;
  }

  factory StockTrackingModel.fromMap(Map<String, dynamic> map, String? id) {
    return StockTrackingModel(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      stockId: id ?? '',
      quantity: map['quantity'] ?? 0,
      footPrint: map['footPrint'] ?? '',
      shelfNumber: map['shelfNumber'] ?? '',
      tolerans: map['tolerans'] ?? '',
      valueE: map['valueE'] ?? '',
      voltage: map['voltage'] ?? '',
      watt: map['watt'] ?? '',
      current: map['current'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StockTrackingModel.fromJson(String source) =>
      StockTrackingModel.fromMap(json.decode(source), null);
}
