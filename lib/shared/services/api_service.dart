import '../models/user_model.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    // Initialize with mock data
    _currentUser = UserModel(
      id: '1',
      name: 'M',
      email: 'john.doe@gmail.com',
      phone: 'Doe',
    );
  }

  // Mock data
  late UserModel _currentUser;

  Future<UserModel> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  Future<void> updateUser(UserModel user) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = user;
  }
}