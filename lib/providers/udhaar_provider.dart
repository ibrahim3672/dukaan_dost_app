import 'package:flutter/foundation.dart';

import '../models/payment_model.dart';
import '../models/udhaar_model.dart';
import '../services/udhaar_service.dart';

class UdhaarProvider extends ChangeNotifier {
  UdhaarProvider(this._service);

  final UdhaarService _service;
  List<UdhaarModel> udhaar = [];
  List<PaymentModel> payments = [];
  bool isLoading = false;
  String? error;

  Future<void> loadUdhaar() async =>
      _run(() async => udhaar = await _service.fetchUdhaar());

  List<CustomerUdhaarSummary> get customerSummaries {
    final grouped = <int, CustomerUdhaarSummary>{};
    for (final item in udhaar.where((item) => item.hasRemaining)) {
      final customerId = item.customerId;
      if (customerId == null) continue;
      final existing = grouped[customerId];
      if (existing == null) {
        grouped[customerId] = CustomerUdhaarSummary(
          customerId: customerId,
          customerName: item.customerName ?? 'Customer #$customerId',
          customerPhone: item.customerPhone,
          remainingAmount: item.remainingBalance,
          records: [item],
        );
      } else {
        grouped[customerId] = existing.copyWith(
          remainingAmount: existing.remainingAmount + item.remainingBalance,
          records: [...existing.records, item],
          customerPhone: existing.customerPhone ?? item.customerPhone,
        );
      }
    }

    final summaries = grouped.values.toList()
      ..sort((a, b) => b.remainingAmount.compareTo(a.remainingAmount));
    return summaries;
  }

  double remainingForCustomer(int customerId) => udhaar
      .where((item) => item.customerId == customerId)
      .fold<double>(0, (sum, item) => sum + item.remainingBalance);

  List<UdhaarModel> recordsForCustomer(int customerId) =>
      udhaar.where((item) => item.customerId == customerId).toList()..sort(
        (a, b) => (b.date ?? b.createdAt ?? DateTime(0)).compareTo(
          a.date ?? a.createdAt ?? DateTime(0),
        ),
      );

  Future<bool> payCustomerUdhaar({
    required int customerId,
    required double amount,
  }) async {
    if (amount <= 0) return false;
    var remainingPayment = amount;
    var success = false;
    await _run(() async {
      final records =
          recordsForCustomer(
            customerId,
          ).where((item) => item.hasRemaining).toList()..sort(
            (a, b) => (a.date ?? a.createdAt ?? DateTime(0)).compareTo(
              b.date ?? b.createdAt ?? DateTime(0),
            ),
          );

      for (final record in records) {
        if (remainingPayment <= 0) break;
        final applied = remainingPayment > record.remainingBalance
            ? record.remainingBalance
            : remainingPayment;
        final payment = await _service.createPayment(
          PaymentModel(id: 0, udhaarId: record.id, amount: applied),
        );
        payments = [payment, ...payments];
        remainingPayment -= applied;
      }

      udhaar = await _service.fetchUdhaar();
      success = amount != remainingPayment;
    });
    return success;
  }

  Future<UdhaarModel?> fetchUdhaarById(int id) async {
    UdhaarModel? item;
    await _run(() async => item = await _service.fetchUdhaarById(id));
    return item;
  }

  Future<PaymentModel?> createPayment(PaymentModel payment) async {
    PaymentModel? created;
    await _run(() async {
      created = await _service.createPayment(payment);
      payments = [created!, ...payments];
      udhaar = await _service.fetchUdhaar();
    });
    return created;
  }

  Future<void> _run(Future<void> Function() action) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

class CustomerUdhaarSummary {
  const CustomerUdhaarSummary({
    required this.customerId,
    required this.customerName,
    required this.remainingAmount,
    required this.records,
    this.customerPhone,
  });

  final int customerId;
  final String customerName;
  final String? customerPhone;
  final double remainingAmount;
  final List<UdhaarModel> records;

  CustomerUdhaarSummary copyWith({
    String? customerPhone,
    double? remainingAmount,
    List<UdhaarModel>? records,
  }) {
    return CustomerUdhaarSummary(
      customerId: customerId,
      customerName: customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      records: records ?? this.records,
    );
  }
}
