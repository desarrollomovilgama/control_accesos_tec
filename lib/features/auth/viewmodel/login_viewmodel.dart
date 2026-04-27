/// @file    login_viewmodel.dart
/// @author  Jesús David Johnson Soto
/// @version 2.0
/// ViewModel de Login — GAMA MPF v1.0 · MVVM + Provider
/// Roles: guardia | jefe | empleado

import 'package:flutter/material.dart';

enum UserRole { guardia, anfitrion, empleado }

enum AuthStatus { idle, loading, success, error }

class LoginViewModel extends ChangeNotifier {
  String     _username  = '';
  String     _password  = '';
  bool       _isLoading = false;
  String     _errorMsg  = '';
  AuthStatus _status    = AuthStatus.idle;

  String     get username  => _username;
  String     get password  => _password;
  bool       get isLoading => _isLoading;
  String     get errorMsg  => _errorMsg;
  AuthStatus get status    => _status;

  void setUsername(String v) { _username = v.trim(); _clearError(); }
  void setPassword(String v) { _password = v;        _clearError(); }

  void _clearError() {
    if (_errorMsg.isNotEmpty) { _errorMsg = ''; notifyListeners(); }
  }

  String? validateUsername(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Ingresa tu usuario' : null;

  String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Ingresa tu contraseña';
    if (v.length < 4) return 'Mínimo 4 caracteres';
    return null;
  }

  Future<void> login({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) async {
    if (!formKey.currentState!.validate()) return;
    _setLoading(true);
    try {
      final role = await _authService(_username, _password);
      if (!context.mounted) return;
      if (role == null) { _setError('Usuario o contraseña incorrectos'); return; }
      _navigateByRole(role, context);
    } catch (_) {
      _setError('Error de conexión. Intenta de nuevo.');
    } finally {
      _setLoading(false);
    }
  }

  Future<UserRole?> _authService(String user, String pass) async {
    await Future.delayed(const Duration(seconds: 2));
    const demoMap = {
      'guardia' : UserRole.guardia,
      'jefe'    : UserRole.anfitrion,   // rol Jefe → ruta /home/anfitrion
      'empleado': UserRole.empleado,
    };
    return demoMap[user.toLowerCase()];
  }

  void _navigateByRole(UserRole role, BuildContext context) {
    const routes = {
      UserRole.guardia  : '/home/guardia',
      UserRole.anfitrion: '/home/anfitrion',
      UserRole.empleado : '/home/empleado',
    };
    Navigator.pushReplacementNamed(context, routes[role]!);
  }

  void _setLoading(bool v) {
    _isLoading = v;
    _status    = v ? AuthStatus.loading : AuthStatus.idle;
    notifyListeners();
  }

  void _setError(String msg) {
    _errorMsg = msg;
    _status   = AuthStatus.error;
    notifyListeners();
  }

  void reset() {
    _username = ''; _password = ''; _isLoading = false;
    _errorMsg = ''; _status = AuthStatus.idle;
    notifyListeners();
  }
}
