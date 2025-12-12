import 'package:intl/intl.dart';

String formatPrice(String amount) {
  amount = amount.replaceAll(',', '');
  double totalDouble = double.tryParse(amount) ?? 0.00;
  var formatter = NumberFormat("#,##0.00");

  // Format the number and return it
  return formatter.format(totalDouble);
}