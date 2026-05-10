class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String experience;
  final int price;
  final String imagePath;
  final bool isLiked;

  const Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.price,
    required this.imagePath,
    required this.isLiked,
  });

  Doctor copyWith({
    String? name,
    String? specialty,
    double? rating,
    int? reviews,
    String? experience,
    int? price,
    String? imagePath,
    bool? isLiked,
  }) {
    return Doctor(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      experience: experience ?? this.experience,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
