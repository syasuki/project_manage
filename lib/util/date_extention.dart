class DateExtention {
  static DateTime dateOnlyNow() {
    var now = DateTime.now();
    var dateOnly = DateTime(now.year, now.month, now.day);
    return dateOnly;
  }
}