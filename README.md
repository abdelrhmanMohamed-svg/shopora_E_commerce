# Shopora E-commerce App

## Description

Shopora is a feature-rich e-commerce application built with Flutter. It provides a seamless shopping experience for users, allowing them to browse products, add them to their cart, and complete the checkout process. The app is integrated with Firebase for authentication, data storage, and other backend services.

### How it works

The app follows the BLoC pattern for state management, ensuring a clean and scalable architecture. It uses Firebase for user authentication (Email/Password, Google, Facebook), Firestore for data storage (products, categories, user data), and local notifications to keep users engaged.

### Technologies, Frameworks, and Packages

- **Flutter:** The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase:** A comprehensive app development platform that provides backend services like authentication, cloud storage, and real-time databases.
  - **Firebase Auth:** For user authentication.
  - **Cloud Firestore:** A NoSQL document database for storing and syncing data.
- **Flutter BLoC:** A predictable state management library for Dart that helps implement the BLoC (Business Logic Component) design pattern.
- **Cached Network Image:** To show images from the internet and keep them in the cache directory.
- **Google Sign-In:** For implementing Google Sign-In.
- **Flutter Facebook Auth:** For implementing Facebook Sign-In.
- **Flutter Local Notifications:** A cross-platform plugin for displaying local notifications.
- **WorkManager:** A Flutter plugin that allows you to schedule and run background tasks.

## Features

- **User Authentication:**
  - Sign up and sign in with email and password.
  - Sign in with Google.
  - Sign in with Facebook.
- **Home Page:**
  - Displays a carousel of announcements.
  - Shows a list of products.
  - Tabs for "Home" and "Category" views.
- **Product Details:**
  - View detailed information about a product.
  - Add products to the cart.
  - Add products to favorites.
- **Shopping Cart:**
  - View items in the cart.
  - Update the quantity of items.
  - View subtotal, shipping cost, and total amount.
- **Checkout:**
  - Add and select a shipping address.
  - Add and select a payment method.
  - Place an order.
- **Favorites:**
  - View a list of favorite products.
  - Remove products from favorites.
- **Profile:**
  - View user information (username, email).
  - Sign out from the application.
- **Notifications:**
  - Receive welcome notifications.
  - Receive notifications for new items.

## Project Structure

```
.
├── android
├── assets
│   ├── icons
│   └── images
├── build
├── ios
├── lib
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── model
│   │   ├── add_to_cart_model.dart
│   │   ├── category_item_mode.dart
│   │   ├── home_carosel_item_model.dart
│   │   ├── location_item_model.dart
│   │   ├── new_card_model.dart
│   │   ├── order_model.dart
│   │   ├── product_item_model.dart
│   │   └── user_data_model.dart
│   ├── model_views
│   │   ├── auth_cubit
│   │   ├── cart_cubit
│   │   ├── category_cubit
│   │   ├── checkout
│   │   ├── favorites_cubit
│   │   ├── home_cubit
│   │   ├── location_cubit
│   │   ├── payment_cubit
│   │   ├── product_details_cubit
│   │   └── root_cubit
│   ├── root.dart
│   ├── services
│   │   ├── auth_service.dart
│   │   ├── cart_services.dart
│   │   ├── category_services.dart
│   │   ├── checkout_services.dart
│   │   ├── favorites_services.dart
│   │   ├── firestore_services.dart
│   │   ├── home_services.dart
│   │   ├── location_services.dart
│   │   ├── notifications_services.dart
│   │   ├── paymentCard_services.dart
│   │   ├── product_details_services.dart
│   │   └── work_manager_services.dart
│   ├── utils
│   │   ├── api_paths.dart
│   │   ├── app_colors.dart
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   └── views
│       ├── pages
│       └── widgets
├── linux
├── macos
├── test
├── web
└── windows
```

- **`lib/`**: Contains the core source code of the application.
  - **`model/`**: Defines the data models for the application (e.g., `ProductItemModel`, `UserDataModel`).
  - **`model_views/`**: Contains the BLoC cubits that manage the state of the application.
  - **`services/`**: Implements the business logic and interacts with backend services like Firebase.
  - **`utils/`**: Includes utility classes for routing, colors, and API paths.
  - **`views/`**: Contains the UI components of the application, divided into pages and widgets.
- **`assets/`**: Stores static assets like images and icons.
- **`android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`**: Platform-specific code.
- **`pubspec.yaml`**: Defines the project's dependencies and metadata.

## Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/shopora_e_commerce.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Set up Firebase:**
   - Create a new Firebase project.
   - Add an Android and/or iOS app to your Firebase project.
   - Download the `google-services.json` file for Android and place it in the `android/app` directory.
   - Download the `GoogleService-Info.plist` file for iOS and place it in the `ios/Runner` directory.
4. **Run the app:**
   ```bash
   flutter run
   ```

## Screenshots

| Splash Screen | Welcome Notification | New Item Notification |
| :---: | :---: | :---: |
| ![Splash Screen](assets/screenShots/splash_screen.png) | ![Welcome Notification](assets/screenshots/welcome_notification.png) | ![New Item Notification](assets/screenshots/newItem_notification.png) |
| **Sign In Screen** | **Google Sign In** | **Home Screen** |
| ![Sign In Screen](assets/screenshots/sign_in_screen.png) | ![Google Sign In](assets/screenshots/google_sign_in.png) | ![Home Screen](assets/screenshots/home_screen.png) |
| **Category Screen** | **My Cart Screen** | **Favorite Screen** |
| ![Category Screen](assets/screenshots/category_screen.png) | ![My Cart Screen](assets/screenshots/myCart_screeen.png) | ![Favorite Screen](assets/screenshots/favorite_screen.png) |
| **Empty Favorite Screen** | **Checkout Screen** | **Empty Checkout Screen** |
| ![Empty Favorite Screen](assets/screenshots/empty_favorite_screen.png) | ![Checkout Screen](assets/screenshots/checkout_sreen.png) | ![Empty Checkout Screen](assets/screenshots/empty_checkout_screen.png) |
| **Locations Screen** | **Empty Locations Screen** | **Payment Cards Sheet** |
| ![Locations Screen](assets/screenshots/locations_screen.png) | ![Empty Locations Screen](assets/screenshots/empty_locations_screen.png) | ![Payment Cards Sheet](assets/screenshots/payment_cards_sheet.png) |
| **Success Order Sheet** | **Profile Screen** |
| ![Success Order Sheet](assets/screenshots/success_order_sheet.png) | ![Profile Screen](assets/screenshots/profile_screen.png) |

## Usage

- **Login/Register:** Start by creating an account or logging in with your existing credentials.
- **Browse Products:** Explore the home page to find products or browse by category.
- **Add to Cart:** Select a product, choose the size and quantity, and add it to your cart.
- **Checkout:** Proceed to the checkout page, add your shipping address and payment method, and place your order.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature/your-feature`).
6. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.