# PetJournal #
 
### About App 
PetJournal is an iOS app built on SwiftUI that allows users to manage information about their pets, including vaccinations, veterinary appointments and other relevant information.

## 🎯Tech Requirements ###
* Target deployment iOS 15.0
* Xcode Version 14.2 
* Swift 5

## 🏛️Project Architecture ###
* This project uses MVVM as architecture

## 📚Packages
* Still under development.

##  Options for account creation and login.:

* Email/Senha

## 🗂️Project organization
### Resources Folder
The Resources folder contains color, image, and font asset files. And project info.plist.

### Sources Folder
This folder contains application startup controller, contains user session control Session folder.
```
Sources:
└───Session 
AppDelegate
SceneDelegate
MainActor
```

```
### Session folder
This folder contains files related to the user's session, login state, and user information keys.
```

### Commons Folder
This folder contains subfolders related to project helpers: Custom Classes, Extensions, Project Helpers.
```
 Commons 
└───CustomView
└───Protocols
└───Utils 
└───UIComponent 
└───Enums
└───Extensions
```

### CustomView
This folder contains subfolders, related to Custom views(ViewModifier). Most of them are created to be reusable in more than one part or screen of the app.

### Protocols
This folder contains files that define important protocols and are reusable throughout the project. Other non-reusable protocols may be contained in the classes.

### Utils
This folder contains files related to Project Utilities and constants used in the project.

### UIComponent
This folder contains visual components reused on different screens during the project.
Components used only on a screen, can be created with a subview of the screen.

### Extensions
This folder contains all the extensions. Default is: Type+Extensions.
Example: View+Extensions / Color+Extension

### Enums
This folder contains enumerations that will support application development, but are not related to the application itself, they are generally generic.

*more items can be added during the project as needed

### Localizable
This folder contains files related to the application's language.

### Models
This folder contains the app models.

### Service
This folder contains implementation files for the API providers, allowing viewModels to call the API, services.

### Custom Views
This folder contains subfolders, related to Custom views (UIView, UIControls, UITableviewCell, UICollectionViewCells). Most of them are created to be reusable in more than one part or screen of the app.

### Features
This folder contains application screen flow according to the user's initial state, divided into Authenticated and UnAuthenticated.

```
└───Authenticated 
└───UnAuthenticated 
```

### Authenticated
This folder with user flow after due access in the application.
Folders have their exclusive use files. for example: ViewModel, Service, Subview
Obs.: Each screen has its subview folder with unique components.

```
Authenticated
└───Scenes 
└───TabBar 
```

### UnAuthenticated
This folder with the user flow before performing the proper access in the application.
Folders have their exclusive use files. for example: ViewModel, Service, Subview
Obs.: Each screen has its subview folder with unique components.

```
UnAuthenticated
└───ForgotPassword 
└───CreateAccount 
└───AccessAccount 
```

##  Contribution 

- Marcylene Barreto /  [@Marbarret](https://github.com/Marbarret)
- Nikolas Coelho [@nikolasgianoglou](https://github.com/nikolasgianoglou)

Left a team in: 24/05/2023
- Daiane Gonçalves / [@daigoncalves14](https://github.com/daigoncalves14)

## Mentor 🧠

- Junior Margalho / [@juniormargalho](https://github.com/juniormargalho)
