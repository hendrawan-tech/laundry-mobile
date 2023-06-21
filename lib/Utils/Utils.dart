import 'package:intl/intl.dart';
import 'package:medic_petcare/Config/Network.dart';

bool isResultTokenExpired(
  String code,
  String message,
) {
  if (code == '10' && message.contains("Token kadaluarsa")) {
    return true;
  } else {
    return false;
  }
}

String formatPrice({
  String amount = "0",
  String awalan = "Rp",
}) {
  try {
    final oCcy = NumberFormat("#,##0", "id_ID");
    if (awalan.isEmpty) {
      return oCcy.format(double.parse(amount));
    } else {
      return "$awalan ${oCcy.format(double.parse(amount))}";
    }
  } catch (e) {
    return amount;
  }
}

String getPhotoUrl(String photo) {
  try {
    if (photo == "") {
      return "https://t4.ftcdn.net/jpg/01/86/29/31/360_F_186293166_P4yk3uXQBDapbDFlR17ivpM6B1ux0fHG.jpg";
    } else {
      return "${Network().baseUrl}/storage/$photo";
    }
  } catch (e) {
    return photo;
  }
}

String formatDateTimeInput(tgl) {
  try {
    DateTime dateTime = DateTime.parse(tgl);
    var formatter = DateFormat('dd MMMM yyyy, HH:mm:ss', 'id_ID');
    return formatter.format(dateTime);
  } catch (e) {
    return tgl.toString();
  }
}

String formatDateInput(tgl) {
  try {
    DateTime dateTime = DateTime.parse(tgl);
    var formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    return formatter.format(dateTime);
  } catch (e) {
    return tgl.toString();
  }
}

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) {
    return word;
  }
  return word[0].toUpperCase() + word.substring(1);
}
