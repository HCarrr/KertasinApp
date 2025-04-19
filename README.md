# Kertasin App
Aplikasi Kertasin adalah aplikasi mobile berbasis Flutter untuk pencatatan invoice digital dan pencatatan keuangan yang lebih efisien untuk usaha seperti Toko/Agen Sembako. Aplikasi ini mendukung autentikasi pengguna dengan Firebase dan menyediakan antarmuka yang ramah pengguna.

## Cara Instalasi dan Menjalankan Aplikasi
1. Clone Repository
- Buka terminal, ketik: ```git clone https://github.com/HCarrr/KertasinApp.git```
2. Instal Dependensi
- Pada terminal, Jalankan perintah: ```flutter pub get```
3. Jalankan Aplikasi
- Hubungkan perangkat atau jalankan emulator/simulator. Jalankan aplikasi dengan perintah: ```flutter run```
4. (Opsional) Untuk build release, jalankan perintah pada terminal:
- ```flutter build apk --release # Untuk Android```
- ```flutter build ios --release # Untuk iOS```

Note: Untuk login cepat via Google Sign In memerlukan SHA1 Key untuk didaftarkan pada firebase. Jika ingin ditest login melalui Google Sign In, bisa japri ke WA 08159827491 untuk didaftarkan SHA1 Key nya.

## Fitur dan Teknologi
Fitur Utama:
1. Autentikasi Pengguna: Registrasi, login, dan reset password menggunakan Firebase Authentication.
2. Antarmuka Responsif: Desain UI yang konsisten untuk semua halaman.
3. Manajemen Data: Pencatatan Biaya, History Invoice Pembelian, History Invoice Penjualan, Data Barang, Total Pengeluaran, Total Pemasukan.

## Teknologi yang Digunakan
- Flutter: Framework UI untuk pengembangan aplikasi lintas platform (Android dan iOS).
- Dart: Bahasa pemrograman untuk Flutter.
- Firebase:
  Firebase Authentication: untuk autentikasi pengguna.
  Firestore Database: Untuk penyimpanan data berbasis cloud.
- GetX: Manajemen state dan navigasi yang ringan.

## Struktur Folder
```
KertasinApp
├── .dart_tool
│   ├── dartpad
│   │   └── web_plugin_registrant.dart
│   ├── extension_discovery
│   │   └── vs_code.json
│   ├── flutter_build
│   ├── package_config.json
│   ├── package_config_subset
│   └── version
├── .flutter-plugins
├── .flutter-plugins-dependencies
├── .git
├── .gitignore
├── .metadata
├── .vscode
├── README.md
├── analysis_options.yaml
├── android
│   ├── .gitignore
│   ├── .gradle
│   │   ├── 8.3
│   │   │   ├── checksums
│   │   │   │   └── checksums.lock
│   │   │   ├── dependencies-accessors
│   │   │   │   ├── dependencies-accessors.lock
│   │   │   │   └── gc.properties
│   │   │   ├── executionHistory
│   │   │   │   ├── executionHistory.bin
│   │   │   │   └── executionHistory.lock
│   │   │   ├── fileChanges
│   │   │   │   └── last-build.bin
│   │   │   ├── fileHashes
│   │   │   │   ├── fileHashes.bin
│   │   │   │   ├── fileHashes.lock
│   │   │   │   └── resourceHashesCache.bin
│   │   │   ├── gc.properties
│   │   │   └── vcsMetadata
│   │   ├── buildOutputCleanup
│   │   │   ├── buildOutputCleanup.lock
│   │   │   ├── cache.properties
│   │   │   └── outputFiles.bin
│   │   ├── file-system.probe
│   │   ├── kotlin
│   │   │   ├── errors
│   │   │   └── sessions
│   │   └── vcs-1
│   │       └── gc.properties
│   ├── app
│   │   ├── build.gradle
│   │   ├── google-services.json
│   │   └── src
│   │       ├── debug
│   │       │   └── AndroidManifest.xml
│   │       ├── main
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── java
│   │       │   │   └── io
│   │       │   │       └── flutter
│   │       │   │           └── plugins
│   │       │   │               └── GeneratedPluginRegistrant.java
│   │       │   ├── kotlin
│   │       │   │   └── com
│   │       │   │       └── example
│   │       │   │           └── kertasinapp
│   │       │   │               └── MainActivity.kt
│   │       │   └── res
│   │       │       ├── drawable
│   │       │       │   ├── background.png
│   │       │       │   └── launch_background.xml
│   │       │       ├── drawable-hdpi
│   │       │       │   ├── ic_launcher.png
│   │       │       │   └── splash.png
│   │       │       ├── drawable-mdpi
│   │       │       │   ├── ic_launcher.png
│   │       │       │   └── splash.png
│   │       │       ├── drawable-v21
│   │       │       │   ├── background.png
│   │       │       │   └── launch_background.xml
│   │       │       ├── drawable-xhdpi
│   │       │       │   ├── ic_launcher.png
│   │       │       │   └── splash.png
│   │       │       ├── drawable-xxhdpi
│   │       │       │   ├── ic_launcher.png
│   │       │       │   └── splash.png
│   │       │       ├── drawable-xxxhdpi
│   │       │       │   ├── ic_launcher.png
│   │       │       │   └── splash.png
│   │       │       ├── mipmap-hdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-mdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxxhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── values
│   │       │       │   └── styles.xml
│   │       │       ├── values-night
│   │       │       │   └── styles.xml
│   │       │       ├── values-night-v31
│   │       │       │   └── styles.xml
│   │       │       └── values-v31
│   │       │           └── styles.xml
│   │       └── profile
│   │           └── AndroidManifest.xml
│   ├── build.gradle
│   ├── gradle
│   │   └── wrapper
│   │       ├── gradle-wrapper.jar
│   │       └── gradle-wrapper.properties
│   ├── gradle.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── local.properties
│   └── settings.gradle
├── assets
│   ├── icons
│   │   └── icGoogle.png
│   └── img
│       ├── iklan.png
│       ├── iklan2.svg
│       ├── ilustrationInvoice.png
│       ├── imgNews.jpg
│       ├── notif_bg.svg
│       ├── splashIcon.png
│       └── suu.svg
├── build
├── firebase.json
├── fonts
│   ├── MuseoModerno
│   │   ├── MuseoModerno-Bold.ttf
│   │   ├── MuseoModerno-ExtraBold.ttf
│   │   ├── MuseoModerno-Italic.ttf
│   │   ├── MuseoModerno-Light.ttf
│   │   ├── MuseoModerno-Medium.ttf
│   │   ├── MuseoModerno-Regular.ttf
│   │   └── MuseoModerno-SemiBold.ttf
│   └── Roboto
│       ├── Roboto-Bold.ttf
│       ├── Roboto-ExtraBold.ttf
│       ├── Roboto-Italic.ttf
│       ├── Roboto-Light.ttf
│       ├── Roboto-Medium.ttf
│       ├── Roboto-Regular.ttf
│       └── Roboto-SemiBold.ttf
├── ios
│   ├── .gitignore
│   ├── Flutter
│   │   ├── AppFrameworkInfo.plist
│   │   ├── Debug.xcconfig
│   │   ├── Generated.xcconfig
│   │   ├── Release.xcconfig
│   │   └── flutter_export_environment.sh
│   ├── Runner
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   ├── AppIcon.appiconset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── Icon-App-1024x1024@1x.png
│   │   │   │   ├── Icon-App-20x20@1x.png
│   │   │   │   ├── Icon-App-20x20@2x.png
│   │   │   │   ├── Icon-App-20x20@3x.png
│   │   │   │   ├── Icon-App-29x29@1x.png
│   │   │   │   ├── Icon-App-29x29@2x.png
│   │   │   │   ├── Icon-App-29x29@3x.png
│   │   │   │   ├── Icon-App-40x40@1x.png
│   │   │   │   ├── Icon-App-40x40@2x.png
│   │   │   │   ├── Icon-App-40x40@3x.png
│   │   │   │   ├── Icon-App-60x60@2x.png
│   │   │   │   ├── Icon-App-60x60@3x.png
│   │   │   │   ├── Icon-App-76x76@1x.png
│   │   │   │   ├── Icon-App-76x76@2x.png
│   │   │   │   └── Icon-App-83.5x83.5@2x.png
│   │   │   ├── LaunchBackground.imageset
│   │   │   │   ├── Contents.json
│   │   │   │   └── background.png
│   │   │   └── LaunchImage.imageset
│   │   │       ├── Contents.json
│   │   │       ├── LaunchImage.png
│   │   │       ├── LaunchImage@2x.png
│   │   │       ├── LaunchImage@3x.png
│   │   │       └── README.md
│   │   ├── Base.lproj
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── GeneratedPluginRegistrant.h
│   │   ├── GeneratedPluginRegistrant.m
│   │   ├── Info.plist
│   │   └── Runner-Bridging-Header.h
│   ├── Runner.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   │   ├── contents.xcworkspacedata
│   │   │   └── xcshareddata
│   │   │       ├── IDEWorkspaceChecks.plist
│   │   │       └── WorkspaceSettings.xcsettings
│   │   └── xcshareddata
│   │       └── xcschemes
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata
│   │       ├── IDEWorkspaceChecks.plist
│   │       └── WorkspaceSettings.xcsettings
│   └── RunnerTests
│       └── RunnerTests.swift
├── lib
│   ├── controllers
│   │   ├── barang
│   │   │   └── barang_controller.dart
│   │   ├── buttonController.dart
│   │   ├── home
│   │   │   ├── home_controller.dart
│   │   │   ├── productButtonController.dart
│   │   │   └── user_controller.dart
│   │   ├── invoice
│   │   │   ├── invoice_pembelian
│   │   │   │   ├── history_pembelian_controller.dart
│   │   │   │   ├── invoicePembelianController.dart
│   │   │   │   └── tambahInvoicePembelianController.dart
│   │   │   └── invoice_penjualan
│   │   │       ├── history_penjualan_controller.dart
│   │   │       ├── invoicePenjualanController.dart
│   │   │       └── tambahInvoicePenjualanController.dart
│   │   ├── loginController.dart
│   │   ├── profileController.dart
│   │   ├── registerController.dart
│   │   └── resetPasswordController.dart
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── model
│   │   ├── barang
│   │   │   └── barang_model.dart
│   │   ├── home
│   │   │   └── item_navbar_model.dart
│   │   └── invoice
│   │       └── history_pembelian
│   │           ├── history_pembelian_model.dart
│   │           └── history_penjualan_model.dart
│   ├── pages
│   │   ├── barang
│   │   │   ├── AddBarangDialog.dart
│   │   │   └── BarangPage.dart
│   │   ├── home
│   │   │   ├── HomeScreen.dart
│   │   │   └── bottomBar
│   │   │       └── item_navbar.dart
│   │   ├── invoice
│   │   │   ├── invoice_pembelian
│   │   │   │   ├── InvoicePembelianPage.dart
│   │   │   │   ├── TambahInvoicePembelianPage.dart
│   │   │   │   └── history_pembelian_page.dart
│   │   │   ├── invoice_penjualan
│   │   │   │   ├── InvoicePenjualanPage.dart
│   │   │   │   ├── TambahInvoicePenjualanPage.dart
│   │   │   │   └── history_penjualan_page.dart
│   │   │   └── widget
│   │   │       └── filter_item.dart
│   │   ├── login
│   │   │   └── LoginPage.dart
│   │   ├── main
│   │   │   └── main_page.dart
│   │   ├── pencatatanBiaya
│   │   │   └── pencatatanBiayaPage.dart
│   │   ├── print.dart
│   │   ├── profile
│   │   │   └── ProfilePage.dart
│   │   ├── register
│   │   │   └── RegisterPage.dart
│   │   └── reset_password
│   │       └── ResetPasswordPage.dart
│   ├── routes
│   │   ├── page_route.dart
│   │   └── route_name.dart
│   ├── todo.dart
│   ├── utilities
│   │   ├── assets_constants.dart
│   │   ├── colors.dart
│   │   └── typhography.dart
│   └── widgets
│       ├── AppbarDefault.dart
│       ├── ButtonCard.dart
│       ├── ButtonDefault.dart
│       ├── CardNews.dart
│       └── CustomeTextField.dart
├── linux
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── flutter
│   │   ├── CMakeLists.txt
│   │   ├── ephemeral
│   │   │   └── .plugin_symlinks
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   └── runner
│       ├── CMakeLists.txt
│       ├── main.cc
│       ├── my_application.cc
│       └── my_application.h
├── macos
│   ├── .gitignore
│   ├── Flutter
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   ├── GeneratedPluginRegistrant.swift
│   │   └── ephemeral
│   │       ├── Flutter-Generated.xcconfig
│   │       └── flutter_export_environment.sh
│   ├── Runner
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   └── AppIcon.appiconset
│   │   │       ├── Contents.json
│   │   │       ├── app_icon_1024.png
│   │   │       ├── app_icon_128.png
│   │   │       ├── app_icon_16.png
│   │   │       ├── app_icon_256.png
│   │   │       ├── app_icon_32.png
│   │   │       ├── app_icon_512.png
│   │   │       └── app_icon_64.png
│   │   ├── Base.lproj
│   │   │   └── MainMenu.xib
│   │   ├── Configs
│   │   │   ├── AppInfo.xcconfig
│   │   │   ├── Debug.xcconfig
│   │   │   ├── Release.xcconfig
│   │   │   └── Warnings.xcconfig
│   │   ├── DebugProfile.entitlements
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   └── Release.entitlements
│   ├── Runner.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   │   └── xcshareddata
│   │   │       └── IDEWorkspaceChecks.plist
│   │   └── xcshareddata
│   │       └── xcschemes
│   │           └── Runner.xcscheme
│   ├── Runner.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   └── xcshareddata
│   │       └── IDEWorkspaceChecks.plist
│   └── RunnerTests
│       └── RunnerTests.swift
├── pubspec.lock
├── pubspec.yaml
├── test
│   └── widget_test.dart
├── web
│   ├── favicon.png
│   ├── icons
│   │   ├── Icon-192.png
│   │   ├── Icon-512.png
│   │   ├── Icon-maskable-192.png
│   │   └── Icon-maskable-512.png
│   ├── index.html
│   ├── manifest.json
│   └── splash
│       └── img
│           ├── dark-1x.png
│           ├── dark-2x.png
│           ├── dark-3x.png
│           ├── dark-4x.png
│           ├── light-1x.png
│           ├── light-2x.png
│           ├── light-3x.png
│           └── light-4x.png
└── windows
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter
    │   ├── CMakeLists.txt
    │   ├── ephemeral
    │   │   └── .plugin_symlinks
    │   │       ├── cloud_firestore
    │   │       ├── firebase_auth
    │   │       └── firebase_core
    │   ├── generated_plugin_registrant.cc
    │   ├── generated_plugin_registrant.h
    │   └── generated_plugins.cmake
    └── runner
        ├── CMakeLists.txt
        ├── Runner.rc
        ├── flutter_window.cpp
        ├── flutter_window.h
        ├── main.cpp
        ├── resource.h
        ├── resources
        │   └── app_icon.ico
        ├── runner.exe.manifest
        ├── utils.cpp
        ├── utils.h
        ├── win32_window.cpp
        └── win32_window.h
```
