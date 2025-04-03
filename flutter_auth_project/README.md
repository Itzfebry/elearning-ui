# Flutter Authentication Project

This project is a Flutter application that implements an authentication system using GetX. It features role-based login and routing for different user roles, including students, teachers, and admins.

## Project Structure

```
flutter_auth_project
├── lib
│   ├── controllers
│   │   └── auth_controller.dart
│   ├── middlewares
│   │   └── auth_middleware.dart
│   ├── models
│   │   └── users.dart
│   ├── routes
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── services
│   │   └── auth_services.dart
│   ├── views
│   │   ├── admin
│   │   │   └── admin_dashboard.dart
│   │   ├── auth
│   │   │   └── login_page.dart
│   │   ├── common
│   │   │   ├── selection_page.dart
│   │   │   └── welcome_page.dart
│   │   ├── guru
│   │   │   └── guru_dashboard.dart
│   │   └── siswa
│   │       └── siswa_dashboard.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## Features

- **Role-Based Authentication**: Users can log in as students, teachers, or admins, and are redirected to their respective dashboards.
- **GetX State Management**: Utilizes GetX for state management and dependency injection.
- **Middleware for Authentication**: Checks if the user is authenticated and redirects accordingly.

## Setup Instructions

1. **Clone the Repository**:
   ```
   git clone <repository-url>
   cd flutter_auth_project
   ```

2. **Install Dependencies**:
   Run the following command to install the required packages:
   ```
   flutter pub get
   ```

3. **Run the Application**:
   Use the following command to run the application:
   ```
   flutter run
   ```

## Usage

- Navigate to the login page to authenticate.
- After successful login, users will be redirected to their respective dashboards based on their roles.
- Admins, teachers, and students will have different functionalities available on their dashboards.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.