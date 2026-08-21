# HamCore Open

Open-source Flutter client for **HamCore** radios — the FCC Part 97-legal LoRa mesh
firmware for US amateur radio operators ([github.com/tek126/hamcore](https://github.com/tek126/hamcore)).

HamCore Open is a fork of [MeshCore Open](https://github.com/zjs81/meshcore-open) by
**zjs81** (MIT License) — the mesh client architecture, transports, and UI are their
work. This fork adapts it to HamCore: US amateur band presets (33cm / 70cm), callsign
requirements, `HamCore-` device discovery, and plaintext-on-air awareness.

> ⚠️ **A US amateur radio license (Technician or higher) is required to transmit** with
> HamCore radios. Everything sent over the mesh is plaintext and publicly readable —
> that is a legal requirement (§97.113), not an oversight. Do not send anything private.

## Overview

HamCore Open is a cross-platform application for communicating with HamCore LoRa mesh
radios via Bluetooth Low Energy (BLE), USB serial, or TCP. The app enables long-range,
off-grid amateur radio communication through peer-to-peer messaging, public channels,
and mesh networking.

Upstream project website: [meshcoreopen.org](https://meshcoreopen.org/)

## Screenshots

<table>
  <tr>
    <td><img src="docs/screenshots/contacts.jpg" width="200"/><br/><p align="center"><b>Contacts</b></p></td>
    <td><img src="docs/screenshots/chat1.jpg" width="200"/><br/><p align="center"><b>Chat</b></p></td>
    <td><img src="docs/screenshots/chat2.jpg" width="200"/><br/><p align="center"><b>Reactions</b></p></td>
    <td><img src="docs/screenshots/map.jpg" width="200"/><br/><p align="center"><b>Map</b></p></td>
    <td><img src="docs/screenshots/channels.jpg" width="200"/><br/><p align="center"><b>Channels</b></p></td>
  </tr>
</table>

## Features

### Core Functionality

- **Direct Messaging**: Private encrypted conversations with individual contacts
- **Public Channels**: Broadcast messages to channel subscribers on the mesh network
- **Contact Management**: Organize contacts, track last seen times, and manage conversation history
- **Contact Groups**: Create custom groups to organize your mesh network contacts
- **Message Reactions**: React to messages with emoji responses
- **Message Replies**: Thread conversations with inline reply functionality

### Mesh Network

- **Path Visualization**: View routing paths and signal quality for each contact
- **Route Management**: Manual path overriding and automatic route rotation
- **Signal Metrics**: Real-time SNR (Signal-to-Noise Ratio) tracking
- **Node Discovery**: Automatic detection of nearby mesh nodes
- **Repeater Support**: Connect to and manage repeater nodes for extended range

### Map & Location

- **Live Map View**: Real-time visualization of mesh network nodes on an interactive map
- **Node Filtering**: Filter by node type (chat, repeater, sensor) and time range
- **Location Sharing**: Share GPS coordinates and custom markers with contacts
- **Offline Maps**: Download map tiles for offline use in remote areas (with [StadiaMaps](https://stadiamaps.com/pricing/) Free Subscription API-Key)
- **MGRS Coordinates**: Support for Military Grid Reference System coordinate format

### Device Management

- **BLE, USB, TCP Connection**: Scan and connect to HamCore devices via Bluetooth, USB or TCP
- **Device Settings**: Configure radio parameters, power settings, and network options
- **Battery Monitoring**: Real-time battery status with chemistry-specific voltage curves
- **Firmware Updates**: Over-the-air firmware updates via BLE (coming soon)

### Repeater Hub

- **CLI Access**: Full command-line interface to repeater nodes
- **Settings Management**: Configure repeater behavior, power limits, and network settings
- **Statistics Dashboard**: View repeater traffic, connected clients, and system health
- **Remote Management**: Administer repeaters from anywhere on the mesh network

## Technical Details

### Architecture

- **Framework**: Flutter 3.38.5 / Dart 3.10.4
- **State Management**: Provider pattern with ChangeNotifier
- **BLE Protocol**: Nordic UART Service (NUS) over Bluetooth Low Energy
- **Storage**: Local SQLite database for messages and contact data
- **Authentication, not encryption**: Ed25519-signed identities and keyed message authentication; content is plaintext on-air as required by FCC Part 97

### Platform Support

| Feature            | Android (API 21+) | iOS (12+) | Linux | Windows | macOS |                Web                |
|--------------------|:-----------------:|:---------:|:-----:|:-------:|:-----:|:---------------------------------:|
| BLE companion      | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| USB companion      | ✅                | 🚧        | ✅   | ✅      | ✅    | ✅                                |
| TCP companion      | ✅                | 🚧        | ✅   | ✅      | ✅    | ❌<br>(requires websocket bridge) |
| Core Functionality | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Mesh Network       | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Map & Location     | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Device Management  | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |
| Repeater Hub       | ✅                | ✅        | ✅   | ✅      | ✅    | ✅                                |

### Dependencies

| Package | Purpose |
|---------|---------|
| flutter_blue_plus | Bluetooth Low Energy communication |
| provider | State management |
| shared_preferences | Local key-value storage (scoped per device) |
| flutter_map | Interactive map display |
| latlong2 | Geographic coordinate handling |
| flutter_local_notifications | Background notification support |
| pointycastle | Cryptographic operations |
| llamadart | On-device LLM message translation |
| intl | Internationalization and date formatting |

## Getting Started

### Prerequisites

- Flutter SDK 3.38.5 or later
- Android Studio / Xcode (for mobile development)
- A LoRa device flashed with [HamCore firmware](https://github.com/tek126/hamcore)
- A US amateur radio license (Technician or higher) to transmit

### Just want the app?

- **Android (APK):** [kc2kvy.com/hamcore](https://kc2kvy.com/hamcore/)
- **iPhone (TestFlight):** [testflight.apple.com/join/3rjqusNP](https://testflight.apple.com/join/3rjqusNP) — install Apple's TestFlight app first
- **Browser (Chrome/Edge):** [kc2kvy.com/hamcore/web](https://kc2kvy.com/hamcore/web/)

### Installation (from source)

1. **Clone the repository**

   ```bash
   git clone https://github.com/tek126/hamcore-open.git
   cd hamcore-open
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── connector/
│   ├── meshcore_connector.dart  # BLE communication & state management
│   ├── meshcore_protocol.dart   # Protocol definitions & frame parsing
│   └── meshcore_uuids.dart      # Device names and IDs (add prefixes here!)
├── screens/
│   ├── scanner_screen.dart      # Device scanning (home screen)
│   ├── contacts_screen.dart     # Contact list
│   ├── chat_screen.dart         # Direct messaging
│   ├── channels_screen.dart     # Public channels
│   ├── map_screen.dart          # Network visualization map
│   ├── settings_screen.dart     # Device settings
│   └── repeater_hub_screen.dart # Repeater management
├── models/
│   ├── contact.dart             # Contact data model
│   ├── message.dart             # Message data structure
│   └── channel.dart             # Channel definitions
├── services/
│   ├── notification_service.dart      # Push notifications
│   ├── message_retry_service.dart     # Automatic message retry
│   ├── background_service.dart        # Background BLE connection
│   └── map_tile_cache_service.dart    # Offline map storage
└── storage/
    ├── message_store.dart       # Message persistence
    ├── contact_store.dart       # Contact database
    └── unread_store.dart        # Unread message tracking
```

## BLE Protocol

### Nordic UART Service (NUS)

- **Service UUID**: `6e400001-b5a3-f393-e0a9-e50e24dcca9e`
- **RX Characteristic**: `6e400002-b5a3-f393-e0a9-e50e24dcca9e` (Write to device)
- **TX Characteristic**: `6e400003-b5a3-f393-e0a9-e50e24dcca9e` (Notify from device)

### Device Discovery

Devices are discovered by scanning for BLE advertisements with known HamCore device name prefixes. These are currently:
    - `HamCore-`
    - `Whisper-`
    - `WisCore-`
    - `HT-`
    - `LowMesh_MC_`
    - `NRF52`

New device prefixes can be added in `lib/connector/meshcore_uuids.dart`.


### Message Format

Messages are transmitted as binary frames using a custom protocol optimized for LoRa transmission. See `meshcore_protocol.dart` for frame structure definitions.

## Configuration

### App Settings

- **Theme**: System default, light, or dark mode
- **Language**: Use one of 15 languages (English, Chinese, French, Spanish, Portuguese, German, Dutch, Polish, Swedish, Italian, Slovak, Slovene, Bulgarian, Russian, Ukrainian)
- **Notifications**: Configurable for messages, channels, and node advertisements
- **Battery Chemistry**: Support for NMC, LiFePO4, and LiPo battery types
- **Message Retry**: Automatic retry with configurable path clearing

### Device Settings

- **Radio Power**: Transmit power adjustment (10-30 dBm)
- **Frequency**: LoRa frequency configuration
- **Bandwidth**: Channel bandwidth selection
- **Spreading Factor**: Range vs. speed trade-off
- **Network ID**: Mesh network identifier

## Contributing

This is an open-source project. Contributions are welcome!

## Upstream

This project is a fork of [zjs81/meshcore-open](https://github.com/zjs81/meshcore-open) (MIT License).

### Development Guidelines

- Follow the Flutter style guide
- Use Material 3 design components
- Write clear commit messages
- Test on both Android and iOS before submitting PRs

### Code Style

- Prefer `StatelessWidget` with `Consumer` for reactive UI
- Use `const` constructors where possible
- Keep functions small and focused
- Avoid premature abstractions
- Run dart format on all changes before submitting

## Support

For issues, questions, or feature requests, please open an issue on GitHub:
<https://github.com/tek126/hamcore-open/issues>


## AI disclosure

HamCore is developed with substantial assistance from generative AI (Anthropic's
Claude, via Claude Code), directed, reviewed, and operated by a human maintainer.
AI-assisted commits carry a `Co-Authored-By: Claude` trailer in the git history.
The code is verified by automated tests and real hardware builds, but as with any
software — and especially anything bearing on FCC Part 97 compliance — review and
test it yourself before relying on it. This project is not legal advice.

## Acknowledgments

- Forked from [MeshCore Open](https://github.com/zjs81/meshcore-open) by zjs81 (MIT) — to support the upstream author, see their repo
- Companion firmware: [HamCore](https://github.com/tek126/hamcore), a fork of [MeshCore](https://github.com/meshcore-dev/MeshCore) by Scott Powell (ripplebiz)

- Built with [Flutter](https://flutter.dev/)
- Map tiles from [OpenStreetMap](https://www.openstreetmap.org/)
