# RemoteRecruit - Job Browser App

A production-grade iOS application demonstrating a strict implementation of Clean Architecture, MVVM, and modern Swift 6 Concurrency. Built as a technical showcase for remote iOS engineering roles.

## 🚀 Setup & Installation
1. Clone this repository.
2. Open `RemoteRecruit.xcodeproj` in Xcode 15+.
3. Select an iOS Simulator target (iPhone 15 Pro or newer recommended).
4. Press `⌘ + R` to build and run the application.
5. To execute the test suite, press `⌘ + U`.

## 🏛 Architecture & Structural Integrity
This project utilizes a highly decoupled **Clean Architecture** approach, separating the codebase into three distinct layers to ensure scalability, testability, and separation of concerns.

### 1. Domain Layer (The Core)
- Contains pure business logic (`Entities`, `UseCases`, `Interfaces`).
- **Strict Purism:** The Domain layer contains **zero** imports of `Foundation`, `UIKit`, or `SwiftUI`. It relies strictly on the Swift Standard Library. Entities like `Job` are Plain Old Swift Objects (POSO), completely agnostic to how they are fetched or displayed.

### 2. Data Layer (The Infrastructure)
- Implements the protocols defined by the Domain layer.
- Uses **Data Transfer Objects (DTOs)** for JSON decoding, mapping network/local data structures into pure Domain entities before passing them upward, preventing network logic from leaking into business rules.
- Utilizes Swift `actor` for the repository implementation to guarantee thread-safe data access.

### 3. Presentation Layer (The UI)
- Built with **SwiftUI** and **MVVM**.
- **State Management:** Uses a finite `UIState` enum (`idle`, `loading`, `success`, `empty`, `failure`) instead of scattered boolean flags to eliminate conflicting UI states.
- **Search Optimization:** The `JobListViewModel` leverages Apple's `Combine` framework (`.debounce` and `.removeDuplicates`) to throttle search input, preventing unnecessary use-case executions on every keystroke.
- ViewModels wrap domain models into `JobItemViewModel` to handle UI-specific requirements (like `Identifiable` conformance) without polluting the core entities.

## 🧪 Testing & Coverage
- The business logic and presentation layers are heavily tested, easily exceeding the 70% coverage requirement.
- Because the architecture strictly adheres to Dependency Injection (DI) via protocol abstractions, the `JobListViewModel` is tested using a `MockSearchJobsUseCase`. This allows for instantaneous, synchronous testing of all UI states without relying on file I/O or network delays.

## 📝 Assumptions & Considerations
- **Data Source:** To demonstrate structural pipelines without the unreliability of public sandbox APIs, the app uses a bundled local JSON file (`jobs_mock.json`). The repository simulates minor asynchronous latency (`Task.sleep`) to demonstrate robust loading and shimmer states in the UI.
- **Concurrency:** Built entirely on modern native structured concurrency (`async/await`) mapped back to the Main thread via `@MainActor` for UI updates.
