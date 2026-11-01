# Block Puzzle - Architecture Documentation

## 1. Application Architecture Overview

Block Puzzle is engineered following **Feature-First** and **Clean Architecture** principles. The application separates pure business/domain logic from user interface rendering, state binding, and external infrastructure integrations.

The architecture is structured into distinct layers:

```
┌────────────────────────────────────────────────────────┐
│                   Presentation Layer                   │
│          (Features, Shared Widgets, Screens)           │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
┌────────────────────────────────────────────────────────┐
│                   State Bridge Layer                   │
│             (Riverpod Notifiers & Providers)           │
└───────────────┬────────────────────────┬───────────────┘
                │                        │
                ▼                        ▼
┌──────────────────────────────┐ ┌───────────────────────┐
│     Pure Game Engine Layer   │ │   Services / I/O      │
│ (Pure Dart, Zero UI / State) │ │ (Storage, Ads, Audio) │
└──────────────────────────────┘ └───────────────────────┘
```

---

## 2. Directory Responsibilities

The codebase organizes responsibilities into strictly delineated directories:

```
lib/
├── main.dart
├── app/
│   └── block_puzzle_app.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── errors/
├── game_engine/
│   ├── models/
│   ├── board/
│   ├── blocks/
│   ├── generator/
│   ├── scoring/
│   └── rules/
├── features/
│   ├── splash/
│   ├── home/
│   ├── game/
│   ├── levels/
│   ├── challenge/
│   ├── statistics/
│   ├── achievements/
│   ├── boosters/
│   ├── themes/
│   ├── settings/
│   ├── auth/
│   └── leaderboard/
├── services/
│   ├── storage/
│   ├── audio/
│   ├── ads/
│   └── supabase/
└── shared/
    ├── widgets/
    └── animations/
```

### `lib/app/`
- Responsible for top-level application initialization, root widget (`BlockPuzzleApp`), and global configurations (e.g., orientation locking, themes, top-level routes).

### `lib/core/`
- Centralized infrastructure common to the entire app:
  - `constants/`: Global strings, layout dimensions, timing values.
  - `theme/`: Material 3 design tokens, color schemes (`AppTheme`), typography.
  - `utils/`: Device helpers, formatting utilities.
  - `errors/`: Application failure representations and exceptions.

### `lib/game_engine/`
- The core puzzle mechanics implemented in **pure Dart**.
  - `models/`: Immutable domain models (grid cells, piece definitions, placements).
  - `board/`: Grid state representations, line/column clearance algorithms.
  - `blocks/`: Polyomino shape definitions and rotations.
  - `generator/`: Algorithmic block spawning and difficulty balancing.
  - `scoring/`: Score calculations, streak bonuses, combo multipliers.
  - `rules/`: Game-over detection, valid placement checking.

### `lib/features/`
- Feature-first modules containing presentation logic and screens.
- Each feature encapsulates its own controllers, screens, and feature-specific widgets (e.g., `features/game`, `features/settings`, `features/leaderboard`).

### `lib/services/`
- Infrastructure adapters for peripheral capabilities:
  - `storage/`: Local key-value and structured persistence.
  - `audio/`: Sound effects and background music playback.
  - `ads/`: Ad network SDK wrappers (e.g., banner, interstitial, rewarded).
  - `supabase/`: Remote backend connectivity for authentication and cloud sync.

### `lib/shared/`
- Universal UI elements shared across multiple features:
  - `widgets/`: Reusable buttons, dialogs, badges, cards.
  - `animations/`: Reusable particle systems, tween builders, transitions.

---

## 3. Dependency Decisions

### Current Installed Packages
- **`flutter_riverpod`**: Declarative state management and dependency injection.
- **`cupertino_icons`**: Standard iOS-style iconography.
- **`flutter_lints`**: Recommended community lint rules for idiomatic Dart code.
- **`flutter_test`**: Unit and widget test runner.

### Architectural Invariants
- **No Riverpod Code Generation**: Standard explicit Riverpod providers are utilized to avoid build latency, generated file clutter, and build-runner dependency friction.
- **No Premature Packages**: Packages for audio, databases, ads, and network are deferred to their designated implementation phases to keep build sizes minimal and compilation fast.

---

## 4. Riverpod Usage Strategy

Riverpod serves as the **unidirectional state bridge** connecting Flutter UI widgets to domain logic and background services:
1. **Separation of Concerns**: Riverpod does not live inside `game_engine`. The engine exposes pure Dart functions and immutable state representations.
2. **State Controllers**: Feature-level `Notifier` or `AsyncNotifier` classes listen to user actions, execute pure game engine methods, invoke storage/audio services, and publish new state.
3. **Selective Rebuilds**: Views consume state using `ref.watch(provider.select(...))` to eliminate unnecessary widget rebuilds during high-frequency puzzle interactions.

---

## 5. Game Engine Separation & Isolation

The game engine is the core intellectual property of the puzzle game and adheres to the following strict boundaries:
- **Zero Flutter Dependencies**: Does not import `package:flutter/widgets.dart` or any Flutter UI library.
- **Zero Framework Ties**: Does not import `flutter_riverpod`, `supabase_flutter`, or platform channels.
- **High Testability**: Can be executed entirely inside pure Dart unit tests without running headless device emulators or widget pump cycles.
- **Deterministic Simulation**: Given an identical initial seed and sequence of block placements, the game engine produces identical board states and scores.

---

## 6. Asset Management Policy

The repository maintains strict asset boundary hygiene:

1. **`BlockPuzzle_Asset_Library/` (Source Archive)**:
   - Dedicated external storage directory containing raw asset packs, raw audio archives, high-resolution source graphics, and font packages.
   - **Never imported into pubspec.yaml**.
   - **Never referenced directly by production code**.
   - Left completely untouched during Phase 01.

2. **`assets/` (Production Curated)**:
   - Destination directory for optimized, compressed, properly named game assets.
   - Files are curated and vendored here only during the dedicated Asset Integration Phase.
   - Only assets actively referenced in production code are placed in this directory and declared in `pubspec.yaml`.

---

## 7. Offline-First Development Strategy

Block Puzzle is fundamentally an offline-first casual mobile game:
- **Core Playability**: The puzzle engine, local high scores, level progression, and settings function without an internet connection.
- **Graceful Degradation**: If network connectivity is unavailable, remote features (global leaderboards, cloud saves) degrade silently while caching events locally.
- **No Network Blocking**: The game loop and UI rendering never block on network requests or remote latency.

---

## 8. Future Supabase Integration Boundaries

When Supabase is integrated in future phases:
- It will reside exclusively under `lib/services/supabase/`.
- All network models and database schemas will be adapted into domain models before reaching feature controllers.
- Domain rules and the pure game engine will never directly reference Supabase clients or auth sessions.
- Authentication tokens, session refreshes, and remote sync will be managed via dedicated Riverpod service providers.

---

## 9. Testing Structure

Quality assurance is structured across three tiers:

1. **Unit Tests (`test/unit/` & `test/game_engine/`)**:
   - Tests pure game engine rules, line clearing, combo calculations, and block generation algorithms with sub-second execution speeds.
2. **Widget Tests (`test/widget_test.dart`, `test/features/`)**:
   - Tests UI screen rendering, component states, and user interactions in isolation using `WidgetTester` and mock `ProviderScope` overrides.
3. **Integration Tests (`integration_test/`)**:
   - Validates complete end-to-end user journeys (e.g., launching app, playing game session, recording high score).

