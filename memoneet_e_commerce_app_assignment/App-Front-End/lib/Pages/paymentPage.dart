import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'card';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Payment Method',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            _buildPaymentOption('Credit/Debit Card', 'card'),
            const SizedBox(height: 10),
            _buildPaymentOption('UPI (Google Pay, PhonePe)', 'upi'),
            const SizedBox(height: 10),
            _buildPaymentOption('Cash on Delivery', 'cod'),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/success');
              },
              icon: const Icon(Icons.lock_outline),
              label: const Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String value) {
    final isSelected = _selectedMethod == value;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedMethod,
        onChanged: (val) => setState(() => _selectedMethod = val!),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primaryTextColor,
          ),
        ),
        activeColor: AppColors.primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
