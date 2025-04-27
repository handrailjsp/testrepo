import 'dart:async';
import '../models/user_model.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Mock user data - removed 'final' to allow updating
  UserModel _mockUser = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1 234 567 8901',
  );

  // Get current user
  Future<UserModel> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockUser;
  }

  // Update user profile
  Future<UserModel> updateUserProfile(UserModel user) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would send the updated user data to a server
    // For now, we'll just update our mock user
    _mockUser = user;

    return user;
  }
}
