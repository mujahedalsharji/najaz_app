/*
 * Najaz Mobile App
 * String Constants
 * 
 * This file contains all string constants used throughout the app.
 * These are localization keys that will be mapped to actual strings
 * in language files. Following Bagisto's string_constants.dart pattern.
 */

/// String Constants - All string keys for localization
///
/// These constants are used as keys in localization files.
/// Actual strings are stored in language JSON files.
class StringConstants {
  // ============================================================
  // APP GENERAL
  // ============================================================

  static const String appName = "appName";
  static const String welcome = "welcome";
  static const String welcomeToNajazPlatform = "welcomeToNajazPlatform";
  static const String welcomeDescription = "welcomeDescription";
  static const String ok = "ok";
  static const String cancel = "cancel";
  static const String save = "save";
  static const String delete = "delete";
  static const String edit = "edit";
  static const String close = "close";
  static const String back = "back";
  static const String next = "next";
  static const String done = "done";
  static const String confirm = "confirm";
  static const String yes = "yes";
  static const String no = "no";
  static const String exitAppTitle = "exitAppTitle";
  static const String exitAppMessage = "exitAppMessage";

  // ============================================================
  // AUTHENTICATION
  // ============================================================

  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String signOut = "signOut";
  static const String createAccount = "createAccount";
  static const String alreadyHaveAccount = "alreadyHaveAccount";
  static const String dontHaveAccount = "dontHaveAccount";
  static const String forgotPassword = "forgotPassword";
  static const String resetPassword = "resetPassword";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String email = "email";
  static const String phoneNumber = "phoneNumber";
  static const String fullName = "fullName";
  static const String firstName = "firstName";
  static const String middleName = "middleName";
  static const String lastName = "lastName";
  static const String gender = "gender";
  static const String genderLabel = "genderLabel";
  static const String genderRequired = "genderRequired";
  static const String genderHint = "genderHint";
  static const String male = "male";
  static const String female = "female";
  static const String dateOfBirth = "dateOfBirth";
  static const String dateOfBirthLabel = "dateOfBirthLabel";
  static const String dateOfBirthHint = "dateOfBirthHint";
  static const String citizenType = "citizenType";
  static const String citizenTypeLabel = "citizenTypeLabel";
  static const String otpCode = "otpCode";
  static const String enterOtp = "enterOtp";
  static const String resendOtp = "resendOtp";
  static const String verify = "verify";
  static const String rememberMe = "rememberMe";

  // ============================================================
  // VALIDATION MESSAGES
  // ============================================================

  static const String fieldRequired = "fieldRequired";
  static const String pleaseFillLabel = "pleaseFillLabel";
  static const String invalidEmail = "invalidEmail";
  static const String validEmailLabel = "validEmailLabel";
  static const String enterValidEmail = "enterValidEmail";
  static const String invalidPhone = "invalidPhone";
  static const String validPhoneNumberLabel = "validPhoneNumberLabel";
  static const String invalidPassword = "invalidPassword";
  static const String passwordTooShort = "passwordTooShort";
  static const String passwordMismatch = "passwordMismatch";
  static const String passwordsDoNotMatch = "passwordsDoNotMatch";
  static const String invalidOtp = "invalidOtp";
  static const String phoneAlreadyUsed = "phoneAlreadyUsed";
  static const String phoneNotRegistered = "phoneNotRegistered";
  static const String pleaseFillAllFields = "pleaseFillAllFields";
  static const String passwordLabel = "passwordLabel";
  static const String confirmPasswordLabel = "confirmPassword";
  static const String phoneNumberLabel = "phoneNumberLabel";
  static const String signInEmailLabel = "signInEmailLabel";
  static const String nationalIdLabel = "nationalIdLabel";
  static const String emailOrNationalIdLabel = "emailOrNationalIdLabel";
  static const String invalidNationalId = "invalidNationalId";
  static const String invalidEmailOrNationalId = "invalidEmailOrNationalId";
  static const String minLengthLabel = "minLengthLabel";
  static const String maxLengthLabel = "maxLengthLabel";
  static const String passwordMinLength = "passwordMinLength";

  // ============================================================
  // HOME & SERVICES
  // ============================================================

  static const String home = "home";
  static const String services = "services";
  static const String serviceDetails = "serviceDetails";
  static const String viewAll = "viewAll";
  static const String search = "search";
  static const String searchHint = "searchHint";
  static const String searchServices = "searchServices";
  static const String searchServiceHint = "searchServiceHint";
  static const String categories = "categories";
  static const String currentRequests = "currentRequests";
  static const String noCurrentRequests = "noCurrentRequests";
  static const String requestNumber = "requestNumber";
  static const String requestCreatedAt = "requestCreatedAt";
  static const String featuredServices = "featuredServices";
  static const String popularServices = "popularServices";
  static const String newServices = "newServices";
  static const String all = "all";
  static const String noServicesFound = "noServicesFound";

  // ============================================================
  // BOOKINGS & HISTORY
  // ============================================================

  static const String history = "history";
  static const String bookings = "bookings";
  static const String bookingDetails = "bookingDetails";
  static const String createBooking = "createBooking";
  static const String bookingDate = "bookingDate";
  static const String bookingTime = "bookingTime";
  static const String bookingStatus = "bookingStatus";
  static const String pending = "pending";
  static const String confirmed = "confirmed";
  static const String completed = "completed";
  static const String cancelled = "cancelled";
  static const String noBookings = "noBookings";

  // ============================================================
  // PROFILE & ACCOUNT
  // ============================================================

  static const String profile = "profile";
  static const String accountInfo = "accountInfo";
  static const String personalInfo = "personalInfo";
  static const String editProfile = "editProfile";
  static const String changePassword = "changePassword";
  static const String changeEmail = "changeEmail";
  static const String changePhone = "changePhone";
  static const String deleteAccount = "deleteAccount";
  static const String deleteAccountMessage = "deleteAccountMessage";
  static const String deactivateAccount = "deactivateAccount";
  static const String aboutApp = "aboutApp";
  static const String support = "support";
  static const String accountVerification = "accountVerification";
  static const String verified = "verified";
  static const String verifiedStatus = "verifiedStatus";
  static const String notVerified = "notVerified";
  static const String verifyAccountMessage = "verifyAccountMessage";
  static const String verifyNow = "verifyNow";
  static const String pendingVerification = "pendingVerification";
  static const String verificationFailed = "verificationFailed";
  static const String accountNotVerified = "accountNotVerified";
  static const String personalInfoDescription = "personalInfoDescription";
  static const String idCard = "idCard";
  static const String idCardDescription = "idCardDescription";
  static const String idCardFront = "idCardFront";
  static const String idCardBack = "idCardBack";
  static const String tapToUpload = "tapToUpload";
  static const String selectImageSource = "selectImageSource";
  static const String camera = "camera";
  static const String gallery = "gallery";
  static const String errorPickingImage = "errorPickingImage";
  static const String permissionRequired = "permissionRequired";
  static const String permissionDeniedMessage = "permissionDeniedMessage";
  static const String openSettings = "openSettings";
  static const String confirmDataUsage = "confirmDataUsage";
  static const String changesSaved = "changesSaved";
  static const String saveChanges = "saveChanges";
  static const String videoVerification = "videoVerification";
  static const String videoVerificationDescription = "videoVerificationDescription";
  static const String videoInstructions = "videoInstructions";
  static const String videoInstructionsContent = "videoInstructionsContent";
  static const String tapToRecordVideo = "tapToRecordVideo";
  static const String recordVideo = "recordVideo";
  static const String errorRecordingVideo = "errorRecordingVideo";
  static const String existingVideo = "existingVideo";
  static const String existingVideoWillReplace = "existingVideoWillReplace";
  static const String videoRecorded = "videoRecorded";
  static const String confirmation = "confirmation";
  static const String confirmationDescription = "confirmationDescription";
  static const String uploaded = "uploaded";
  static const String notUploaded = "notUploaded";
  static const String videoStatus = "videoStatus";
  static const String recorded = "recorded";
  static const String notRecorded = "notRecorded";
  static const String confirmVerificationInfo = "confirmVerificationInfo";
  static const String verificationSuccess = "verificationSuccess";
  static const String verificationSuccessMessage = "verificationSuccessMessage";
  static const String goToHome = "goToHome";
  static const String uploadingFiles = "uploadingFiles";
  static const String pleaseWaitProcessing = "pleaseWaitProcessing";
  static const String verificationStatusTitle = "verificationStatusTitle";
  static const String verificationUnderReview = "verificationUnderReview";
  static const String verificationApproved = "verificationApproved";
  static const String verificationRejected = "verificationRejected";
  static const String verificationStatusUndefined = "verificationStatusUndefined";
  static const String requestDate = "requestDate";
  static const String reviewDate = "reviewDate";
  static const String notesLabel = "notesLabel";
  static const String verificationApprovedMessage = "verificationApprovedMessage";
  static const String verificationRejectedMessage = "verificationRejectedMessage";
  static const String verificationPendingMessage = "verificationPendingMessage";
  static const String editRequest = "editRequest";

  // ============================================================
  // SETTINGS
  // ============================================================

  static const String settings = "settings";
  static const String language = "language";
  static const String notifications = "notifications";
  static const String privacyPolicy = "privacyPolicy";
  static const String termsAndConditions = "termsAndConditions";
  static const String iAgree = "iAgree";
  static const String pleaseAcceptAgreement = "pleaseAcceptAgreement";
  static const String aboutUs = "aboutUs";
  static const String contactUs = "contactUs";
  static const String help = "help";
  static const String faq = "faq";
  static const String lastUpdated = "lastUpdated";
  static const String privacyPolicyContent = "privacyPolicyContent";
  static const String informationWeCollect = "informationWeCollect";
  static const String informationWeCollectContent = "informationWeCollectContent";
  static const String howWeUseYourInformation = "howWeUseYourInformation";
  static const String howWeUseYourInformationContent =
      "howWeUseYourInformationContent";
  static const String informationSharing = "informationSharing";
  static const String informationSharingContent = "informationSharingContent";
  static const String dataSecurity = "dataSecurity";
  static const String dataSecurityContent = "dataSecurityContent";
  static const String yourRights = "yourRights";
  static const String yourRightsContent = "yourRightsContent";
  static const String contactUsContent = "contactUsContent";

  // ============================================================
  // MESSAGES & ERRORS
  // ============================================================

  static const String success = "success";
  static const String error = "error";
  static const String warning = "warning";
  static const String info = "info";
  static const String noInternet = "noInternet";
  static const String somethingWentWrong = "somethingWentWrong";
  static const String tryAgain = "tryAgain";
  static const String loading = "loading";
  static const String processing = "processing";
  static const String processWaitingMsg = "processWaitingMsg";

  // ============================================================
  // DATE & TIME
  // ============================================================

  static const String date = "date";
  static const String time = "time";
  static const String today = "today";
  static const String tomorrow = "tomorrow";
  static const String yesterday = "yesterday";
  static const String selectDate = "selectDate";
  static const String selectTime = "selectTime";

  // ============================================================
  // COMMON ACTIONS
  // ============================================================

  static const String submit = "submit";
  static const String continue_ = "continue";
  static const String skip = "skip";
  static const String retry = "retry";
  static const String refresh = "refresh";
  static const String filter = "filter";
  static const String sort = "sort";
  static const String clear = "clear";
  static const String apply = "apply";
  static const String reset = "reset";

  // ============================================================
  // EMPTY STATES
  // ============================================================

  static const String noData = "noData";
  static const String noResults = "noResults";
  static const String emptyServices = "emptyServices";
  static const String emptyBookings = "emptyBookings";
  static const String emptyNotifications = "emptyNotifications";
}
