# Workiom Flutter App

A Flutter application implementing the Workiom API integration with MVVM architecture pattern and manual data models for maximum reliability.

## Features

- **Authentication Flow**: Complete sign-up and sign-in process
- **Edition Selection**: Choose from available subscription plans
- **Tenant Management**: Create and manage tenant accounts
- **Clean Architecture**: MVVM pattern with BLoC state management
- **API Integration**: Full integration with Workiom API endpoints
- **Manual Data Models**: Reliable, manually-crafted models without code generation issues

## Architecture

The app follows MVVM (Model-View-ViewModel) architecture with the following layers:

### 1. Data Layer
- **Models**: Manual Dart classes with default values, JSON serialization, and immutability
- **Services**: API service layer using Retrofit
- **Repositories**: Data access layer with comprehensive error handling

### 2. Presentation Layer
- **BLoC**: State management using flutter_bloc
- **Pages**: UI screens for different app flows
- **Widgets**: Reusable UI components

### 3. Core Layer
- **Network**: HTTP client configuration with Dio
- **DI**: Dependency injection using GetIt
- **Router**: Navigation using GoRouter
- **Constants**: App-wide constants and configurations
- **Utils**: Validation and error handling utilities

## API Endpoints

The app integrates with the following Workiom API endpoints:

- `GET /api/services/app/Session/GetCurrentLoginInformations` - Check login status
- `GET /api/services/app/TenantRegistration/GetEditionsForSelect` - Get available editions
- `GET /api/services/app/Profile/GetPasswordComplexitySetting` - Get password requirements
- `POST /api/services/app/Account/IsTenantAvailable` - Check tenant availability
- `POST /api/services/app/TenantRegistration/RegisterTenant` - Register new tenant
- `POST /api/TokenAuth/Authenticate` - User authentication

## Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate API service code:
   ```bash
   flutter packages pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/          # App constants
│   ├── di/                # Dependency injection
│   ├── network/           # Network configuration
│   ├── router/            # App routing
│   └── utils/             # Utilities (validation, error handling)
├── data/
│   ├── models/            # Manual data models (no code generation)
│   ├── repositories/      # Data repositories
│   └── services/          # API services (Retrofit generated)
└── presentation/
    ├── bloc/              # BLoC state management
    ├── pages/             # UI screens
    └── widgets/           # Reusable widgets
```

## Dependencies

### Main Dependencies
- `flutter_bloc`: State management with BLoC pattern
- `dio`: HTTP client for API requests
- `retrofit`: API client generation (for service layer only)
- `get_it`: Dependency injection
- `go_router`: Navigation and routing
- `flutter_screenutil`: Responsive design utilities
- `shared_preferences`: Local storage
- `multiple_result`: Result type for error handling
- `equatable`: Value equality for state objects
- `connectivity_plus`: Network connectivity checking
- `fluttertoast`: Toast notifications

### Dev Dependencies
- `build_runner`: Code generation (for Retrofit only)
- `retrofit_generator`: API client generation
- `flutter_lints`: Code quality and linting

## Usage

### Authentication Flow

1. **Splash Screen**: Checks if user is already logged in
2. **Login**: Sign in with email, password, and tenant name
3. **Registration**: Create new account with tenant information
4. **Edition Selection**: Choose subscription plan (if needed)
5. **Home**: Main app screen with user and tenant information

### Key Features

- **Manual Data Models**: Reliable, manually-crafted models with default values and proper JSON serialization
- **Password Validation**: Dynamic password requirements based on server settings
- **Tenant Availability**: Real-time checking of tenant name availability
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Responsive Design**: Adaptive UI for different screen sizes
- **State Management**: Reactive UI updates using BLoC pattern
- **No Code Generation Issues**: Manual models eliminate freezed generation problems

## API Configuration

The app is configured to work with the Workiom API at:
- Base URL: `https://api.workiom.club`

## Data Models

The app uses manually-crafted Dart classes instead of code generation tools like Freezed. This approach provides:

- **Reliability**: No code generation issues or compatibility problems
- **Control**: Full control over JSON serialization and field handling
- **Performance**: No build-time overhead from code generation
- **Maintainability**: Clear, readable code that's easy to debug and modify
- **Default Values**: All fields have sensible default values for null safety

## Contributing

1. Follow the existing code structure and patterns
2. Use BLoC for state management
3. Create manual data models (no Freezed/code generation)
4. Implement proper error handling
5. Add appropriate tests
6. Follow Flutter/Dart best practices

## License

This project is for demonstration purposes.