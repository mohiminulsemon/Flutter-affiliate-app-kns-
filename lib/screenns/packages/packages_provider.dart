import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/models/packages_model.dart';
import 'package:knsbuy/models/user_package_model.dart';
import 'package:knsbuy/repositories/packages/packages_repository.dart';

final packagesProvider =
    StateNotifierProvider.autoDispose<PackagesNotifier, AsyncValue<List<PackageModel>>>(
      (ref) => PackagesNotifier(ref),
    );

class PackagesNotifier extends StateNotifier<AsyncValue<List<PackageModel>>> {
  final Ref ref;
  PackagesNotifier(this.ref) : super(const AsyncLoading()) {
    loadPackages();
  }

  Future<void> loadPackages() async {
    try {
      final repo = ref.read(packagesRepositoryProvider);
      final data = await repo.fetchPackages();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> selectPackage(int id) async {
    try {
      final repo = ref.read(packagesRepositoryProvider);
      await repo.selectPackage(id);
    } catch (e) {
      rethrow;
    }
  }
}

final userPackagesProvider =
    FutureProvider.autoDispose<List<UserPackageModel>>((ref) async {
  final repo = ref.read(packagesRepositoryProvider);
  return repo.fetchUserPackages();
});

