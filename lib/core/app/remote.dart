import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../logger/logger.dart';

abstract class RemoteCore {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();

  static FirebaseFirestore get database => _firestore;

  static Future<void> initializeFirebase() async => await Firebase.initializeApp();

  static Future<void> userAuthentication() async {
    final cridential = await _auth.signInAnonymously();
    if (cridential.user == null) {
      AppLogger.error('Unsucessful user authentication');
    } else {
      AppLogger.config('Sucessful user authentication, uid: ${cridential.user!.uid}');
    }
  }

  static Future<void> configureCrashlytics() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
    if (!kDebugMode) {
      await _crashlytics.setUserIdentifier((_auth.currentUser?.uid) ?? 'undefined');
      AppLogger.config('FirebaseCrashlytics enabled');
    }
  }

  static void logError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _crashlytics.log(message);
    _crashlytics.recordError(error, stackTrace);
  }

  static void analyticsLog({required String name, Map<String, dynamic>? parameters}) =>
      _analytics.logEvent(name: name, parameters: parameters);
}
