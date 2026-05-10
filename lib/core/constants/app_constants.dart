// lib/core/constants/app_constants.dart
// ✅ Constants only - no logger, no mutable state, no hardcoded URLs

// ✅ SharedPreferences Keys
class SharedPrefKeys {
  static const String userApiToken = 'user_api_token';
  static const String fcmToken = 'fcm_token';
  static const String langVisited = 'lang_visited';
  static const String userData = 'user_data'; // ✅ NEW
  static const String userThemeBlack = 'use_black_theme';
}

// ✅ API Endpoints (relative paths only - base URL comes from Environment)
class APIS {
  // Authentication
  static const String login = "Account/login";
  static const String register = "Account/register";
  static const String verifyRegister = "Account/confirm-email";
  static const String resendVerificationCode =
      "Account/resend-verification-code";
  static const String logout = "Account/logout";
  static const String forgetPassword = "Account/forgot-password";
  static const String resetPassword = "Account/reset-password";
  static const String googleLogin = "Account/google-login";
  static const String facebookLogin = "Account/facebook-login"; // ✅ Added
  static const String setFacebookEmail = "Account/set-facebook-email";
  static const String sessionVerify = 'Account/verify';
  static const String saveDeviceToken = "Account/save-device-token";
  static const String accountProfile = "Account/profile";

  // Exercises
  static const String exercisesCategories = 'Exercises/GetCategories';
  static const String exerciseVideos = 'Exercises/GetExercises';

  // Medication
  static const String homeDataAPI = "Medication/Home";
  static const String homeEducationAPI = "Medication/HomeEducations";
  static const String homeTakeDose = "Medication/TakeDose";
  static const String addMedication = "Medication/AddMedication";
  static const String getMedication = "Medication/GetMedications";
  static const String editMedication = "Medication/EditMedication";

  // Education
  static const String educationContent = "Education/GetEducations";

  // Diet
  static const String sendDietRequest = "Diet/RequestDietPlan";
  static const String getCurrentDiet = "Diet/GetDietPlan";
  static const String submitDietFeedback = "Diet/SubmitFeedback";

  // Gift Cards
  static const String giftCards = "GiftCards";
  static const String giftCardCoverImages = "GiftCards/cover-images";
  static const String sendGiftCard = "Cart/send-gift-card"; // ✅ Added
  // Home Gifts
  static const String homeRecivedGiftsAPI = '/Wallet/home-gifts';


  // Cart
  static const String getCart = "Cart";

  // Order
  static const String placeOrder = "Order/place-order";

  // gift card reminder
  static const giftCardReminderAPI = '/home/gift-card-reminder';

  // Wallet
  static const String walletReceived = "Wallet/received";
  static const String walletSent = "Wallet/sent";
  static const String walletDetails = "Wallet/wallet-details";
  static const String createBrandCard = "Wallet/create-brand-card";
  static const String archiveCard = "Wallet/archive-card";
  static const String markAsReadCard = "Wallet/mark-as-read-card";
  static const String cancelCard = "Wallet/cancel-card";
  static const String redeemCard = "Wallet/redeem-card";
  static const String remindCard = "Wallet/remind-card-recipient";

  // Notifications
  static const String notifications = "/Notifications";
}
