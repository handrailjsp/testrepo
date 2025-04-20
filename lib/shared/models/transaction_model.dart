import 'package:flutter/material.dart';

enum TransactionType {
  expense,
  income,
  transfer,
  payment,
}

class TransactionModel {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;
  final String cardId;
  final IconData icon;

  TransactionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    required this.cardId,
    required this.icon,
  });

  // Factory method to create a TransactionModel from JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      type: TransactionType.values.firstWhere(
            (e) => e.toString() == 'TransactionType.${json['type']}',
      ),
      category: json['category'],
      cardId: json['cardId'],
      icon: IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      ),
    );
  }

  // Method to convert TransactionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'category': category,
      'cardId': cardId,
      'icon': icon.codePoint,
    };
  }

  // Method to get formatted amount
  String get formattedAmount {
    final prefix = type == TransactionType.expense || type == TransactionType.payment
        ? '- '
        : '+ ';
    return '$prefix₱ ${amount.toStringAsFixed(2)}';
  }

  // Method to get formatted date
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Method to get formatted time
  String get formattedTime {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Method to check if transaction is an expense
  bool get isExpense {
    return type == TransactionType.expense || type == TransactionType.payment;
  }

  // Method to create a copy of TransactionModel with updated fields
  TransactionModel copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    DateTime? date,
    TransactionType? type,
    String? category,
    String? cardId,
    IconData? icon,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      category: category ?? this.category,
      cardId: cardId ?? this.cardId,
      icon: icon ?? this.icon,
    );
  }
}