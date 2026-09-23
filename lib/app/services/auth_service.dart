import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  static Future<void>? _googleInitialization;

  User? get currentUser => _client.auth.currentUser;

  Session? get currentSession => _client.auth.currentSession;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  bool get usesNativeGoogleSignIn =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<AuthResponse> register({
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse?> signInWithGoogle() async {
    if (usesNativeGoogleSignIn) {
      return _signInWithGoogleNative();
    }

    final redirectUrl = kIsWeb
        ? Uri.base.origin
        : 'com.example.kimiaxplore://login-callback';

    final launched = await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: redirectUrl,
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );

    if (!launched) {
      throw const AuthException('Tidak dapat membuka halaman login Google.');
    }

    return null;
  }

  Future<AuthResponse> _signInWithGoogleNative() async {
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']?.trim() ?? '';

    if (webClientId.isEmpty) {
      throw const AuthException(
        'GOOGLE_WEB_CLIENT_ID belum diatur di file .env.',
      );
    }

    final googleSignIn = GoogleSignIn.instance;

    _googleInitialization ??= googleSignIn.initialize(
      serverClientId: webClientId,
    );

    await _googleInitialization;

    final googleAccount = await googleSignIn.authenticate();

    final googleAuthentication = googleAccount.authentication;

    final idToken = googleAuthentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw const AuthException('Google tidak mengembalikan ID Token.');
    }

    final googleAuthorization = await googleAccount.authorizationClient
        .authorizationForScopes(['email', 'profile']);

    return _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuthorization?.accessToken,
    );
  }

  Future<void> logout() async {
    await _client.auth.signOut();

    if (usesNativeGoogleSignIn && _googleInitialization != null) {
      await _googleInitialization;
      await GoogleSignIn.instance.signOut();
    }
  }
}
