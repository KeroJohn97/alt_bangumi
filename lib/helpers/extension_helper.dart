extension StringExtension on String? {
  String? capitalizeFirst() {
    if (this == null) return null;
    if (this!.trim().isEmpty) return this;
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }
}
