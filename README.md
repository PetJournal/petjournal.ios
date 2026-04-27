# PetJournal 🐾

<p align="center">
  <img src="https://img.shields.io/badge/iOS-15.0+-blue.svg" alt="iOS Version">
  <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" alt="Swift Version">
  <img src="https://img.shields.io/badge/Xcode-14.2-blue.svg" alt="Xcode Version">
  <img src="https://img.shields.io/badge/SwiftUI-✓-green.svg" alt="SwiftUI">
</p>

## 📱 About

PetJournal is an iOS app built with SwiftUI that helps pet owners manage their pets' information, including vaccinations, veterinary appointments, and other important care details. Keep track of your furry friends' health and well-being all in one place.

## ✨ Features

- 🏠 **Home Dashboard**: Overview of upcoming tasks and pet information
- 🐕 **Pet Management**: Add, edit, and manage multiple pets
- 💉 **Vaccination Tracking**: Keep track of vaccination schedules
- 🏥 **Vet Appointments**: Schedule and manage veterinary visits
- 📋 **Task Management**: Set reminders for pet care activities
- 👤 **User Profile**: Manage account settings and preferences

## 🛠 Tech Stack

- **Platform**: iOS 15.0+
- **Language**: Swift 5
- **UI Framework**: SwiftUI
- **Architecture**: Clean Architecture + MVVM
- **Development Tool**: Xcode 14.2

## 🚀 Getting Started

### Prerequisites

- macOS with Xcode 14.2 or later
- iOS 15.0+ device or simulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/PetJournal/petjournal.ios.git
```

2. Open the project:
```bash
cd petjournal.ios
open petJournal.xcodeproj
```

3. Select your target device/simulator and run the project (⌘+R)

### Demo Account

For testing purposes, you can use:
- **Email**: `johndoe@email.com`
- **Password**: `Teste@123`

Or create a new account using email/password.

## 🏗 Architecture

This project follows **Clean Architecture** principles combined with **MVVM** pattern in the presentation layer, providing:

- **Separation of Concerns**: Each layer has specific responsibilities
- **Testability**: Easy to unit test business logic
- **Maintainability**: Clean code structure for long-term maintenance
- **Scalability**: Easy to add new features and modules

## 🗂️ Project Organization

The project follows Clean Architecture principles organized in the following layers:

```
petJournal/
├── App/                          # Application layer
├── Core/                         # Core/Infrastructure layer
├── Data/                         # Data layer
├── Domain/                       # Domain layer
├── Presentation/                 # Presentation layer (MVVM)
└── Preview Content/              # SwiftUI preview content
```

### App Layer
Contains application initialization and configuration files:
- `AppDelegate.swift` - Application lifecycle management
- `SceneDelegate.swift` - Scene lifecycle management
- `InitialActor.swift` - App initialization logic
- `Info.plist` - App configuration
- `LaunchScreen.storyboard` - Launch screen

### Core Layer
Contains shared infrastructure and utilities:

```
Core/
├── Extensions/                   # Shared extensions
├── Navigation/                   # Navigation logic
├── Network/                      # Network layer
├── Session/                      # User session management
├── Storage/                      # Data persistence
└── Utils/                        # Shared utilities
```

#### Extensions
- SwiftUI extensions (Alert, Color, Font, Image, TextField, View)
- UIKit extensions (UIColor, UIFont)
- Foundation extensions (String, URLSession)

#### Navigation
- Navigation routing and destination handling

#### Network
- Network manager and URL management
- API communication layer
- Network error handling

#### Session
- User session management
- Authentication state handling

#### Storage
- Cache management (Home, Pet, Task data)
- Keychain helper for secure storage
- UserDefaults utilities

#### Utils
- Validation utilities
- UIKit custom components

### Data Layer
Contains data access and external service implementations:

```
Data/
└── Services/
    ├── Auth/                     # Authentication services
    ├── Common/                   # Shared services
    ├── Pet/                      # Pet-related services
    └── Task/                     # Task-related services
```

### Domain Layer
Contains business logic and entities:

```
Domain/
├── Models/                       # Business entities
└── Repositories/                 # Repository interfaces
```

#### Models
- Core business entities (Pet, User, Task, etc.)
- Response models
- Validation models

### Presentation Layer
Contains UI components organized by feature using MVVM pattern:

```
Presentation/
├── Authentication/               # Auth-related screens
├── Common/                       # Shared UI components
├── Home/                         # Home screen
├── Pet/                          # Pet management screens
├── Profile/                      # User profile
├── TabBar/                       # Tab bar navigation
└── Task/                         # Task management screens
```

#### Common Components
- **Buttons**: Reusable button components
- **Enums**: UI-related enumerations (errors, states, fonts)
- **Forms**: Form components (text fields, selectors)
- **Navigation**: Custom navigation components (NavigationBar, TabBar)
- **Pickers**: Date and time picker components
- **Resources**: Assets, colors, fonts, icons, images
- **UI**: Shared UI components (alerts, loading views, blur views, skeleton views)
- **UIComponents**: XIB components

#### Feature Organization
Each feature follows MVVM pattern:
- **Views**: SwiftUI views
- **ViewModels**: Business logic and state management
- **Components**: Feature-specific UI components

*This architecture promotes separation of concerns, testability, and maintainability while keeping MVVM pattern in the presentation layer.*

## 🤝 Contributing

We welcome contributions! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines

1. Follow the existing code style and architecture patterns
2. Write unit tests for new features
3. Update documentation as needed
4. Ensure all tests pass before submitting PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

If you have any questions or need help, please open an issue on GitHub.

## 👥 Contributors

### Current Team
- **Rafael Melo** - [@rafaelnmelo](https://github.com/rafaelnmelo) (Jan 2025 - Present)

### Previous Contributors
- **Marcylene Barreto** - [@Marbarret](https://github.com/Marbarret) (Until May 2023)
- **Daiane Gonçalves** - [@daigoncalves14](https://github.com/daigoncalves14) (Until May 2023)
- **Giovanni Favorin** - [@giovannifavorin](https://github.com/giovannifavorin) (Jan 2025 - May 2025)
- **Rafael Seron** - [@rafaseron](https://github.com/rafaseron) (Jan 2025 - Dec 2025)
- **Junior Margalho** - [@juniormargalho](https://github.com/juniormargalho)

---

<p align="center">
  Made with ❤️ by the PetJournal Team
</p>
