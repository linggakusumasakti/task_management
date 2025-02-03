# Task Management App

## Getting Started
This project is a Task Management application built using Flutter. Follow the instructions below to run the app on your local machine.

### Prerequisites
- Flutter SDK installed ([Flutter installation guide](https://flutter.dev/docs/get-started/install))
- Dart installed
- Android Studio or VS Code with Flutter extensions

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/task-management-app.git
   ```
2. Navigate to the project directory:
   ```sh
   cd task-management-app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the application:
   ```sh
   flutter run
   ```

## Architecture
The project follows the **BLoC (Business Logic Component) pattern** for state management, ensuring separation of concerns and maintainability.

- **Presentation Layer**: Contains UI components built with Flutter widgets.
- **Business Logic Layer**: Uses BLoC for managing state and events.
- **Data Layer**: Handles API calls, local storage, and database interactions.

## Libraries Used
- **flutter_bloc**: State management using BLoC pattern
- **http**: For handling API requests
- **sqflite**: SQLite database for local storage.
- **equatable**: Simplifies object comparisons in BLoC states
- **shared_preferences**: Local storage for saving user preferences
- **intl**: Date formatting and localization support
- **get_it**: Dependency injection for better code scalability.

## API Usage
The app uses a mock API from `reqres.in` for user authentication.

### Login
To log in, use the following credentials:
```json
{
    "email": "eve.holt@reqres.in",
    "password": "cityslicka"
}
```
### Endpoint:
```sh
POST https://reqres.in/api/login
```

## Features
- Task management with CRUD operations
- Task searching by title
- Task filtering by status
- Persistent local storage
- Authentication with mock API


