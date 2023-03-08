String formatAddress(String? address,{int? startLength,int? endLength}) {
  if (address == null || address.isEmpty) return '';
  if (address.length < 10) return address;
  return address.replaceRange(startLength??5, address.length - (endLength??4), '...');
}

String removeZero(String value) {
  if (value.contains('.')) {
    value = value.replaceAll(RegExp(r"0+?$"), ""); //去掉后面无用的零
    value = value.replaceAll(RegExp(r"[.]$"), ""); //如小数点后面全是零则去掉小数点
  }
  return value;
}