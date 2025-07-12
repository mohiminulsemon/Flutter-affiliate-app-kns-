import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knsbuy/routes/app_router.dart';
import 'package:knsbuy/services/app_session.dart';
import 'package:knsbuy/screenns/profile/profile_provider.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0f0f2d),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c1c3c),
        title: Row(
          children: [
            Image.asset('assets/images/app_logo.png', height: 36),
            const SizedBox(width: 8),
            const Text('KNSbuy', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AppSession.clearToken(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (user) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileRow("Username", user.userName),
              _profileRow("Name", "${user.firstName} ${user.lastName}".trim()),
              _profileRow("Referral Code", user.referralCode),
              _profileRow("Status", user.status),
              const SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/animations/work_in_progress.json',
                      height: 200,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "We're almost ready!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.push(AppRouter.investment);
                      },
                      icon: const Icon(Icons.trending_up_rounded),
                      label: const Text("Invest Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
