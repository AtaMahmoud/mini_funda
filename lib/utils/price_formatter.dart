import 'package:intl/intl.dart';

String priceFormatter(int price) => NumberFormat.currency(
      symbol: '€',
      decimalDigits: 0,
    ).format(price);
