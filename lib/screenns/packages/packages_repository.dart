import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/models/packages_model.dart';
import 'package:knsbuy/repositories/packages/packages_repository.dart';

final packagesProvider =
    StateNotifierProvider<PackagesNotifier, AsyncValue<List<PackageModel>>>(
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
