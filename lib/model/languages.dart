class Languages {
  final int id;
  final int restaurantId;
  final int branchId;
  final String languageCode;
  final String name;
  final String icon;
  final bool isDelete;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  Languages(
      this.id,
      this.restaurantId,
      this.branchId,
      this.languageCode,
      this.name,
      this.icon,
      this.isDelete,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy);

  factory Languages.fromMap(Map<String, dynamic> data) {
    return Languages(
      data['id'],
      data['restaurantId'],
      data['branchId'],
      data['languageCode'],
      data['name'],
      data['icon'],
      data['isDelete'],
      data['createdAt'],
      data['updatedAt'],
      data['createdBy'],
      data['updatedBy'],
    );
  }
}
