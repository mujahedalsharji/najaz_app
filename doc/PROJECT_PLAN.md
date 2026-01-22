# Najaz Mobile App - Project Plan

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture & Folder Structure](#architecture--folder-structure)
3. [Development Phases](#development-phases)
4. [Phase 1: Foundation & Infrastructure](#phase-1-foundation--infrastructure)
5. [Phase 2: Authentication Flow](#phase-2-authentication-flow)
6. [Phase 3: Core Features](#phase-3-core-features)
7. [Technical Stack](#technical-stack)
8. [Implementation Guidelines](#implementation-guidelines)
9. [Documentation Requirements](#documentation-requirements)

---

## Project Overview

### Purpose
Najaz Mobile App is a Flutter application built following the same infrastructure and architectural practices used in the Bagisto mobile app. The app will serve as a service-based platform with user authentication, service listings, and account management.

### Key Principles
- **Architecture Consistency**: Follow Bagisto's architecture patterns
- **Feature-Based Organization**: Each feature has its own folder with bloc, view, widget, utils
- **BLoC State Management**: Use flutter_bloc for all screens that require state management. Use StatefulWidget only when needed for simple UI animations or static screens without business logic
- **GraphQL Communication**: All backend communication via GraphQL
- **Centralized Theming**: All UI styles from theme files
- **Model-Driven UI**: Data models drive UI rendering
- **Single Responsibility**: Each class/widget has one clear purpose
- **Error Handling**: Follow Bagisto's error handling patterns (toast for API responses, inline for form validation, dialog for critical errors)

---

## Architecture & Folder Structure

### Folder Organization
```
lib/
├── models/              # Data models (equivalent to data_model in Bagisto)
│   ├── auth_models/
│   ├── user_models/
│   ├── service_models/
│   └── base_models/
│
├── screens/             # Feature-based screens
│   ├── splash/
│   │   ├── bloc/        # Events, States, Bloc, Repository
│   │   ├── view/        # Screen UI
│   │   ├── widget/      # Screen-specific widgets
│   │   └── utils/       # Screen utilities, validators
│   ├── welcome/
│   ├── sign_up/
│   ├── sign_in/
│   ├── home/
│   └── ...
│
├── services/            # GraphQL and API services
│   ├── graphql/
│   │   ├── client/      # GraphQL client configuration
│   │   ├── queries/     # GraphQL queries
│   │   ├── mutations/   # GraphQL mutations
│   │   └── fragments/   # GraphQL fragments
│   └── api_client.dart  # Main API client
│
├── utils/               # Cross-app utilities
│   ├── app_theme.dart
│   ├── app_colors.dart
│   ├── app_text_styles.dart
│   ├── app_spacing.dart
│   ├── app_radii.dart
│   ├── constants/
│   ├── shared_preferences/
│   ├── validators/
│   └── helpers/
│
└── widgets/             # Reusable UI components
    ├── buttons/
    ├── inputs/
    ├── cards/
    └── common/
```

---

## Development Phases

### Phase 1: Foundation & Infrastructure ⚙️
**Status**: Not Started  
**Duration**: ~3-5 days

#### 1.1 Project Structure Setup
- [x] Create folder structure (models, screens, services, utils, widgets)
- [x] Set up initial folder organization
- [x] Create placeholder .gitkeep files

#### 1.2 Dependencies & Configuration
- [x] Update `pubspec.yaml` with required dependencies:
  - State Management: `flutter_bloc`, `equatable`, `provider`
  - GraphQL: `graphql_flutter`, `http`
  - Local Storage: `get_storage`
  - JSON: `json_annotation`, `json_serializable`
  - UI: `lottie`, `google_fonts`, `cached_network_image`, `carousel_slider`
  - Utilities: `intl`, `url_launcher`, `share_plus`, `overlay_support`
- [x] Create `analysis_options.yaml` configuration
- [x] Set up build_runner for code generation
- [x] Create assets folder structure (images, fonts, lottie, language)
- [x] Run `flutter pub get` to install dependencies

#### 1.3 Theming System
- [x] **Create color structure** → `utils/app_colors.dart` ✅
- [x] **Extract colors from Figma SVG designs** → `utils/app_colors.dart` ✅
  - Primary color: #483A1E (brand brown/beige) - extracted from buttons/borders
  - Secondary color: #DFCA9F (light beige) - extracted from decorative backgrounds
  - Background: #FCFBF8 (cream) - main screen background
  - Text primary: #1D1B20 (dark) - main text color
  - Error: #DC3545 (red) - error states and borders
  - Success: #28A745 (green) - success indicators
  - Input colors: #E6E6E6 (background), #555555 (border default), #483A1E (focused), #DC3545 (error)
  - Button colors: #483A1E (primary), #FFFFFF (text on primary)
  - All UI colors extracted and organized by category
  - Note: Colors file is ready but may be refined later with brand guidelines
- [x] **Create typography system** → `utils/app_text_styles.dart` ✅
  - Font family: Using Google Fonts Cairo (Arabic-friendly) as placeholder until brand font provided
  - Font sizes: 32px (display), 28px (headline), 22px (title), 16px (label/body), 14px (body), 12px (caption), 10-11px (small)
  - Font weights: Normal, w600 (medium), Bold
  - Line heights: 1.2-1.5 (optimized for readability)
  - Text styles organized by usage: Display, Headline, Title, Label, Body, Caption
  - Special styles: Button, Input, Link, Error, Success, AppBar
  - Helper methods for theme-aware text styles
  - Note: SVG files don't contain explicit font data (text converted to paths), typography system created based on Material Design and common mobile patterns
- [x] Create `utils/app_theme.dart` (light theme implemented ✅, following Bagisto's pattern)
  - Light theme fully configured with all Material component themes
  - Uses extracted colors from app_colors.dart
  - Uses text styles from app_text_styles.dart
  - Structure prepared for future dark theme
- [x] Create `utils/theme_provider.dart` (following Bagisto's ThemeProvider pattern) ✅
  - ChangeNotifier-based theme state management
  - Currently defaults to light theme only
  - Structure prepared for future dark theme support
  - TODO: Integrate with SharedPreferenceHelper when created
- [x] Create `utils/app_spacing.dart` (following Bagisto's AppSizes pattern) ✅
  - Base spacing values: spacingSmall (4), spacingNormal (8), spacingMedium (12), spacingLarge (16), spacingWide (20)
  - Button height and width constants
  - Static screen dimensions (screenWidth, screenHeight, safeAreaPadding)
  - Helper methods for context-based dimensions
  - Simple approach: use MediaQuery.of(context) directly in widgets for responsive layouts
- [x] Create `utils/app_radii.dart` (border radius values from Figma) ✅
  - Extracted from Figma: button (16), input (7), card (18), dialog (22), badge (2), keyboard keys (6, 23)
  - Semantic values: standard (8), small (4), large (16)
- [ ] Create `utils/theme_provider.dart` for theme switching

#### 1.4 Constants & Configuration
- [x] Create `utils/constants/app_constants.dart` ✅
  - App name, version, package name
  - Default values (splash delay, language, currency)
  - Supported locales (Arabic primary, English secondary)
  - App configuration (password length, OTP length, phone number format)
  - Date/time formats, pagination, cache settings
- [x] Create `utils/constants/route_constants.dart` ✅
  - Authentication routes (splash, welcome, sign-up, sign-in, OTP, etc.)
  - Main app routes (home, services, history, profile)
  - Profile & account routes
  - Service & booking routes
  - Utility routes (search, notifications, settings)
  - Error routes
- [x] Create `utils/constants/string_constants.dart` ✅
  - App general strings
  - Authentication strings
  - Validation messages
  - Home & services strings
  - Bookings & history strings
  - Profile & account strings
  - Settings strings
  - Messages & errors
  - Empty states
  - All strings are localization-ready (keys for language files)
- [x] Create `utils/constants/assets_constants.dart` ✅
  - Lottie animation paths
  - Image asset paths
  - Font family constants
  - Language file paths
- [x] Create `utils/constants/server_configuration.dart` ✅
  - Base URL (fake URL: `https://api.najaz.example.com/graphql`)
  - API endpoints (GraphQL, REST)
  - Default headers configuration
  - Request/connection timeout settings
  - Authentication token keys
  - Pagination and cache configuration

#### 1.5 Shared Preferences Service
- [x] Create `utils/shared_preferences/shared_preference_keys.dart` ✅
  - Configuration keys (currency, theme)
  - Customer keys (token, login status, user data)
  - Onboarding & first launch keys
  - App state keys (date, sort, cookie)
  - Account verification keys (Najaz video verification)
  - Notification keys (FCM token, permission)
  - Cache keys (services, categories - Najaz specific)
  - **Note**: Tailored for Najaz (service-based), removed e-commerce features
- [x] Create `utils/shared_preferences/shared_preference_helper.dart` ✅
  - Token storage (customer token, refresh token)
  - User session flags (logged in status, customer ID)
  - Theme mode storage and retrieval
  - Language preference storage
  - Onboarding status tracking
  - User data caching (customer details, profile)
  - Account verification data storage (video verification)
  - Notification settings (FCM token, permission)
  - Cache management (services, categories)
  - Utility methods (logout, clear all data)
  - Uses GetStorage following Bagisto's pattern
  - **Note**: Tailored for Najaz service-based platform (no cart, orders, payments, reviews)

#### 1.6 GraphQL Infrastructure
- [x] Create `services/graphql_client.dart` ✅
  - GraphQL client setup with HTTP link
  - Auth link configuration (Bearer token injection)
  - Logger link for request/response logging
  - In-memory cache (can be upgraded to HiveStore later)
  - Headers configuration (locale, cookie, content-type)
  - Using real URL: https://najaz.rawnaqq.com/graphql
- [x] Create `services/api_client.dart` ✅
  - Generic query and mutate methods
  - Standardized response handler
  - Error parsing and conversion
  - Cookie management from response headers
  - Helper methods for error checking (network, authentication)
- [x] Create `services/graphql_queries/` folder structure ✅
- [x] Create `services/graphql_mutations/` folder structure ✅
- [x] Create base models in `models/base_models/` ✅
  - `graphql_base_model.dart` - Base model for all GraphQL responses
  - `graphql_base_error_model.dart` - Error model for error responses
  - Both models use json_serializable for JSON parsing
- ✅ All files follow Bagisto's GraphQL infrastructure pattern, tailored for Najaz (no currency headers, service-based)

#### 1.7 Navigation Setup
- [x] Create `utils/app_navigation.dart` ✅
- [x] Set up route generation ✅
- [x] Configure initial route logic ✅
  - Route generation for all app routes (auth, main, profile, services, utility, error)
  - Initial route logic based on first launch, onboarding, and authentication state
  - Navigation helper methods (navigateTo, navigateToReplacement, navigateAndRemoveUntil, pop, popWithResult, navigateToWithArgs)
  - Placeholder screens for routes not yet implemented

#### 1.8 Global Data & State
- [x] Create `utils/app_global_data.dart` ✅
  - Global state variables (locale, cookie, FCM token, device name)
  - Stream controllers (notification count, app state)
  - App-wide data caching structure (ready for services, categories, CMS data)
  - Helper methods (initialize, clear, dispose)
  - Tailored for Najaz service-based platform (no currency, cart, products)
  - TODO placeholders for models to be created in later phases

#### 1.9 Utility Files
- [x] Create `utils/input_field_validators.dart` ✅
  - Email, phone, password, and OTP validators (mixins)
  - Tailored for Najaz validation requirements
- [x] Create `utils/validators/form_validator_helper.dart` ✅
  - Centralized form validation helper for consistent validation across all forms
  - Methods: validateRequired, validateEmail, validatePhone, validatePassword, validatePasswordConfirmation, validateMinLength, validateMaxLength
  - Returns localized error messages or null if valid
  - Usage: `validator: (value) => FormValidatorHelper.validateEmail(value)`
- [x] Create `utils/helpers_extension.dart` ✅
  - HexColor extension (Color ↔ hex string conversion)
  - StringHelpers extension (capitalize, truncate, blank checks)
  - ContextHelpers extension (theme, media query helpers)
  - DateTimeHelpers extension (date formatting)
  - Helper functions (getValueFromDynamic)
- [x] Create `utils/helpers_dialog_helper.dart` ✅
  - Network error dialog
  - Confirmation dialog
  - Error dialog
  - Success dialog
  - Loading dialog
  - Close dialog helper
- [x] Create `utils/helpers_check_internet_connection.dart` ✅
  - checkInternetConnection() async function
  - checkInternetConnectionWithTimeout() function
  - getInternetConnectionChecker() singleton helper
  - Uses internet_connection_checker package
- [x] Create `utils/application_localization.dart` ✅
  - ApplicationLocalizations class
  - Localization delegate
  - String extension for .localized()
  - Loads language files from assets/language/
  - Supports Arabic and English locales

#### 1.10 Reusable Widgets Foundation
- [x] Create `widgets/common_app_bar.dart` ✅
  - Reusable app bar with customizable title, leading, and actions
  - Search and notification icon support (tailored for Najaz)
  - Tailored for Najaz service-based platform (no cart, compare features)
- [x] Create `widgets/common_widgets.dart` ✅
  - TextField builder with validation support
  - Button builder with customizable styling
  - Helper widgets (spacers, dividers, text)
  - Uses Najaz theming (colors, radii, spacing, text styles)
- [x] Create `widgets/loader.dart` ✅
  - Loading indicator with optional message
  - Centered display with customizable color
- [x] Create `widgets/error_message.dart` ✅
  - Error message display widget
  - Inline error message widget for forms
  - Uses Najaz error colors and text styles
- [x] Create `widgets/empty_state.dart` ✅
  - Empty state widget with Lottie animation
  - Customizable message and description
  - Supports action buttons
  - Uses Najaz theming and localization
- [x] Create `widgets/image_view.dart` ✅
  - Reusable network image widget with caching
  - Placeholder and error handling
  - Uses CachedNetworkImage for performance
  - Supports customizable size and fit
- [x] Create `widgets/show_message.dart` ✅
  - Toast-style notifications (success, error, warning, info, custom)
  - Uses overlay_support package
  - Localized messages using StringConstants
  - Uses Najaz colors and text styles

#### 1.11 Main App Setup
- [x] Update `lib/main.dart` ✅
  - MaterialApp configuration (theme, localization, routes)
  - Theme setup (light theme, dark theme placeholder)
  - Localization setup (Arabic and English support)
  - Provider setup (ThemeProvider)
  - Route configuration (uses AppNavigation.generateRoutes)
  - Initial route logic (uses AppNavigation.getInitialRoute)
  - RestartWidget for app restart capability
  - GlobalData initialization from shared preferences
  - GraphQL cache initialization
  - SystemChrome orientation preferences (portrait only)
  - HTTP overrides for development (self-signed certificates)

---

### Phase 2: Authentication Flow 🔐
**Status**: In Progress  
**Duration**: ~7-10 days  
**Prerequisites**: Phase 1 Complete

**Note**: Splash screen is handled by `flutter_native_splash` package, no separate splash screen implementation needed.

#### 2.1 Welcome/Onboarding Screen ✅
**UI Reference**: `Ui-Ux Screens/UIs svg/03- صفحة الترحيب.svg`

- [x] **BLoC Structure**: ✅
  - [x] `screens/welcome/bloc/welcome_event.dart` ✅
  - [x] `screens/welcome/bloc/welcome_state.dart` ✅
  - [x] `screens/welcome/bloc/welcome_bloc.dart` ✅
- [x] **View**: `screens/welcome/view/welcome_screen.dart` ✅
  - Column layout (not Stack) ✅
  - BLoC pattern with BlocProvider and BlocConsumer ✅
  - Separated into widget components:
    - `WelcomeScreen_TopSection` - Logo and app name (beige background) ✅
    - `WelcomeScreen_DescriptionSection` - Welcome description text ✅
    - `WelcomeScreen_ButtonsSection` - Sign In and Sign Up buttons ✅
  - App name localized (نجاز/Najaz) ✅
  - All strings properly localized ✅
  - Navigation handled through BLoC events ✅
- [x] **Routes**: Updated `app_navigation.dart` to use real welcome screen ✅
- [x] **Utils**: `screens/welcome/utils/index.dart` ✅

**Navigation Flow**:
- On "Sign Up" → Sign-up screen
- On "Sign In" → Sign-in screen
- Mark onboarding as completed in SharedPreferences when user proceeds


#### 2.3 Sign-Up Screen ✅
**UI References**: 
- `Ui-Ux Screens/UIs svg/01- صفحة إنشاء حساب.svg`
- `Ui-Ux Screens\UIs svg\01- صفحة إنشاء حساب\01- صفحة إنشاء حساب-1.svg`

- Error state: `Ui-Ux Screens\UIs svg\01- صفحة إنشاء حساب\رقم الهاتف مستخدم مسبقاً.svg`

- [x] **Model**: 
  - [x] `models/auth_models/sign_up_model.dart` (single model for sign-up, like Bagisto's SignInModel) ✅
  - Note: No separate request model - parameters passed directly in Event (follows Bagisto pattern)
- [x] **GraphQL**:
  - [x] `services/graphql_mutations/sign_up_mutation.dart` ✅
- [x] **BLoC Structure**:
  - [x] `screens/sign_up/bloc/sign_up_event.dart` ✅
  - [x] `screens/sign_up/bloc/sign_up_state.dart` ✅
  - [x] `screens/sign_up/bloc/sign_up_bloc.dart` ✅
  - [x] `screens/sign_up/bloc/sign_up_repository.dart` ✅
- [x] **View**: `screens/sign_up/view/sign_up_screen.dart` ✅
  - Form fields (firstName, middleName, lastName, gender, phone, nationalId, dateOfBirth, password, confirmPassword) ✅
  - Validation (using FormValidatorHelper) ✅
  - Error handling (inline for validation, toast for API errors) ✅
  - Loading states (inline loading indicator) ✅
  - Success → Navigate to Home screen (token and user data stored) ✅
- [x] **Widgets**: 
  - [x] `sign_up_body.dart` - Main form widget ✅
  - [x] `custom_app_bar.dart` - Custom app bar with Vector auth image ✅
  - [x] `sign_up__navigate_login_text.dart` - Login navigation widget ✅
- [x] **Utils**: 
  - [x] `screens/sign_up/utils/index.dart` ✅
- [x] **Integration**:
  - [x] Connect BLoC to GraphQL mutation (real backend: https://najaz.rawnaqq.com/graphql) ✅
  - [x] Handle response and errors ✅
  - [x] Store token and user data in SharedPreferences ✅
  - [x] CommonAppBar enhanced with optional image support ✅
  - [x] TextField backgrounds set to white for better visibility ✅

#### 2.3 Set Password Screen
**UI Reference**: `Ui-Ux Screens/Sign-up & Log-in/05- تعيين كلمة مرور جديدة.png`

- [ ] **Model**: 
  - [ ] `models/auth_models/set_password_model.dart` (single model for set password response, extends GraphQLBaseModel)
  - Note: No separate request model - parameters passed directly in Event (follows Bagisto pattern)
- [ ] **GraphQL**:
  - [ ] `services/graphql/mutations/set_password_mutation.dart`
- [ ] **BLoC Structure**:
  - [ ] `screens/set_password/bloc/set_password_event.dart`
  - [ ] `screens/set_password/bloc/set_password_state.dart`
  - [ ] `screens/set_password/bloc/set_password_bloc.dart`
  - [ ] `screens/set_password/bloc/set_password_repository.dart`
- [ ] **View**: `screens/set_password/view/set_password_screen.dart`
  - Password input field
  - Confirm password field
  - Password strength indicator
  - Show/hide password toggle
  - Validation
  - Success → Navigate to Sign-in or auto-login
- [ ] **Widgets**: 
  - [ ] Password input widget with strength indicator
- [ ] **Utils**: 
  - [ ] `screens/set_password/utils/index.dart`
  - [ ] Password validation rules

#### 2.4 Sign-In Screen ✅
**UI References**:
- `Ui-Ux Screens\UIs svg\03- صفحة تسجيل الدخول.svg`
- `Ui-Ux Screens\UIs svg\03- صفحة تسجيل الدخول-1.svg`

- [x] **Model**: 
  - [x] `models/auth_models/log_in_model.dart` (single model for sign-in response, like Bagisto's SignInModel) ✅
  - Note: No separate request model - parameters passed directly in Event (follows Bagisto pattern)
  - Reuses `CitizenData` from sign-up model ✅
- [x] **GraphQL**:
  - [x] `services/graphql_mutations/log_in_mutation.dart` ✅
  - Supports dual login (email OR nationalId) ✅
- [x] **BLoC Structure**:
  - [x] `screens/log_in/bloc/log_in_event.dart` ✅
  - [x] `screens/log_in/bloc/log_in_state.dart` ✅
  - [x] `screens/log_in/bloc/log_in_bloc.dart` ✅
  - [x] `screens/log_in/bloc/log_in_repository.dart` ✅
  - Automatic input type detection (email vs nationalId) ✅
- [x] **View**: `screens/log_in/view/log_in_screen.dart` ✅
  - Email/National ID input (automatic detection) ✅
  - Password input with show/hide toggle ✅
  - Remember me checkbox ✅
  - Forgot password link ✅
  - Sign-in button ✅
  - Sign-up link ("Don't have an account? Sign Up") ✅
  - Loading states (inline loading indicator) ✅
  - Error handling (inline validation, toast for API errors) ✅
  - Success → Store token, navigate to Home ✅
- [x] **Widgets**: 
  - [x] `log_in_body.dart` - Main form widget ✅
  - [x] Uses `CustomAppBar` with Vector auth image (shared with sign-up) ✅
- [x] **Utils**: 
  - [x] `screens/log_in/utils/index.dart` ✅
  - [x] `FormValidatorHelper.detectInputType()` helper method added ✅
- [x] **Integration**:
  - [x] Connect to GraphQL mutation (real backend: https://najaz.rawnaqq.com/graphql) ✅
  - [x] Token storage in SharedPreferences ✅
  - [x] User data storage (id, email, phone, nationalId) ✅
  - [x] Dual login support (email or nationalId) ✅

#### 2.5 Forgot Password Screen
**UI Reference**: `Ui-Ux Screens/Sign-up & Log-in/04- هل نسيت كلمة المرور؟.png`

- [ ] **Model**: 
  - [ ] `models/auth_models/forgot_password_model.dart`
- [ ] **GraphQL**:
  - [ ] `services/graphql/mutations/forgot_password_mutation.dart`
- [ ] **BLoC Structure**:
  - [ ] `screens/forgot_password/bloc/forgot_password_event.dart`
  - [ ] `screens/forgot_password/bloc/forgot_password_state.dart`
  - [ ] `screens/forgot_password/bloc/forgot_password_bloc.dart`
  - [ ] `screens/forgot_password/bloc/forgot_password_repository.dart`
- [ ] **View**: `screens/forgot_password/view/forgot_password_screen.dart`
  - Phone/Email input
  - Send reset link/OTP button
  - Back to sign-in link
  - Success message
- [ ] **Widgets**: Forgot password widgets
- [ ] **Utils**: `screens/forgot_password/utils/index.dart`

#### 2.6 Privacy Policy Screen
**UI Reference**: `Ui-Ux Screens/Sign-up & Log-in/07- صفحة سياسة الخصوصية.png`

- [ ] **Model**: 
  - [ ] `models/cms_models/privacy_policy_model.dart` (if dynamic)
- [ ] **GraphQL**:
  - [ ] `services/graphql/queries/cms_page_query.dart` (if dynamic)
- [ ] **BLoC Structure** (if dynamic):
  - [ ] `screens/privacy_policy/bloc/privacy_policy_event.dart`
  - [ ] `screens/privacy_policy/bloc/privacy_policy_state.dart`
  - [ ] `screens/privacy_policy/bloc/privacy_policy_bloc.dart`
- [ ] **View**: `screens/privacy_policy/view/privacy_policy_screen.dart`
  - WebView or static content
  - Accept/Decline buttons (if needed)
- [ ] **Widgets**: Privacy policy widgets
- [ ] **Utils**: `screens/privacy_policy/utils/index.dart`

---

### Phase 3: Core Features 🏠
**Status**: Not Started  
**Duration**: ~10-15 days  
**Prerequisites**: Phase 2 Complete

#### 3.1 Home Screen ✅
**UI Reference**: `Ui-Ux Screens\UIs svg\الرئيسية.svg`, `Ui-Ux Screens\UIs svg\Vector.svg`

- [x] **Models**: ✅
  - [x] `models/home_models/home_page_model.dart` ✅
  - [x] `models/home_models/home_data_model.dart` ✅
  - [x] `models/service_models/service_model.dart` ✅
- [x] **GraphQL**: ✅
  - [x] `services/graphql_queries/home_page_query.dart` ✅
  - [x] `services/graphql_queries/home_data_query.dart` ✅
- [x] **BLoC Structure**: ✅
  - [x] `screens/home/bloc/home_event.dart` ✅
  - [x] `screens/home/bloc/home_state.dart` ✅
  - [x] `screens/home/bloc/home_bloc.dart` ✅
  - [x] `screens/home/bloc/home_repository.dart` ✅
- [x] **View**: `screens/home/view/home_screen.dart` ✅
  - [x] Custom app bar with Vector.svg background (curved bottom edge) ✅
  - [x] App bar layout: Welcome text (left), Verification status (center), Notification icon (right) ✅
  - [x] Citizen name display below top row ✅
  - [x] Search bar below citizen name ✅
  - [x] Current Requests section (الطلبات الحالية) with horizontal scrollable cards ✅
  - [x] Services section with horizontal scrollable cards ✅
  - [x] "View All" (عرض الكل) buttons for both sections ✅
  - [x] Bottom navigation bar ✅
  - [x] Pull-to-refresh functionality ✅
  - [x] Loading and error states ✅
- [x] **Widgets**: ✅
  - [x] `home_app_bar.dart` - Custom app bar with curved background matching Vector.svg ✅
  - [x] `home_body.dart` - Main home screen body with all sections ✅
  - [x] `service_card.dart` - Service card widget for services grid ✅
  - [x] `service_request_card.dart` - Request card widget for current requests ✅
  - [x] `home_banner.dart` - Home banner widget (placeholder) ✅
  - [x] `category_item.dart` - Category item widget (placeholder) ✅
- [x] **Utils**: `screens/home/utils/index.dart` ✅

#### 3.2 Services Screen
**UI Reference**: `Ui-Ux Screens\UIs svg\Services Page.svg`, 

- [ ] **Models**: 
  - [ ] `models/service_models/service_detail_model.dart`
  - [ ] `models/service_models/service_filter_model.dart`
- [ ] **GraphQL**:
  - [ ] `services/graphql/queries/services_list_query.dart`
  - [ ] `services/graphql/queries/service_detail_query.dart`
- [ ] **BLoC Structure**:
  - [ ] `screens/services/bloc/services_event.dart`
  - [ ] `screens/services/bloc/services_state.dart`
  - [ ] `screens/services/bloc/services_bloc.dart`
  - [ ] `screens/services/bloc/services_repository.dart`
- [ ] **View**: `screens/services/view/services_screen.dart`
  - Service list
  - Filter/Sort options
  - Service detail view
  - Booking functionality (if applicable)
- [ ] **Widgets**: 
  - [ ] Service list item
  - [ ] Service detail widget
  - [ ] Filter widget
- [ ] **Utils**: `screens/services/utils/index.dart`

#### 3.3 Account Screen
**UI Reference**: `Ui-Ux Screens/Home & Services/Account Page.png`

- [ ] **Models**: 
  - [ ] `models/user_models/user_profile_model.dart`
  - [ ] `models/user_models/user_settings_model.dart`
- [ ] **GraphQL**:
  - [ ] `services/graphql/queries/user_profile_query.dart`
  - [ ] `services/graphql/mutations/update_profile_mutation.dart`
- [ ] **BLoC Structure**:
  - [ ] `screens/account/bloc/account_event.dart`
  - [ ] `screens/account/bloc/account_state.dart`
  - [ ] `screens/account/bloc/account_bloc.dart`
  - [ ] `screens/account/bloc/account_repository.dart`
- [ ] **View**: `screens/account/view/account_screen.dart`
  - User profile display
  - Edit profile
  - Settings
  - Logout
  - Orders/Bookings history
- [ ] **Widgets**: 
  - [ ] Profile widget
  - [ ] Settings item widget
- [ ] **Utils**: `screens/account/utils/index.dart`

---

### Phase 4: Additional Features 📱
**Status**: Not Started  
**Duration**: TBD

#### Features to be added (based on future requirements):
- Order/Booking Management
- Notifications
- Search & Filters
- Favorites/Wishlist
- Payment Integration
- Chat/Support
- Reviews & Ratings
- Location Services
- And more as needed...

---

## Technical Stack

### State Management
- **flutter_bloc**: ^9.1.0 (BLoC pattern)
- **equatable**: ^2.0.3 (Value equality)
- **provider**: ^6.0.1 (Dependency injection)

### Networking
- **graphql_flutter**: ^5.1.1 (GraphQL client)
- **http**: ^1.2.2 (HTTP client)

### Local Storage
- **get_storage**: ^2.0.3 (Lightweight key-value storage)

### JSON Serialization
- **json_annotation**: ^4.8.1
- **json_serializable**: ^6.5.4 (Code generation)
- **build_runner**: ^2.1.4

### UI & Animations
- **lottie**: ^3.3.1 (Animations)
- **google_fonts**: ^6.2.1 (Fonts - until brand font provided)
- **cached_network_image**: ^3.2.1 (Image caching)
- **carousel_slider**: ^5.0.0 (Carousels)

### Utilities
- **intl**: ^0.19.0 (Internationalization)
- **url_launcher**: ^6.3.1 (External links)
- **share_plus**: ^10.1.4 (Sharing)
- **overlay_support**: ^2.1.0 (Toast notifications)

---

## Implementation Guidelines

### BLoC Pattern Structure
Each feature follows this structure:
```
screens/feature_name/
├── bloc/
│   ├── feature_event.dart      # Events (user actions)
│   ├── feature_state.dart      # States (UI states)
│   ├── feature_bloc.dart       # Business logic
│   └── feature_repository.dart # Data layer
├── view/
│   └── feature_screen.dart     # UI implementation
├── widget/
│   └── feature_widgets.dart    # Feature-specific widgets
└── utils/
    └── index.dart              # Exports
```

**When to use BLoC vs StatefulWidget**:
- **Use BLoC**: For all screens with business logic, API calls, form handling, data management
- **Use StatefulWidget**: Only for simple UI-only screens (e.g., welcome screen with animations, static content screens without data fetching)

### Naming Conventions
- **Files**: snake_case (e.g., `sign_in_screen.dart`)
- **Classes**: PascalCase (e.g., `SignInScreen`)
- **Variables**: camelCase (e.g., `userName`)
- **Constants**: camelCase with descriptive names
- **Routes**: camelCase constants (e.g., `signInScreen`)

### Code Structure Rules
1. **Single Responsibility**: Each class does one thing
2. **Separation of Concerns**: UI, Business Logic, Data separate
3. **Reusability**: Extract common widgets to `widgets/`
4. **Type Safety**: Always use explicit types
5. **Error Handling**: Always handle errors gracefully (see Error Handling Strategy below)
6. **Loading States**: Always show inline loading indicators (not full-screen overlays)
7. **Validation**: Validate inputs before API calls using FormValidatorHelper

### Error Handling Strategy
Following Bagisto's error handling patterns:

1. **Toast Notifications** (ShowMessage):
   - Use for API response errors (success/error messages after mutations/queries)
   - Use for non-critical errors that don't block user flow
   - Examples: "Sign up successful", "Phone number already used", "Network error"
   - Implementation: `ShowMessage.errorNotification()`, `ShowMessage.successNotification()`

2. **Inline Errors** (Form Validation):
   - Use for form field validation errors
   - Display directly below or next to the input field
   - Examples: "Please fill email", "Invalid phone number", "Password too short"
   - Implementation: `TextFormField.validator` with `FormValidatorHelper` methods
   - Display: `ErrorMessage.inlineErrorMsg()` or directly in TextFormField errorText

3. **Dialogs** (DialogHelper):
   - Use for critical errors that require user acknowledgment
   - Use for network errors that block functionality
   - Use for confirmation dialogs
   - Examples: "No internet connection", "Delete confirmation", "Critical error occurred"
   - Implementation: `DialogHelper.networkErrorDialog()`, `DialogHelper.errorDialog()`, `DialogHelper.confirmationDialog()`

### Loading Indicator Strategy
- **Inline Loading**: Show loading indicators within the UI (e.g., CircularProgressIndicator in button, loading state in BLoC)
- **No Global Overlay**: Do not use full-screen loading overlays unless absolutely necessary (e.g., app initialization)
- **Loading States**: Manage loading states in BLoC states (e.g., `LoadingState`, `SuccessState`, `ErrorState`)

### GraphQL Best Practices
1. **Structured Queries**: Keep queries in `services/graphql/queries/`
2. **Structured Mutations**: Keep mutations in `services/graphql/mutations/`
3. **Fragments**: Use fragments for reusable query parts
4. **Error Handling**: Parse GraphQL errors properly
5. **Variables**: Use variables instead of string interpolation

### Theming Best Practices
1. **No Hardcoded Values**: All colors, sizes, fonts from theme
2. **Centralized Theme**: All theme values in `utils/` theme files
3. **Dark Mode Support**: Design with dark mode in mind
4. **Responsive**: Use MediaQuery for responsive layouts

---

## Documentation Requirements

### Documentation Location
All documentation must be saved in `najaz_app/doc/` folder.

### Required Documentation Files

1. **PROJECT_PLAN.md** (This file)
   - Overall project plan and phases

2. **ARCHITECTURE.md**
   - Detailed architecture documentation
   - Folder structure explanation
   - Design patterns used

3. **API_DOCUMENTATION.md**
   - GraphQL schema documentation
   - API endpoints
   - Request/Response formats

4. **THEMING_GUIDE.md**
   - Theme system explanation
   - How to use colors, fonts, spacing
   - Dark mode implementation

5. **DEVELOPMENT_LOG.md**
   - Daily/weekly progress updates
   - Changes made
   - Decisions taken
   - Issues encountered and solutions

6. **FEATURE_DOCUMENTATION/**
   - Individual feature documentation
   - Each major feature gets its own doc

### Documentation Standards
- Update documentation after each major change
- Include code examples where helpful
- Document any deviations from Bagisto patterns
- Include screenshots for UI features
- Document API integrations

---

## Development Workflow

### For Each Feature/Screen:

1. **UI Layout First**
   - Implement static UI matching Figma design
   - No business logic, just UI structure
   - Use theme values only

2. **State Management**
   - Create BLoC structure (events, states, bloc, repository)
   - Add validation logic
   - Handle input changes

3. **GraphQL Integration**
   - Create queries/mutations
   - Map JSON to models
   - Connect repository to API client
   - Connect BLoC to repository

4. **Refactor & Optimize**
   - Extract reusable widgets
   - Move to `widgets/` if used elsewhere
   - Optimize performance
   - Add error handling

5. **Testing**
   - Test happy path
   - Test error cases
   - Test edge cases
   - Test navigation flows

6. **Documentation**
   - Update relevant documentation
   - Add code comments where needed
   - Document any special considerations

---

## Current Status

### ✅ Completed
- **Project plan created** - Comprehensive plan with all phases documented
- **Folder structure defined** - Complete architecture setup
- **Phase 1.1: Project Structure Setup** ✅
  - All main folders created (models, screens, services, utils, widgets)
  - All subfolders organized and created
  - .gitkeep files added for git tracking
- **Phase 1.2: Dependencies & Configuration** ✅
  - All dependencies added to pubspec.yaml
  - Dependencies installed successfully
  - Assets folder structure created
  - Analysis options configured
- **Phase 1.3: Theming System** ✅
  - Colors extracted from Figma designs
  - Typography system created
  - Light theme implemented
  - Theme provider created
  - Spacing and radii systems created
- **Phase 1.4: Constants & Configuration** ✅
  - App constants (app info, defaults, locales)
  - Route constants (all navigation routes)
  - String constants (localization-ready keys)
  - Assets constants (all asset paths)
  - Server configuration (API setup, base URL, headers)
- **Phase 1.5: Shared Preferences Service** ✅
  - Shared preference keys defined (tailored for Najaz service-based platform)
  - Shared preference helper implemented (GetStorage, all CRUD methods)
- **Phase 1.7: Navigation Setup** ✅
  - Route generation for all app routes
  - Initial route logic (first launch → onboarding → auth → home)
  - Navigation helper methods implemented
- **Phase 1.5: Shared Preferences Service** ✅
  - Shared preference keys (all storage keys defined)
  - Shared preference helper (GetStorage implementation, all CRUD methods)
  - Tailored for Najaz service-based platform (no e-commerce features)
- **Phase 1.6: GraphQL Infrastructure** ✅
  - GraphQL client configuration (HTTP link, auth link, logger link)
  - API client with query/mutation methods and error handling
  - Base models for GraphQL responses
  - GraphQL queries and mutations folder structure
  - Using real endpoint: https://najaz.rawnaqq.com/graphql
- **Phase 1.7: Navigation Setup** ✅
  - Route generation for all app routes
  - Initial route logic (first launch → onboarding → auth → home)
  - Navigation helper methods
  - Placeholder screens for unimplemented routes
- **Phase 1.8: Global Data & State** ✅
  - Global state variables (locale, cookie, FCM token, device name)
  - Stream controllers for app-wide state management
  - App-wide data caching structure
  - Tailored for Najaz service-based platform
- **Phase 1.9: Utility Files** ✅
  - Input field validators (email, phone, password, OTP)
  - Helper extensions (Color, String, BuildContext, DateTime)
  - Dialog helper (network error, confirmation, error, success, loading)
  - Internet connection checker
  - Application localization (supports Arabic and English)
- **Phase 1.10: Reusable Widgets Foundation** ✅
  - Common app bar with search and notification support
  - Common widgets (text fields, buttons, helpers)
  - Loader widget
  - Error message widget
  - Empty state widget with Lottie animations
- **Phase 1.11: Main App Setup** ✅
  - MaterialApp configuration (theme, localization, routes)
  - Theme and localization setup
  - Provider setup (ThemeProvider)
  - Route configuration with initial route logic
  - RestartWidget for app restart capability
  - GlobalData initialization
  - GraphQL cache initialization
- **Additional Widgets** ✅
  - Image view widget (network images with caching and placeholder)
  - Show message widget (toast notifications: success, error, warning, info)

- **Phase 2.1: Welcome/Onboarding Screen** ✅
  - BLoC structure (events, states, bloc) ✅
  - Welcome screen view with Column layout ✅
  - Separated widget components (TopSection, DescriptionSection, ButtonsSection) ✅
  - App name localization (نجاز/Najaz) ✅
  - All strings properly localized ✅
  - Navigation through BLoC events ✅
  - Routes updated in app_navigation.dart ✅

### 🚧 In Progress
- **Phase 2**: Authentication Flow (50% complete - Welcome, Sign-Up, and Sign-In screens done)
- **Phase 3.1**: Home Screen (95% complete - Core functionality implemented, minor refinements may be needed)

### ⏳ Pending
- **Phase 2**: Remaining authentication screens (Set Password, Forgot Password, Privacy Policy)
- **Phase 3.2**: Services Screen
- **Phase 3.3**: Account Screen
- **Phase 4**: Additional Features

---

## Notes & Decisions

### GraphQL URL
- **Current**: Real GraphQL endpoint configured: `https://najaz.rawnaqq.com/graphql`
- **Status**: Server configuration updated with actual URL
- **Schema**: Using Laravel Lighthouse GraphQL (similar to Bagisto's GraphQL schema)
- **Testing**: Use Altair GraphQL extension in Chrome to test API calls during development

### Branding
- **Colors**: Extracted from Figma designs initially, will be replaced with brand colors
  - **Note**: UI SVG files have pending changes (not yet complete)
- **Fonts**: Using Google Fonts initially, will be replaced with brand font
- **Theme**: Will be updated once brand assets are provided

### Localization
- **Primary Language**: Arabic (based on UI designs)
- **Secondary Language**: English (to be added)
- **Localization**: Set up for multi-language support from start

### Removed Features
- **Splash Screen**: Removed custom splash screen implementation. Using `flutter_native_splash` package instead.
- **OTP Verification Screen**: Removed OTP verification screen (صفحة التحقق) - no longer needed in authentication flow.

---

## Next Steps

1. **Review this plan** with the team
2. **Start Phase 1**: Foundation & Infrastructure
3. **Extract theme values** from Figma designs
4. **Set up project structure** and dependencies
5. **Begin implementation** following the plan step by step

---

**Last Updated**: 2024-12-20  
**Version**: 1.0.6  
**Status**: Active Development - Phase 2 & Phase 3.1 In Progress

### Progress Summary
- **Phase 1**: 11/11 tasks completed (100%) ✅
  - ✅ Phase 1.1: Project Structure Setup
  - ✅ Phase 1.2: Dependencies & Configuration
  - ✅ Phase 1.3: Theming System (colors, typography, theme, spacing, radii)
  - ✅ Phase 1.4: Constants & Configuration
  - ✅ Phase 1.5: Shared Preferences Service
  - ✅ Phase 1.6: GraphQL Infrastructure
  - ✅ Phase 1.7: Navigation Setup
  - ✅ Phase 1.8: Global Data & State
  - ✅ Phase 1.9: Utility Files (including FormValidatorHelper)
  - ✅ Phase 1.10: Reusable Widgets Foundation
  - ✅ Phase 1.11: Main App Setup
- **Phase 2**: 3/6 screens completed (50%) ✅
  - ✅ Phase 2.1: Welcome/Onboarding Screen (Complete with BLoC pattern, Column layout, localization)
  - ✅ Phase 2.3: Sign-Up Screen (Complete with BLoC pattern, form validation, GraphQL integration, token storage)
  - ✅ Phase 2.4: Sign-In Screen (Complete with BLoC pattern, dual login support, automatic input detection, token storage)
  - ⏳ Phase 2.3: Set Password Screen
  - ⏳ Phase 2.5: Forgot Password Screen
  - ⏳ Phase 2.6: Privacy Policy Screen
- **Phase 3.1**: Home Screen (95% complete) ✅
  - ✅ Models (HomePageModel, HomeDataModel, ServiceModel)
  - ✅ GraphQL queries (home_page_query, home_data_query)
  - ✅ BLoC structure (events, states, bloc, repository)
  - ✅ Custom app bar with Vector.svg background and curved bottom edge
  - ✅ Current Requests section with horizontal scrollable cards
  - ✅ Services section with horizontal scrollable cards
  - ✅ "View All" (عرض الكل) buttons for both sections
  - ✅ Bottom navigation bar
  - ✅ Service cards and request cards widgets
  - ✅ Pull-to-refresh functionality
  - ✅ Loading and error states
- **Overall Project**: Phase 1 complete (100%)! Phase 2 in progress (50%). Phase 3.1 nearly complete (95%).

### Recent Changes (v1.0.6)
- ✅ Home Screen fully implemented with BLoC pattern
- ✅ Custom app bar with Vector.svg background and curved bottom edge using CustomClipper
- ✅ App bar layout: Welcome text (left), Verification status (center), Notification icon (right)
- ✅ Citizen name display below top row, search bar below citizen name
- ✅ Current Requests section (الطلبات الحالية) with horizontal scrollable cards
- ✅ Services section with horizontal scrollable service cards
- ✅ "View All" (عرض الكل) buttons added to both Current Requests and Services sections
- ✅ View All button for Services navigates to services screen
- ✅ Service card widget with image, name, and loading states
- ✅ Service request card widget for displaying current requests
- ✅ Bottom navigation bar with home, services, history, and profile icons
- ✅ Pull-to-refresh functionality for home data
- ✅ Loading and error states handling
- ✅ GraphQL query integration for home page data
- ✅ Fixed RenderFlex overflow exceptions by adjusting padding and spacing
- ✅ Fixed missing placeholder asset by using Icon widgets instead
- ✅ Fixed Positioned widget error by changing Column to Stack structure
- ✅ Minimized text sizes on home screen, especially in app bar
- ✅ Swapped notification and welcome text positions as per design
- ✅ Home app bar extracted to separate widget file (home_app_bar.dart)

### Previous Changes (v1.0.5)
- ✅ Sign-In Screen fully implemented with BLoC pattern
- ✅ Dual login support (email OR nationalId with automatic detection)
- ✅ Form validation using FormValidatorHelper.validateEmailOrNationalId
- ✅ GraphQL mutation integration with real backend (https://najaz.rawnaqq.com/graphql)
- ✅ Automatic input type detection (email vs nationalId) using FormValidatorHelper.detectInputType()
- ✅ Error handling (inline validation, toast notifications for API errors)
- ✅ Token and user data storage on successful log-in
- ✅ Navigation to home screen after successful log-in
- ✅ Remember me checkbox functionality
- ✅ Forgot password and sign-up navigation links
- ✅ Password show/hide toggle
- ✅ Custom app bar with Vector auth image (shared with sign-up screen)

### Previous Changes (v1.0.4)
- ✅ Sign-Up Screen fully implemented with BLoC pattern
- ✅ All form fields implemented (firstName, middleName, lastName, gender, phone, nationalId, dateOfBirth, password, confirmPassword)
- ✅ Form validation using FormValidatorHelper
- ✅ GraphQL mutation integration with real backend (https://najaz.rawnaqq.com/graphql)
- ✅ Error handling (inline validation, toast notifications for API errors)
- ✅ Token and user data storage on successful sign-up
- ✅ Navigation to home screen after successful sign-up
- ✅ CommonAppBar enhanced with optional image support (Vector auth.png)
- ✅ TextField backgrounds set to white for better visibility
- ✅ Login navigation text extracted to separate widget (`sign_up__navigate_login_text.dart`)
- ✅ Custom app bar with Vector auth image implemented

### Previous Changes (v1.0.3)
- ✅ Welcome screen rebuilt with BLoC pattern
- ✅ Welcome screen uses Column layout instead of Stack
- ✅ Welcome screen separated into widget components (TopSection, DescriptionSection, ButtonsSection)
- ✅ App name localization added (نجاز/Najaz)
- ✅ All welcome screen strings properly localized
- ✅ Navigation handled through BLoC events

### Previous Changes (v1.0.2)
- ✅ Removed custom splash screen (using flutter_native_splash)
- ✅ Removed OTP verification screen from authentication flow
- ✅ Added FormValidatorHelper for consistent form validation
- ✅ Documented error handling strategy (toast/dialog/inline)
- ✅ Clarified BLoC vs StatefulWidget usage guidelines
- ✅ Updated navigation flow (removed splash and OTP routes)

