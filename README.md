# 🎬 Movies App

Movies App is a comprehensive, production-ready Flutter application designed to help you discover, explore, and manage your favorite movies effortlessly. Built with a focus on high performance, clean code, and a seamless user experience.

---

## 📱 Screenshots

### Onboarding Experience
| Screen 1 | Screen 2 | Screen 3 | Screen 4 |
|----------|----------|----------|----------|
| ![Onboarding 1](screenshots/en/onboarding_1.png) | ![Onboarding 2](screenshots/en/onboarding_2.png) | ![Onboarding 3](screenshots/en/onboarding_3.png) | ![Onboarding 4](screenshots/en/onboarding_4.png) |

| Screen 5 | Screen 6 | | |
|----------|----------|----------|----------|
| ![Onboarding 5](screenshots/en/onboarding_5.png) | ![Onboarding 6](screenshots/en/onboarding_6.png) | | |

### Authentication
| Login | Register | Forgot Password | Reset Password |
|-------|----------|-----------------|----------------|
| ![Login](screenshots/en/login.png) | ![Register](screenshots/en/register.png) | ![Forgot Password](screenshots/en/forgot_password.png) | ![Reset Password](screenshots/en/reset_password.png) |

### Main App - Bottom Navigation Tabs
| 🏠 Home | 🔍 Search | 📂 Explore | 👤 Profile |
|---------|-----------|-----------|-----------|
| ![Home](screenshots/en/home.png) | ![Search](screenshots/en/search.png) | ![Explore](screenshots/en/explore.png) | ![Profile](screenshots/en/profile.png) |

### Movie Details - Multiple Sections
| Screenshots | Similar Movies | Cast & Details | Genres |
|---------------|----------------|------------|---------|
| ![Details 1](screenshots/en/movie_details_1.png) | ![Details 2](screenshots/en/movie_details_2.png) | ![Details 3](screenshots/en/movie_details_3.png) | ![Details 4](screenshots/en/movie_details_4.png) |

### Profile Management
| View Profile | Edit Profile | Delete Account |
|------------|-------------|----------------|
| ![Profile](screenshots/en/profile.png) | ![Edit](screenshots/en/edit_profile.png) | ![Delete](screenshots/en/delete_account.png) |

### Arabic Version (RTL Support)
| Home AR | Explore AR | Profile AR | Login AR |
|---------|-----------|-----------|----------|
| ![Home AR](screenshots/ar/home.png) | ![Explore AR](screenshots/ar/explore.png) | ![Profile AR](screenshots/ar/profile.png) | ![Login AR](screenshots/ar/login.png) |

---

## ✨ Core Features

🏠 **Home Tab**: Discover trending and featured movies with beautiful carousel displays and category-based browsing.

🔍 **Search Tab**: Real-time movie search with instant results by title, actor, or keyword.

📂 **Explore by Genre**: Browse movies organized by genre with smooth grid layouts and pagination.

👤 **Profile Tab**: Comprehensive user profile management. View personal info, edit profile, manage your watchlist and history.

📽️ **Movie Details**: Rich movie information including poster, backdrop, overview, cast, ratings, and recommendations.

🔐 **Secure Authentication**: Firebase-backed authentication with Email/Password and Google Sign-In.

🌍 **Multi-Language Support**: Full internationalization for English (LTR) and Arabic (RTL) with in-app language switching.

⚡ **High Performance**: Lazy loading, image caching, and efficient BLoC state management.

---

## 🚀 Technical Stack

| Component | Technology |
|-----------|-----------|
| **Framework** | Flutter 3.10.1+ |
| **Language** | Dart 3.10.1+ |
| **Architecture** | Clean Architecture with BLoC Pattern |
| **State Management** | Flutter BLoC (Cubit & Bloc) |
| **Backend** | Firebase (Auth & Firestore) |
| **Networking** | Dio HTTP Client |
| **Localization** | Intl (English & Arabic) |
| **Dependency Injection** | GetIt |

---

## 🏗️ Project Structure

```
lib/
├── core/                          # Shared utilities and widgets
│   ├── config/                    # App theme & configuration
│   ├── di/                        # Dependency Injection (GetIt)
│   ├── errors/                    # Custom exceptions & failures
│   ├── ex/                        # Dart extensions
│   ├── utils/
│   │   ├── app_colors.dart        # Color palette
│   │   ├── app_routes.dart        # Route definitions
│   │   ├── app_assets.dart        # Asset paths
│   │   ├── cache_helper.dart      # Local storage
│   │   └── app_validators.dart    # Input validation
│   └── widgets/                   # Reusable custom widgets
│
├── features/                      # Feature modules
│   ├── auth/                      # Authentication (Firebase)
│   ├── home/                      # Home & Trending
│   ├── search/                    # Search functionality
│   ├── explore/                   # Browse by genre
│   ├── movie_details/             # Movie details & info
│   ├── profile/                   # User profile management
│   ├── splash/                    # Splash screen
│   └── onboarding/                # Onboarding flow
│
├── l10n/                          # Localization (ARB files)
├── main.dart                      # App entry point
└── pubspec.yaml                   # Dependencies
```

---

## 📦 Key Dependencies

```yaml
# State Management
flutter_bloc: ^9.1.1

# Firebase
firebase_core: ^4.9.0
firebase_auth: ^6.5.1
cloud_firestore: ^6.4.1

# Authentication
google_sign_in: ^7.2.0

# Networking & DI
dio: ^5.9.2
get_it: ^9.2.1
dartz: ^0.10.1

# UI & Local Storage
shared_preferences: ^2.3.2
flutter_screenutil: ^5.9.3
flutter_svg: ^2.3.0
carousel_slider: ^5.1.2
flutter_native_splash: ^2.4.7
fluttertoast: ^9.0.0
```

---

## 🚀 Getting Started

1. **Clone & Install**
   ```bash
   git clone https://github.com/Ahmed-Elmekawy/movies_app.git
   flutter pub get
   ```

2. **Localization**
   ```bash
   flutter gen-l10n
   ```

3. **Firebase Setup**
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Enable Auth and Firestore in the Firebase Console.

4. **Run**
   ```bash
   flutter run
   ```
