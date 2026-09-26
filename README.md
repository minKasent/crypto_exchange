# Crypto Exchange Mobile App 📈

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-brightgreen?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

A high-performance, real-time cryptocurrency trading mobile application built with **Flutter**, **Dart**, and **Clean Architecture**. The app connects directly to live market data streams via **Binance WebSocket API**, providing real-time order books, dynamic price charting, portfolio tracking, and seamless trade execution UI.

---

## 📸 Key Features

- **⚡ Real-Time Market Data**: Live crypto price feeds and streaming order books powered by **Binance WebSockets**.
- **📊 Interactive Trading Charts**: Advanced candlestick and line charts with customizable timeframes and market indicators.
- **💼 Portfolio & Market Movers**: Live tracking of top gainers, losers, 24h trading volume, and total portfolio valuation.
- **⭐ Watchlist & Favorites**: Persistent token bookmarking with quick-access swipe actions (`flutter_slidable`).
- **🎨 Custom Theming & UI**: Dark/Light mode support with typography powered by Google Fonts (`Readex Pro`).
- **💾 Offline Persistence**: Local preference storage using `shared_preferences` and reactive state synchronization.

---

## 🏛 Clean Architecture & Project Structure

The project strictly adheres to **Clean Architecture** and separation of concerns:

```
lib/
├── components/          # Reusable UI widgets (AppButton, AppText, Styles)
├── core/                # Core configurations, constants, theme tokens, extensions
│   ├── constants/       # App colors, icons, asset paths
│   ├── enum/            # Trading & UI enums
│   ├── extensions/      # Context, string, number helper extensions
│   └── theme/           # Light & Dark theme definitions
├── models/              # Data models with JSON serialization (build_runner)
│   ├── coin.dart
│   └── order_book_model.dart
├── providers/           # Reactive state management (Provider pattern)
│   ├── home_provider.dart
│   ├── trade_provider.dart
│   ├── favorite_provider.dart
│   └── theme_provider.dart
├── repositories/        # Abstraction layer between data sources & business logic
│   ├── coin_repository.dart
│   ├── orderbook_repository.dart
│   └── favorite_repository.dart
├── routes/              # Declarative navigation & route definitions
├── screens/             # UI views & feature screens
│   ├── home_screen/     # Market movers, asset overview, portfolio card
│   ├── trade_screen/    # Buy/Sell order book, depth chart, quick execution
│   ├── trading_chart/   # Interactive candlestick chart view
│   ├── favorite/        # User watchlist & price alerts
│   ├── onboarding_screen/
│   └── setting_screen/
└── services/            # External services & I/O
    ├── binance_websocket_service.dart  # Low-latency WebSocket client
    └── storage_service.dart            # Local key-value store
```

---

## 🛠 Tech Stack & Dependencies

| Layer | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) (SDK ^3.7.0) & [Dart](https://dart.dev/) |
| **State Management** | [Provider](https://pub.dev/packages/provider) |
| **Realtime Streaming** | [web_socket_channel](https://pub.dev/packages/web_socket_channel) (Binance WebSocket API) |
| **Serialization** | [json_serializable](https://pub.dev/packages/json_serializable) & [build_runner](https://pub.dev/packages/build_runner) |
| **Persistence** | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| **Web & Charts** | [webview_flutter](https://pub.dev/packages/webview_flutter) |
| **UI Components** | [flutter_slidable](https://pub.dev/packages/flutter_slidable), [cupertino_icons](https://pub.dev/packages/cupertino_icons) |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.7.0 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode for device emulation
- VS Code or Android Studio with Flutter extensions

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/minKasent/crypto_exchange.git
   cd crypto_exchange
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run code generation (if modifying models):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application:**
   ```bash
   # Run on connected device or simulator
   flutter run
   ```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
