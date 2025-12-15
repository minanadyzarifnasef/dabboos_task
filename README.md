# Follow-Up Manager App

Hey! This is a simple Flutter app I'm working on to manage follow-up tasks (like calls, meetings, visits). I built this to practice a clean, scalable architecture and some modern Flutter tools.

Just a heads up: I used some AI assistance to speed up the coding process and handle the boilerplate stuff so I could focus on the logic. It really helped cut down development time!

## 🚀 Features
- **View Follow-Ups**: See a list of tasks with details like status, customer name, and dates.
- **Filtering**: You can filter by status (Completed, Scheduled, etc.).
- **Search**: Search by title or customer name (with a nice debounce effect so it doesn't stutter).
- **Offline Mock**: If the network fails, it automatically falls back to some mock data so the app doesn't break.
- **Shimmer Loading**: Looks smooth while data is fetching.

## 🏗 Architecture
I went with a **Feature-First + Clean Architecture** approach. It keeps things organized, especially if the app grows later.

Structure looks roughly like this:
- `lib/core`: Shared stuff (Networking, Utilities, models).
- `lib/features/follow_up`: The main feature.
  - `data`: Models, Repositories (API logic).
  - `logic`: Cubits/Blocs for state management.
  - `ui`: Screens and Widgets.

## 🛠 Tech Stack
- **State Management**: `flutter_bloc` (Cubits).
- **Networking**: `dio` + `retrofit` for easy API calls.
- **Code Gen**: `freezed` and `json_serializable` (saves so much time on models/unions).
- **UI**: Custom widgets + `shimmer` for loading.

## 🏃‍♂️ How to Run
1. Clone the repo.
2. Run `flutter pub get`.
3. Since I'm using code generation, you might need to run:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Run the app on your emulator or device!

---
*Note: This project is a work in progress and while the architecture is solid, I'm still tweaking things here and there.*
