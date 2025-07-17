class PackageModel {
  final int id;
  final String name;
  final dynamic investAmount;
  final dynamic monthlyProfit;
  final int investmentUnits;
  final int duration;

  PackageModel({
    required this.id,
    required this.name,
    required this.investAmount,
    required this.monthlyProfit,
    required this.investmentUnits,
    required this.duration,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      name: json['name'],
      investAmount: json['investAmount'],
      monthlyProfit: json['monthlyProfit'],
      investmentUnits: json['investmentUnits'],
      duration: json['duration'],
    );
  }
}
