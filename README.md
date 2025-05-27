# Recipe Finder App 🍳

A Flutter application that helps users discover recipes based on ingredients they have available. Built with clean architecture principles and BLoC pattern for state management.

## Features ✨

- **Ingredient-based Recipe Search**: Find recipes based on ingredients you have
- **Interactive Checklists**: Track ingredients and equipment needed for recipes
- **Clean UI/UX**: Modern and intuitive user interface
- **Offline Support**: Basic functionality works without internet
- **Responsive Design**: Works on both mobile and tablet devices

## Architecture 🏗️

The app follows Clean Architecture principles with a clear separation of concerns:

### Layer Structure

1. **Presentation Layer**
   - UI Components
   - BLoC (Business Logic Components)
   - Pages/Screens
   - Widgets

2. **Domain Layer**
   - Entities
   - Use Cases
   - Repository Interfaces

3. **Data Layer**
   - Repository Implementations
   - Data Sources
   - Models

## State Management 🎮

The app uses the BLoC (Business Logic Component) pattern for state management:

- **BLoC**: Handles business logic and state management
- **Events**: User actions and system events
- **States**: UI states and data models

## API Integration 🌐

The app integrates with the Spoonacular API for recipe data:

- Recipe search by ingredients
- Recipe details and Ingredients
- Equipment requirements
- Step by Step Instructions

### API Key Setup

1. Get your API key from [Spoonacular](https://spoonacular.com/food-api)
2. Add to your environment variables:
```dart
const String SPOONACULAR_API_KEY = 'your_api_key';
```

## Getting Started 🚀

1. Clone the repository:
```bash
git clone https://github.com/yourusername/recipe_app.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Add your Spoonacular API key to the environment variables

4. Run the app:
```bash
flutter run
```

## Dependencies 📦

- **flutter_bloc**: State management
- **dio**: HTTP client for API calls
- **get_it**: Dependency injection
- **shared_preferences**: Local storage
- **flutter_dotenv**: Environment variables

## Acknowledgments 🙏

- [Spoonacular API](https://spoonacular.com/food-api) for recipe data
- [Flutter](https://flutter.dev) for the amazing framework
- [BLoC Pattern](https://bloclibrary.dev) for state management architecture
