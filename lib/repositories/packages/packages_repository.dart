import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/constants/api_endpoints.dart';
import 'package:knsbuy/models/packages_model.dart';
import 'package:knsbuy/services/dio_client.dart';

final packagesRepositoryProvider = Provider<PackagesRepository>((ref) {
  final dio = ref.read(apiProvider);
  return PackagesRepository(dio);
});

class PackagesRepository {
  final DioClient dioClient;
  PackagesRepository(this.dioClient);

  Future<List<PackageModel>> fetchPackages() {
    return dioClient.get<List<PackageModel>>(
      ApiEndpoints.packages,
      fromData: (json) => (json as List)
          .map((e) => PackageModel.fromJson(e))
          .toList(),
    );
  }

  Future<void> selectPackage(int packageId) {
    return dioClient.post<void>(
      ApiEndpoints.selectPackage,
      data: {'packageId': packageId},
      fromData: (json) => json,
    );
  }
}
