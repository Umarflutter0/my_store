import 'dart:developer';
import 'package:flutter/material.dart';

/// A class to define custom error types for the app.
class AppError implements Exception {
  final String message;
  final String? code;

  AppError({required this.message, this.code});

  @override
  String toString() => 'AppError(code: $code, message: $message)';
}

/// A utility class to handle and process errors globally.
class ErrorHandler {
  /// Logs the error details to the console for debugging.
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    log(
      error.toString(),
      name: 'ErrorHandler',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Maps known error types to user-friendly messages.
  static String getFriendlyErrorMessage(dynamic error) {
    if (error is AppError) {
      // Custom app-defined errors
      return error.message;
    } else if (error is NetworkError) {
      return 'Network error occurred. Please check your connection.';
    } else if (error is TimeoutError) {
      return 'The request timed out. Please try again later.';
    } else if (error is AuthenticationError) {
      return 'Authentication error. Please log in again.';
    } else {
      // Default fallback for unknown errors
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Displays an error dialog to the user.
  static void showErrorDialog(
      BuildContext context,
      dynamic error, {
        String? title = 'Error',
      }) {
    final message = getFriendlyErrorMessage(error);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// A generic wrapper to handle errors in any async function.
  static Future<void> handleAsync(
      Future<void> Function() function, {
        required BuildContext context,
        String? errorMessage,
      }) async {
    try {
      await function();
    } catch (error, stackTrace) {
      logError(error, stackTrace);
      if (context.mounted) {
        showErrorDialog(context, error, title: errorMessage);
      }
    }
  }

  /// A generic wrapper for synchronous error handling.
  static void handleSync(
      void Function() function, {
        required BuildContext context,
        String? errorMessage,
      }) {
    try {
      function();
    } catch (error, stackTrace) {
      logError(error, stackTrace);
      if (context.mounted) {
        showErrorDialog(context, error, title: errorMessage);
      }
    }
  }
}

class NetworkError extends AppError {
  NetworkError({String? message = 'A network error occurred.'})
      : super(message: message!);
}

class TimeoutError extends AppError {
  TimeoutError({String? message = 'The request timed out.'})
      : super(message: message!);
}

class AuthenticationError extends AppError {
  AuthenticationError({String? message = 'Authentication error.'})
      : super(message: message!);
}

class InvalidDataError extends AppError {
  InvalidDataError({String? message = 'Invalid Data error.'})
      : super(message: message!);
}
