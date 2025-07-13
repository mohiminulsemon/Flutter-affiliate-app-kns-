import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/common/custom_snackbar.dart';
import 'package:knsbuy/models/packages_model.dart';
import 'package:knsbuy/models/user_package_model.dart';
import 'package:knsbuy/screenns/packages/packages_provider.dart';

class InvestmentPage extends ConsumerWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packagesAsync = ref.watch(packagesProvider);
    final userPackagesAsync = ref.watch(userPackagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Investment Packages')),
      backgroundColor: const Color(0xFF0f0f2d),
      body: packagesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (packages) {
          return userPackagesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text(err.toString())),
            data: (userPackages) {
              final selectedPackageIds = userPackages
                  .map((e) => e.packageId)
                  .toSet();

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: packages.length,
                itemBuilder: (_, index) {
                  final package = packages[index];
                  final isSelected = selectedPackageIds.contains(package.id);
                  final packageStatus = userPackages
                      .firstWhere(
                        (e) => e.packageId == package.id,
                        orElse: () => UserPackageModel(),
                      )
                      .status;

                  return PackageCard(
                    package: package,
                    isSelected: isSelected,
                    status: packageStatus,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class PackageCard extends ConsumerWidget {
  final PackageModel package;
  final bool isSelected;
  final String? status;
  const PackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    this.status,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF0f0f2d),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.greenAccent.withValues(alpha: 0.4)
                : Colors.green.withValues(alpha: 0.2),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/app_logo.png'),
          alignment: Alignment.centerRight,
          fit: BoxFit.contain,
          opacity: 0.05,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                package.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade300,
                ),
              ),
              Spacer(),
              if (status != null && isSelected)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: status!.toLowerCase() == 'active'
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          _infoRow(
            "Invest",
            "(6500 × ${package.investmentUnits}) =\n${package.investAmount} BDT",
          ),
          _infoRow(
            "Profit / month",
            "(${package.monthlyProfit} × ${package.investmentUnits}) =\n${package.monthlyProfit * package.investmentUnits} BDT",
          ),
          const SizedBox(height: 16),
          Text(
            "* Capital will be returned after ${package.duration} months",
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 16),
          if (!isSelected)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 25, 25, 61),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  try {
                    await ref
                        .read(packagesProvider.notifier)
                        .selectPackage(package.id);
                    if (context.mounted) {
                      CustomSnackbar.showSuccess(
                        context,
                        "${package.name} selected!",
                      );
                      ref.invalidate(userPackagesProvider);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      CustomSnackbar.showError(context, e.toString());
                    }
                  }
                },
                child: Text(
                  "SELECT PACKAGE",
                  style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            const Text(
              "✓ Already Selected",
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
