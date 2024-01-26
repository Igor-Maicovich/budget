extension IntExtension on int {
  /// Returns a new string with the first [length] characters of this string.
  String displayString() => this < 0 ? '$this\$' : '+$this\$';
}
