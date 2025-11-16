import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopora_e_commerce/model/user_data_model.dart';
import 'package:shopora_e_commerce/services/firestore_services.dart';
import 'package:shopora_e_commerce/utils/api_paths.dart';

abstract class AuthService {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  User? getCuurentUser();
  Future<bool> authenticateWithGoogle();
  Future<bool> authenticateWithFacebook();
  Future<UserDataModel> fetchUserData(String uid);
}

class AuthServiceImpl implements AuthService {
  final _fireBaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  final _facebookSignIn = FacebookAuth.instance;
  final _fireStoreServices = FirestoreServices.instance;
  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  @override
  Future<bool> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _fireBaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _fireBaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? getCuurentUser() {
    final user = _fireBaseAuth.currentUser;
    return user;
  }

  @override
  Future<void> signOut() async {
    await _facebookSignIn.logOut();
    await _googleSignIn.signOut();
    await _fireBaseAuth.signOut();
  }

  @override
  Future<bool> authenticateWithGoogle() async {
    // Initialize the Google Sign-In instance before using it
    await _googleSignIn.initialize();

    // Start the Google authentication process, requesting permission to access the user's email
    final GoogleSignInAccount account = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    // Retrieve (tokens) from the signed-in Google account
    final gAuth = account.authentication;

    // Get the authorization client used for managing OAuth scopes and tokens
    final authClient = _googleSignIn.authorizationClient;

    // Request authorization for specific scopes (in this case, access to the user's email)
    final authorization = await authClient.authorizationForScopes(['email']);

    // Create a Firebase credential using the Google access token and ID token
    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: gAuth.idToken,
    );

    // Use the created credential to sign in to Firebase Authentication
    final userCredential = await _fireBaseAuth.signInWithCredential(credential);

    // Check if the sign-in was successful (user is not null)
    if (userCredential.user != null) {
      return true; // Successfully signed in
    } else {
      return false; // Sign-in failed
    }
  }

  @override
  Future<bool> authenticateWithFacebook() async {
    final loginResult = await _facebookSignIn.login();
    if (loginResult.status == LoginStatus.failed) {
      return false;
    }
    final accessToken = loginResult.accessToken;
    if (accessToken == null) {
      return false;
    }
    final credential = FacebookAuthProvider.credential(accessToken.tokenString);
    final userCredential = await _fireBaseAuth.signInWithCredential(credential);

    if (userCredential.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserDataModel> fetchUserData(String uid) async =>
      await _fireStoreServices.getDocument<UserDataModel>(
        path: ApiPaths.user(uid),
        builder: (data, documentID) => UserDataModel.fromMap(data),
      );
}
