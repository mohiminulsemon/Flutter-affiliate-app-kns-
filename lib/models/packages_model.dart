class PackageModel {
  final int id;
  final String name;
  final double investAmount;
  final double monthlyProfit;
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
      investAmount: (json['investAmount'] as num).toDouble(),
      monthlyProfit: (json['monthlyProfit'] as num).toDouble(),
      investmentUnits: json['investmentUnits'],
      duration: json['duration'],
    );
  }
}
