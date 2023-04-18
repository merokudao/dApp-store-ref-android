class AddressUtil {
  AddressUtil._();

  /// Address utility to show a clipper erc-20 address like 0xA1b2...C3d4e5
  static String getClippedAddress(String addr) {
    return "${addr.substring(0, 6)}...${addr.substring(addr.length - 6)}";
  }
}
