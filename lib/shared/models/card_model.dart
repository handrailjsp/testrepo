class CardModel {
  final String id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final String cardType; // VISA, MASTER, AMEX
  final String cardLabel; // Platinum, Gold, etc.
  final double balance;
  final bool isActive;
  final bool isFrozen;
  final double spendingLimit;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.cardLabel,
    required this.balance,
    this.isActive = true,
    this.isFrozen = false,
    this.spendingLimit = 0,
  });

  // Factory method to create a CardModel from JSON
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
      cardType: json['cardType'],
      cardLabel: json['cardLabel'],
      balance: json['balance'].toDouble(),
      isActive: json['isActive'] ?? true,
      isFrozen: json['isFrozen'] ?? false,
      spendingLimit: json['spendingLimit']?.toDouble() ?? 0,
    );
  }

  // Method to convert CardModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'cardType': cardType,
      'cardLabel': cardLabel,
      'balance': balance,
      'isActive': isActive,
      'isFrozen': isFrozen,
      'spendingLimit': spendingLimit,
    };
  }

  // Method to get masked card number
  String get maskedCardNumber {
    if (cardNumber.length < 16) return cardNumber;
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  // Method to get formatted balance
  String get formattedBalance {
    return '₱ ${balance.toStringAsFixed(2)}';
  }

  // Method to create a copy of CardModel with updated fields
  CardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolder,
    String? expiryDate,
    String? cvv,
    String? cardType,
    String? cardLabel,
    double? balance,
    bool? isActive,
    bool? isFrozen,
    double? spendingLimit,
  }) {
    return CardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
      cardLabel: cardLabel ?? this.cardLabel,
      balance: balance ?? this.balance,
      isActive: isActive ?? this.isActive,
      isFrozen: isFrozen ?? this.isFrozen,
      spendingLimit: spendingLimit ?? this.spendingLimit,
    );
  }
}