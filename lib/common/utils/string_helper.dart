String formatAddress(String? address) {
  if (address == null || address.isEmpty) return '';
  if (address.length < 10) return address;
  return address.replaceRange(5, address.length - 4, '...');
}