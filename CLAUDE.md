# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based memo (note-taking) application called `memo_app` that uses SQLite for local data persistence. The app features a splash screen, memo list, add/edit functionality, and search capabilities.

## Development Commands

### Essential Commands
```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Build for Android
flutter build apk
flutter build appbundle

# Build for iOS
flutter build ios

# Run tests
flutter test

# Analyze code for issues
flutter analyze

# Format code
dart format .

# Generate launcher icons (after modifying flutter_launcher_icons configuration)
flutter pub run flutter_launcher_icons

# Generate native splash screen (after modifying flutter_native_splash configuration)
dart run flutter_native_splash:create
```

## Architecture

### Database Layer
- **SQLite Integration**: Uses `sqflite` package with a singleton `DatabaseHelper` class (`lib/database/database_helper.dart`)
- **Table Structure**: Single `memos` table with fields: `id`, `title`, `content`, `created_at`
- **Pattern**: Singleton pattern ensures single database instance across the app

### Model Layer
- **Memo Model**: Located in `lib/models/memo.dart`, handles data serialization/deserialization
- **Data Flow**: Models use Map<String, dynamic> for database operations

### Screen Architecture
The app follows a screen-based architecture with each screen in `lib/screens/`:
- `splash_screen.dart`: Entry point with branding
- `memo_list_screen.dart`: Main screen showing all memos
- `memo_add_screen.dart`: Create new memos
- `memo_edit_screen.dart`: Modify existing memos
- `memo_detail_screen.dart`: View full memo content
- `memo_search_screen.dart`: Search functionality

### State Management
- Uses `Provider` package for state management across the app
- Direct database queries with `FutureBuilder` for async data loading

### Key Dependencies
- `sqflite`: Local database storage
- `path`: Path manipulation for database files
- `intl`: Date/time formatting
- `shared_preferences`: User preferences storage
- `provider`: State management
- `flutter_svg`: SVG image support
- `flutter_native_splash`: Native splash screen generation
- `flutter_launcher_icons`: App icon generation

## Testing Approach
- Widget tests are located in `test/` directory
- Run specific test: `flutter test test/widget_test.dart`
- The default test template needs updating to match actual app implementation

## Platform-Specific Notes
- Minimum Android SDK: 21 (set in flutter_launcher_icons config)
- Uses Material 3 design system
- App icons and splash screens are configured for both Android and iOS
- Assets located in `assets/` directory include app logo and splash images