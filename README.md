# E-Commerce Demo App

A Flutter e-commerce application showcasing clean architecture implementation with shopping cart functionality. This project was developed with AI assistance while following established architectural patterns and best practices.

## Features

- Browse products in a responsive grid layout
- View product details
- Multiple shopping carts support
  - Create multiple carts
  - Add items to specific carts
  - Select carts for checkout
- User authentication
- Pagination for product listing

## Technical Stack

- **Flutter & Dart**: Core framework and programming language
- **flutter_bloc**: State management solution
- **flutter_screenutil**: Responsive UI scaling
- **equatable**: Value equality comparisons
- **hive**: Local storage for cart and user data

## Architecture

The project follows Clean Architecture principles with three main layers:

```plaintext
lib/
├── core/
│   └── data_state.dart          # Base data state handling
├── data/
│   ├── datasources/             # Data sources implementation
│   │   ├── auth_local_datasource.dart
│   │   └── cart_local_datasource.dart
│   ├── models/                  # Data models
│   │   ├── cart_model.dart
│   │   ├── product_model.dart
│   │   └── user_model.dart
│   └── repository/              # Repository implementations
├── domain/
│   ├── entity/                 # Business entities
│   │   ├── cart_entity.dart
│   │   ├── product_entity.dart
│   │   └── user_entity.dart
│   ├── repository/             # Repository interfaces
│   └── usecase/                # Use cases
├── presentation/
│   ├── bloc/                   # BLoC state management
│   │   ├── auth/
│   │   └── cart/
│   └── screens/                # UI screens
└── widgets/                    # Reusable UI components
```

## Key Components

1. **Domain Layer**
   - Business entities (Cart, Product, User)
   - Repository interfaces
   - Use cases for business logic

2. **Data Layer**
   - Local storage implementation
   - Data models and mappers
   - Repository implementations

3. **Presentation Layer**
   - BLoC pattern for state management
   - Responsive UI components
   - Screen implementations:
     - Home screen with product grid
     - Product details
     - Cart management
     - Authentication

## Design Patterns & Features

- **Repository Pattern**: Abstracts data sources
- **BLoC Pattern**: Manages state and business logic
- **Use Case Pattern**: Encapsulates business rules
- **Multiple Cart System**: Allows users to manage multiple shopping carts
- **Responsive Design**: Adapts to different screen sizes
- **Local Storage**: Persists cart and user data

## Custom Widgets

The app includes several custom widgets for consistency and reusability:
- Custom App Bar
- Custom Button
- Custom Scaffold
- Custom Text Field
- Error Section
- Custom Text Styles

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Development Notes

This application was developed with the assistance of AI while maintaining clean architecture principles and following established patterns. The AI helped in implementing features while adhering to the project's architectural decisions and patterns.

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  flutter_screenutil: ^5.9.0
  hive: ^2.2.3
```

This e-commerce demo app serves as a practical example of implementing clean architecture in Flutter, demonstrating best practices in mobile app development with AI assistance.
