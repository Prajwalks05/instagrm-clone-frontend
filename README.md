<<<<<<< HEAD
# 📸 Instagram Clone

A feature-rich Instagram clone built with Flutter, replicating the core functionality and user experience of the popular social media platform.

## ✨ Features

### 🔐 Authentication
- **Login Screen** - Secure user authentication
- **Signup Screen** - New user registration

### 📱 Core Functionality
- **Home Feed** - Browse posts from followed users
- **Create Posts** - Share photos with captions
- **Post Details** - View individual posts with comments
- **Search** - Discover new users and content
- **Profile** - View and manage user profiles
- **Stories** - View user stories
- **Reels** - Short video content (similar to Instagram Reels)

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.2+
- **Language**: Dart
- **State Management**: Built-in Flutter state management
- **HTTP Client**: http package for API calls
- **Image Handling**: image_picker, cached_network_image
- **Local Storage**: shared_preferences
- **Environment Variables**: flutter_dotenv
- **UI Components**: Material Design with custom styling

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  http: ^1.2.2
  flutter_dotenv: ^5.1.0
  shared_preferences: ^2.2.3
  file_picker: ^8.0.6
  cupertino_icons: ^1.0.8
  image_picker: ^1.1.2
  cached_network_image: ^3.4.1
  liquid_pull_to_refresh: ^3.0.1
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd instagram_clone
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   - Create a `.env` file in `assets/config/`
   - Add your API endpoints and configuration

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

*Screenshots will be added here showcasing the app's interface*

## 🏗️ Project Structure

```
lib/
├── components/          # Reusable UI components
├── screens/            # App screens
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── create_post_screen.dart
│   ├── post_detail_screen.dart
│   ├── profile_screen.dart
│   ├── search_screen.dart
│   ├── reels_screen.dart
│   └── story_view_screen.dart
├── services/           # API services and business logic
└── main.dart          # App entry point
```

## 🎯 Features in Detail

### Authentication System
- Secure login and registration
- Session management with shared preferences
- Form validation and error handling

### Social Media Features
- **Feed**: Infinite scroll with pull-to-refresh
- **Posts**: Image upload with captions
- **Stories**: Temporary content viewing
- **Reels**: Short-form video content
- **Search**: User and content discovery
- **Profiles**: User information and post galleries

### Image Handling
- Camera and gallery integration
- Image caching for optimal performance
- File picker for media selection

## 🔧 Configuration

### Environment Setup
Create `assets/config/.env` with your configuration:
```env
API_BASE_URL=your_api_url
API_KEY=your_api_key
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Instagram for the design inspiration
- Open source community for the packages used

## 📞 Support

If you have any questions or need help, please open an issue or contact the development team.

---

**Made with ❤️ using Flutter**
