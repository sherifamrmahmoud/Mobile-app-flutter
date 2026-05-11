class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String clinicName;
  final String location;
  final double rating;
  final int reviews;
  final String experience;
  final int yearsOfExperience;
  final String patientsCount;
  final int price;
  final String imagePath;
  final String bio;
  final bool isLiked;
  final bool isOnline;
  final double distanceKm;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.price,
    required this.imagePath,
    this.clinicName = '',
    this.location = '',
    this.yearsOfExperience = 0,
    this.patientsCount = '0',
    this.bio = '',
    this.isLiked = false,
    this.isOnline = true,
    this.distanceKm = 0,
  });

  Doctor copyWith({
    String? id,
    String? name,
    String? specialty,
    String? clinicName,
    String? location,
    double? rating,
    int? reviews,
    String? experience,
    int? yearsOfExperience,
    String? patientsCount,
    int? price,
    String? imagePath,
    String? bio,
    bool? isLiked,
    bool? isOnline,
    double? distanceKm,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      clinicName: clinicName ?? this.clinicName,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      experience: experience ?? this.experience,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      patientsCount: patientsCount ?? this.patientsCount,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      bio: bio ?? this.bio,
      isLiked: isLiked ?? this.isLiked,
      isOnline: isOnline ?? this.isOnline,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }
}