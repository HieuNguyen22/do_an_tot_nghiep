class Service {
  final int? id;
  final String? name;
  final String? image;
  final String? video;
  final int? price;
  final int? position;
  final String? title;
  final String? description;
  final String? shortDescription;
  Service({
    this.id,
    this.name,
    this.image,
    this.video,
    this.price,
    this.position,
    this.title,
    this.description,
    this.shortDescription,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      video: json['video'],
      price: json['price'],
      position: json['position'],
      title: json['title'],
      description: json['description'],
      shortDescription: json['short_description'],
    );
  }
}
