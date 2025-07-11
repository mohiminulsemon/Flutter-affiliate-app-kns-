import 'package:flutter/material.dart';

class InvestmentPlan {
  final String id;
  final String title;
  final String amount;
  final String revenue;
  final String details;

  InvestmentPlan({
    required this.id,
    required this.title,
    required this.amount,
    required this.revenue,
    required this.details,
  });
}

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final List<InvestmentPlan> _plans = [
    InvestmentPlan(
      id: '1',
      title: 'Starter Plan',
      amount: '6,500 BDT',
      revenue: '300 BDT / month',
      details: 'This plan is ideal for beginners...',
    ),
    InvestmentPlan(
      id: '2',
      title: 'Silver Plan',
      amount: '32,500 BDT',
      revenue: '1,600 BDT / month',
      details: 'A perfect choice for moderate investors...',
    ),
    InvestmentPlan(
      id: '3',
      title: 'Gold Plan',
      amount: '65,000 BDT',
      revenue: '3,300 BDT / month',
      details: 'Get better returns with the Gold Plan...',
    ),
    InvestmentPlan(
      id: '4',
      title: 'Platinum Plan',
      amount: '1,95,000 BDT',
      revenue: '10,200 BDT / month',
      details: 'Maximize your profits over a 1-year period...',
    ),
  ];

  String? _selectedPlanId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Investment Plan")),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  final plan = _plans[index];
                  final isSelected = plan.id == _selectedPlanId;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedPlanId = plan.id),
                    child: Card(
                      color: isSelected
                          ? Colors.teal.withValues(alpha: 0.2)
                          : Theme.of(context).cardColor,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: isSelected
                            ? const BorderSide(color: Colors.teal, width: 2)
                            : BorderSide.none,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Investment: ${plan.amount}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Monthly Revenue: ${plan.revenue}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _showDetailsDialog(plan),
                                child: const Text("View Details"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_selectedPlanId != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.teal.withValues(alpha: 0.2),
                ),
                child: Text(
                  "Selected Plan: ${_plans.firstWhere((p) => p.id == _selectedPlanId!).title}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _confirmInvestment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Confirm Investment",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _confirmInvestment() {
    final selected = _plans.firstWhere((p) => p.id == _selectedPlanId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Confirm Investment"),
        content: Text(
          "Are you sure you want to invest in:\n\n${selected.title} (${selected.amount})?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("✅ Investment Confirmed: ${selected.title}"),
                ),
              );
            },
            child: const Text("Confirm", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(InvestmentPlan plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(plan.title),
        content: Text(plan.details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }
}
