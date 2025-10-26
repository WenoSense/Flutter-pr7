import '../features/payments/models/payment.dart';

class PaymentRepository {
  static final List<Payment> payments = [];

  static void addPayment(Payment payment) {
    payments.add(payment);
  }

  static void deletePayment(String id) {
    payments.removeWhere((p) => p.id == id);
  }

  static void markAsPaid(String id) {
    final index = payments.indexWhere((p) => p.id == id);
    if (index != -1) {
      payments[index].nextDate = payments[index].updatedNextDate;
    }
  }
}
