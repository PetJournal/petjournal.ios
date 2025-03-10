# PetJournal #
 
### About App 
PetJournal is an iOS app built on SwiftUI that allows users to manage information about their pets, including vaccinations, veterinary appointments and other relevant information.

## 🎯 Tech Requirements ###
* Target deployment iOS 15.0
* Xcode Version 14.2 
* Swift 5

## 🏛️ Project Architecture ###
* This project uses MVVM as architecture

## 📚 Packages
* Still under development.

##  Options for account creation and login.:

* Create account: email/password
* Login: 
```
johndoe@email.com 
```
```
Teste@123
```

## 🗂️ Project organization
### Commons Folder
This folder contains subfolders related to project helpers: Custom Classes, Extensions, Project Helpers.

```
Commons 
└───CustomViews
└───Enums
└───Extensions
└───Utils 
└───UIComponents
```
#### CustomViews
This folder contains subfolders, related to Custom views(ViewModifier), most of them are created to be reusable in more than one part or screen of the app.

#### Enums
This folder contains enumerations that will support application development.
Not related to the application itself, they are generally generic.

#### Extensions
This folder contains all the extensions. Default is: Type+Extensions.
Example: View+Extensions / Color+Extension

#### Utils
This folder contains files related to Project Utilities and constants used in the project.

#### UIComponents
This folder contains visual components reused on different screens during the project, components used only on a screen, can be created with a subview of the screen.

*more items can be added during the project as needed

### Features Folder
This folder contains application screen flow divided by main components, could contain subviews folders for its unique views.

### Models Folder
This folder contains the app models.

### Resources Folder
The Resources folder contains color, image, and font asset files. And project info.plist.

### Sources Folder
This folder contains application startup controller, contains user session control Session folder.

```
Sources:
└───AppStart
└───Session 
```
#### AppStart
Files related to the app's initialization.

#### Session
This folder contains files related to the user's session, login state, and user information keys.

## 💻 To Use (for test) ###

Use the command below to clone the repository, using the Mac terminal.

```
git clone https://github.com/PetJournal/petjournal.ios.git
```
Open the file petJournal.xcodeproj

![folderPetjournal](https://github.com/PetJournal/petjournal.ios/assets/79819229/58f4e8b8-5c33-4f6e-aeca-4e6b3534b2ea)


When opening the file, select the iPhone version you want. Then select the button similar to Play.

![play](https://github.com/PetJournal/petjournal.ios/assets/79819229/a78e383c-d57c-4e26-b7a7-b59a2ab00943)
> - ps1.: wait for the simulator to open
> - ps2.: Make sure Xcode Version 14.2 is installed.

## 🧠 Contribution 

- Marcylene Barreto /  [@Marbarret](https://github.com/Marbarret) - start: not found ~ until: 05/2023
- Daiane Gonçalves / [@daigoncalves14](https://github.com/daigoncalves14) - start: not found ~ until: 05/2023
- Rafael Seron / [@rafaseron](https://github.com/rafaseron) - start: 01/2025 ~ until: currently
- Giovanni Favorin / [@giovannifavorin](https://github.com/giovannifavorin) - start: 01/2025 ~ until: currently
- Rafael Melo / [@rafaelnmelo](https://github.com/rafaelnmelo) - start: 01/2025 ~ until: currently

#### Mentor 

- Junior Margalho / [@juniormargalho](https://github.com/juniormargalho) - start: not found ~ until: not found
