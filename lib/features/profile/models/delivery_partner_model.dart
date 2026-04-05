class DeliveryPartnerModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? profileImage;
  final String vehicleType;
  final String vehicleNumber;
  final bool isOnline;
  final bool isVerified;
  final double rating;
  final int totalDeliveries;
  final double totalEarnings;

  DeliveryPartnerModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.profileImage,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.isOnline,
    required this.isVerified,
    required this.rating,
    required this.totalDeliveries,
    required this.totalEarnings,
  });

  factory DeliveryPartnerModel.fromJson(Map<String, dynamic> json) {
    return DeliveryPartnerModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      profileImage: json['profileImage'],
      vehicleType: json['vehicleType'] ?? 'bike',
      vehicleNumber: json['vehicleNumber'] ?? '',
      isOnline: json['isOnline'] ?? false,
      isVerified: json['isVerified'] ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalDeliveries: json['totalDeliveries'] ?? 0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'profileImage': profileImage,
        'vehicleType': vehicleType,
        'vehicleNumber': vehicleNumber,
        'isOnline': isOnline,
        'isVerified': isVerified,
        'rating': rating,
        'totalDeliveries': totalDeliveries,
        'totalEarnings': totalEarnings,
      };

  DeliveryPartnerModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? profileImage,
    String? vehicleType,
    String? vehicleNumber,
    bool? isOnline,
    bool? isVerified,
    double? rating,
    int? totalDeliveries,
    double? totalEarnings,
  }) {
    return DeliveryPartnerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      isOnline: isOnline ?? this.isOnline,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      totalDeliveries: totalDeliveries ?? this.totalDeliveries,
      totalEarnings: totalEarnings ?? this.totalEarnings,
    );
  }
}

class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String joinedOn;
  final String? profileImage;
  final BankDetailsModel? bankDetails;
  const ProfileModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.location,
      required this.joinedOn,
      this.profileImage,
      this.bankDetails});
}

class BankDetailsModel {
  final String bankName;
  final String accountHolder;
  final String? logoAsset;
  const BankDetailsModel(
      {required this.bankName, required this.accountHolder, this.logoAsset});
}

class ProfileDummyData {
  ProfileDummyData._();
  static const profile = ProfileModel(
    name: 'Aswin Syam',
    email: 'aswinsyam824@gmail.com',
    phone: '+91 748 983 8993',
    location: 'Manjeri',
    joinedOn: '11-11-2025',
    bankDetails:
        BankDetailsModel(bankName: 'HDFC BANK', accountHolder: 'Akshar Kannur'),
  );
}
