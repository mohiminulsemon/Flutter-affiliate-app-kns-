import 'package:flutter/material.dart';
import 'package:knsbuy/models/user_profile_model.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile user;

  const UserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final statusColor = user.status.toUpperCase() == 'ACTIVE'
        ? Colors.green
        : Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1c1c3c),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Status Badge
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                user.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Profile Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileRow("Username", user.userName),
              _profileRow(
                "Full Name",
                "${user.firstName} ${user.lastName}".trim(),
              ),
              _profileRow("Email", user.email),
              _profileRow("Referral Code", user.referralCode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ", style: const TextStyle(color: Colors.white70)),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
