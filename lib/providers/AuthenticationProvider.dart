import 'package:flutter/material.dart';
import '../services/ApiService.dart';

class AuthenticationProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  Future<void> signOut(BuildContext context) async {
    await _apiService.signOut();
    _isSignedIn = false;
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
  }

  void signIn() {
    _isSignedIn = true;
    notifyListeners();
  }
}