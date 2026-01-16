import 'package:intl/intl.dart';

String formatPrice(String amount) {
  amount = amount.replaceAll(',', '');
  double totalDouble = double.tryParse(amount) ?? 0.00;
  var formatter = NumberFormat("#,##0.00");
  return formatter.format(totalDouble);
}

String formatPrice1(dynamic price) {
  // 10.00 → 10
  // 10.05 → 10.05
  // 10.50 → 10.5
  // 10 → 10
  if (price == null) return '0';
  double value = double.tryParse(price.toString()) ?? 0;
  if (value % 1 == 0) {
    return value.toInt().toString();
  }
  return value.toString().replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
}


bool isWholePrice(dynamic price) {
  if (price == null) return true;

  double value = double.tryParse(price.toString()) ?? 0;
  return value % 1 == 0;
}
