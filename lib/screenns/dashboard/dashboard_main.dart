import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knsbuy/routes/app_router.dart';
import 'package:knsbuy/screenns/dashboard/widgets/profile_card.dart';
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
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (user) => UserProfileCard(user: user),
              ),

              const SizedBox(height: 16),
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
}
