# CocktailApp

## Overview
CocktailApp is a simple SwiftUI app that displays a list of cocktails fetched from a remote URL. The project is built using the **MVVM** architecture and prioritizes **clean code**, **modularity**, and **testability**.

---

## Project Structure
- **CocktailApp** Folder with app logic and recources. Separeted to the followig folders:
  - **App**: The main entry point (`CocktailApp`).
  - **Models**: Contains the `Cocktail` data model, implementing `CocktailProtocol`.
  - **Views**: Contains the UI logic (`CocktailListView` and `CocktailListCellView`).
  - **ViewModels**: `CocktailListViewModel` connects the data layer to the views.
  - **Resources**: Includes `Assets`, `Info.plist`, and `CocktailsSecrets.xcconfig` for managing sensitive credentials.
  - **Utils**: Provides utilities like `ApiCredentials` to fetch credentials from the environment.

- **CocktailAppTests**: Folder with mock data and tests.

- **CocktailNetworking**: A separate static library for URL requests, including `CocktailAPI` and `CocktailDTO`.

---

## Architecture
- **MVVM (Model-View-ViewModel)**: Ensures separation of concerns, testability, and clean state management.
- **No Coordinators**: Due to the app’s simplicity (no navigation flows), coordinators are omitted.
- **CocktailNetworking** as separate static library while it has no dependencies and is lightweight, making it faster to compile and integrate into the app.
- **Separation of Data Models**:
  - `CocktailDTO` (Networking) and `Cocktail` (App) both implement `CocktailProtocol` for decoupling.
  - This separation adheres to the **Single Responsibility Principle**.

---

## Build with XcodeGen
The project uses **XcodeGen** for a clean and declarative setup. To generate the `.xcodeproj`:
- Run: `xcodegen generate`

This avoids committing `.xcodeproj` to version control, ensuring a clean repository.

---

## Credentials Management

### **Local Development**
Sensitive credentials (`USER_NAME`, `PASSWORD`) are stored in `CocktailsSecrets.xcconfig`:
```plaintext
USER_NAME = UNAME
PASSWORD = PASS
```

The app retrieves these and URL using `ApiCredentials` struct.

### **Best Practice: CI Integration**
- Store credentials in CI pipelines.

---

## Testing
Unit tests are provided for key components:
- **CocktailListViewModelTests**: Ensures correct data/error handling and API integration.
- **CocktailAPITest**: Validates networking logic and error handling with mocks.
- **CocktailDataModelsTests**: Validates data mapping.

---

## Secure Connection Policy
The app fetches data from an HTTP URL, requiring a modification to `Info.plist` to bypass App Transport Security (ATS):

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

#### API response example

    [ 
        {
            "id": "12560",
            "name": "Afterglow",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/vuquyv1468876052.jpg"
        }, 
        {
            "id": "12562",
            "name": "Alice Cocktail",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/qyqtpv1468876144.jpg"
        }, 
        {
            "id": "12862",
            "name": "Aloha Fruit punch",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/wsyvrt1468876267.jpg"
        } 
    ]