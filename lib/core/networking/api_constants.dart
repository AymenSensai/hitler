class ApiConstants {
  // Base url
  static const String apiBaseUrl =
      "https://stocksbackend-production.up.railway.app/";

  // Auth end points.
  static const String login = "login";
  static const String register = "register";
  static const String googleSignIn = "google-sign-in";
  static const String forgotPassword = "forgot-password";
  static const String resetPassword = "reset-password";

  static const String products = "products";
  static const String categories = "categories";
  static const String contacts = "contacts";
  static const String orders = "orders";

  static const String dashboard = "dashboard-data";
}

class ApiErrors {
  static const String badRequestError = "Bad request. Please try again.";
  static const String noContent = "No content available.";
  static const String forbiddenError =
      "Access denied. You do not have permission.";
  static const String unauthorizedError = "Unauthorized access. Please log in.";
  static const String notFoundError = "Requested resource not found.";
  static const String conflictError = "Conflict occurred. Please try again.";
  static const String internalServerError =
      "Internal server error. Please try again later.";
  static const String unknownError =
      "An unknown error occurred. Please try again.";
  static const String timeoutError =
      "Request timed out. Please check your connection and try again.";
  static const String defaultError = "An error occurred. Please try again.";
  static const String cacheError = "Failed to load data from cache.";
  static const String noInternetError =
      "No internet connection. Please check your network and try again.";
  static const String loadingMessage = "Loading... Please wait.";
  static const String retryAgainMessage =
      "Something went wrong. Please try again.";
  static const String ok = "OK";
}
