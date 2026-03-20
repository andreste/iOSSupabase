# Claude Rules for MyTest

## Project Overview
SwiftUI iOS app using Supabase as backend. Tracks countries the user has visited.

## Architecture
- **Pattern**: MVVM
- **UI**: SwiftUI only — never use UIKit
- **State**: Use `@Observable` (iOS 17+) for environment objects; use `@MainActor` on all ViewModels
- **DI**: Protocol-based dependency injection — services are injected via `AppEnvironment`, not accessed through `ServiceContainer.shared` directly in views
- **Async**: Use Swift concurrency (`async/await`, `Task`) — no Combine unless already present

## Code Style
- Prefer `@Observable` over `ObservableObject` / `@Published` for new code
- Use `struct` for models; `final class` for services and ViewModels
- snake_case `CodingKeys` for Supabase column mapping
- Keep Views thin — no business logic in View files
- No force unwraps (`!`) unless absolutely unavoidable with a comment explaining why

## File Structure
```
MyTest/
  Models/       # Plain data structs
  Views/        # SwiftUI views only
  ViewModels/   # @MainActor classes
  Services/     # Protocols + implementations (Supabase, Geocoding, etc.)
  Config/       # Environment config
```

## Testing
- Unit test ViewModels by injecting mock services via the protocol
- Do not mock Supabase at the networking level — use protocol abstractions (e.g. `CountryService`)

## General Rules
- Read a file before editing it
- Do not add comments or docstrings to code you didn't change
- Do not add error handling for scenarios that can't happen
- Do not create new files unless necessary — prefer editing existing ones
- Do not over-engineer: solve the specific problem asked, nothing more
- Always handle errors gracefully and surface them via `errorMessage` on the ViewModel
