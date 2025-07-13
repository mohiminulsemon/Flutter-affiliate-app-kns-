class UserPackageModel {
  final int? id;
  final int? packageId;
  final String? status;
  final Package? package;

  UserPackageModel({this.id, this.packageId, this.status, this.package});

  factory UserPackageModel.fromJson(Map<String, dynamic> json) {
    return UserPackageModel(
      id: json['id'] as int?,
      packageId: json['packageId'] as int?,
      status: json['status'] as String?,
      package: json['package'] != null
          ? Package.fromJson(json['package'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'packageId': packageId,
    'status': status,
    'package': package?.toJson(),
  };
}

class Package {
  final String? name;
  final int? investAmount;

  Package({this.name, this.investAmount});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      name: json['name'] as String?,
      investAmount: json['investAmount'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'investAmount': investAmount};
}
