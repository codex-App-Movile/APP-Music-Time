class Artist {
  final String id;
  final String fullName;
  final String description;
  final String image;
  final String groupMusician;

  Artist({
    required this.id,
    required this.fullName,
    required this.description,
    required this.image,
    required this.groupMusician,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'].toString(),
      fullName: json['fullName'],
      description: json['description'],
      image: json['image'],
      groupMusician: json['groupMusician'],
    );
  }
}