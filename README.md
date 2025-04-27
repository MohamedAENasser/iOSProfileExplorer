# 📱 Mazaady Interview Task - iOS App

This iOS app was built as part of the Mazaady interview task. It includes a **profile screen**, **products listing**, **ads**, and **tags** display, all with search functionality, live countdown timers, and offline caching.

---

## 📐 Architecture Decisions

- **UIKit + MVVM**  
  - The app follows the **MVVM (Model-View-ViewModel)** design pattern, which separates UI components from business logic for better maintainability and testability.
  - **ViewModels** handle data and logic, while **ViewControllers** focus on UI rendering.

- **Protocol-Oriented Programming**  
  - Used protocols to define API services and ViewModel interfaces, improving modularity and making it easier to swap or mock implementations for testing or future updates.

- **Networking Layer**  
  - A custom `APIService` is used for all network requests, based on `URLSession` and handling generic Codable response models.
  - Simple error handling is implemented, with failure cases falling back to cached data where applicable.

- **Offline Caching**  
  - `CacheService` is implemented to store and load data from `UserDefaults` for **Products**, **Ads**, and **Tags**.
  - This caching allows the app to display previously fetched data when the device is offline or when an API request fails.

- **Search Implementation**  
  - A live search functionality is implemented to filter products based on a user-entered search term, which updates dynamically as the user types.
  - This uses the ViewModel to filter products in real-time.

- **Countdown Timer**  
  - Each product includes a countdown timer that dynamically updates based on its end date.
  - The countdown is shown as a string and updates regularly while the app is active.

- **Tab Bar Navigation**  
  - The app uses a native `UITabBarController` to navigate between different sections of the app: Profile, Products, Ads, and Tags.

- **Responsive Grid Layout**  
  - The **Products List** is displayed in a **three-column grid** using `UICollectionView`. This layout adapts to different screen sizes.
  - The product cell includes an image, name, price, countdown timer, and special offer label.

---

## 🚀 How to Run the Project

1. Clone the repository:
    ```bash
    git clone https://github.com/your-repo/mazaady-ios-task.git
    ```

2. Open the project:
    ```bash
    cd mazaady-ios-task
    open MazaadyInterviewTask.xcodeproj
    ```

3. Build and run the project in Xcode:
   - Select a simulator (e.g., iPhone 14).
   - Press **Cmd + R** or click the "Run" button.

---

## ⚙️ Requirements

- iOS 15.0+
- Xcode 15+
- Swift 5.8+

---

## ⚖️ Trade-offs & Assumptions

| Area | Decision/Assumption |
|:-|:-|
| **Persistence Layer** | `UserDefaults` is used for caching due to simplicity and performance needs. For more complex data, CoreData or Realm would be ideal, but wasn't required for this task. |
| **Networking Layer** | The networking layer is lightweight and handles API calls directly with basic error management. No external libraries like Alamofire are used, making it simple to extend. |
| **UI Framework** | Only **UIKit** is used (no SwiftUI), as it was required for this task. |
| **Offline Caching** | Cached data is stored in `UserDefaults`, which is simple and sufficient for the scope of the task. |
| **Search Functionality** | Search is done locally on the client-side by filtering the product list in the ViewModel, as no pagination or server-side filtering was required for this task. |
| **Countdown Timer** | The countdown uses a simple `Timer` to update the UI every second. For better performance, especially in a large-scale app, more sophisticated time management might be necessary. |
| **No Advanced Error Handling** | Only basic error handling is implemented. More sophisticated user-facing error messages or retry mechanisms could be added in a production environment. |

---

## 🧩 Potential Future Enhancements

- **Network Pagination**: For large product datasets, implement pagination to avoid loading too much data at once.
- **Error Handling Enhancements**: Show user-friendly error messages and retry options when the app encounters issues.
- **Unit Tests**: Add unit tests to verify the behavior of ViewModels and network calls.
- **Multiple Environment Support**: Switch between staging and production environments dynamically.
- **Localization**: Currently not implemented, but the app can easily be made ready for multiple languages by adding `Localizable.strings`.

