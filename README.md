# TaskSync Mobile App (Flutter)

**Firebase 기반의 실시간 일정 관리 애플리케이션**

TaskSync는 Flutter와 Firebase를 활용하여 개발된 모바일 일정 관리 앱입니다. Google 로그인을 통한 사용자 인증, Firestore를 이용한 데이터 실시간 동기화, 그리고 캘린더 뷰를 통한 직관적인 일정 관리 경험을 제공합니다.

---

## ✨ 주요 기능

* **🔐 사용자 인증 (Auth):** Google 계정을 이용한 안전한 로그인 및 로그아웃 기능을 지원합니다.
* **📝 일정 관리 (CRUD):** 할 일(Todo)을 추가, 수정, 삭제하고 완료 상태를 토글할 수 있습니다.
* **📅 캘린더 뷰 (Calendar):** 월별 캘린더 UI를 통해 날짜별 일정을 한눈에 확인하고 관리합니다.
* **☁️ 실시간 동기화 (Sync):** Firebase Cloud Firestore를 연동하여 모든 데이터가 실시간으로 서버에 저장되고 동기화됩니다.
* **🎨 직관적인 UI:** 사용자 편의성을 고려한 깔끔한 디자인과 다이얼로그(Dialog) 인터페이스를 제공합니다.

---

## 🛠️ 기술 스택 (Tech Stack)

| 구분 | 기술 | 설명 |
| :--- | :--- | :--- |
| **Framework** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | UI 및 비즈니스 로직 구현 |
| **Language** | ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | 애플리케이션 주요 언어 |
| **Backend** | ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=black) | Authentication (인증), Firestore (DB) |
| **State Mgt** | **Provider** | 효율적인 전역 상태 관리 |
| **IDE** | ![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84?style=flat&logo=android-studio&logoColor=white) | 통합 개발 환경 |

---

## 🔥 Firebase 설정 및 필수 파일 (Configuration Files)

이 프로젝트는 **Firebase 연동** 및 **배포(Release) 빌드**를 위해 아래의 설정 파일들이 필수적으로 포함되어야 합니다.

> **⚠️ 주의:** 보안상의 이유로 Git에 포함되지 않을 수 있는 파일들입니다. 프로젝트 실행 전 해당 경로에 파일이 존재하는지 반드시 확인해주세요.

| 파일명 | 위치 (Path) | 역할 및 설명 | 비고 |
| :--- | :--- | :--- | :--- |
| **google-services.json** | `android/app/` | **Android용 Firebase 설정 파일**<br>Project ID, Client ID 등 연동 정보 포함 | **누락 시 앱 실행 불가** |
| **firebase_options.dart** | `lib/` | **Flutter용 Firebase 설정 코드**<br>Dart 코드 레벨에서의 Firebase 초기화 담당 | CLI 자동 생성 파일 |
| **key.properties** | `android/` | **Keystore 설정 파일**<br>서명 키의 비밀번호 및 Alias 정보 저장 | **누락 시 Release 빌드 불가** |
| **upload-keystore.jks** | `android/app/` | **앱 서명 키 (Keystore)**<br>배포용 APK 생성을 위한 암호화 키 파일 | **누락 시 Release 빌드 불가** |

* `main.dart` 에서 firebase를 초기화합니다.
* `lib/providers/auth_provider.dart`에서 인증 구조를 확인할 수 있습니다.

---

## 🚀 설치 및 실행 가이드

### 1. Flutter SDK 설치 확인

```bash
flutter --version
# Flutter 3.0 이상 필요
```

### 2. 프로젝트 클론 및 이동

```bash
git clone [GitHub repository 주소]
cd todo-app-mobile
```

### 3. 패키지 설치

```bash
flutter pub get
```

### 4. 보안 파일 확인 (필수!)

위의 [🔥 Firebase 설정 및 필수 파일] 섹션을 참고하여 google-services.json, key.properties, upload-keystore.jks 파일이 제 위치에 있는지 확인합니다. (해당 파일이 없으면 빌드 에러가 발생합니다.)


### 4. 앱 실행

```bash
# Android 에뮬레이터 또는 실제 기기 연결 후
flutter run
```

---

## 📱 APK 파일 직접 설치 방법
소스코드 빌드 없이, APK 파일을 사용하여 바로 테스트하실 수 있습니다.

```
- Android Emulator를 실행합니다.

- 제출된 app-release.apk 파일을 마우스로 드래그하여 에뮬레이터 화면 위에 떨어뜨립니다(Drag & Drop).

- 설치가 완료되면 앱 목록에서 TaskSync 아이콘을 찾아 실행합니다.
```
---

## 📁 프로젝트 구조

```
todo-app-mobile/
├── lib/
│   ├── models/              # 데이터 모델
│   │   └── todo.dart
│   ├── providers/           # 상태 관리
│   │   ├── auth_provider.dart
│   │   └── todo_provider.dart
│   ├── screens/             # 화면
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   └── calendar_screen.dart  
│   ├── widgets/             # 재사용 가능한 위젯
│   │   ├── add_todo_dialog.dart
│   │   ├── edit_todo_dialog.dart
│   │   └── todo_item.dart 
│   ├── firebase_options.dart  # firebase 설정 코드
│   └── main.dart
├── android/
│   ├── app/
│   │   ├── build.gradle
│   │   ├── upload-keystore.jks # 암호화 키 파일 [필수!]
│   │   └── google-services.json  # firebase
│   └── key.properties              # [필수!] Key Config 설정 파일 (필수!)
├── pubspec.yaml
└── README.md
```

---

### 개발 환경 (Environment)
```bash
OS: Windows 10 / 11
Flutter SDK: 3.0.0 이상
Dart SDK: 3.0.0 이상
Min SDK Version: 21 (Android 5.0 Lollipop)
Target SDK Version: 33+
```

---

