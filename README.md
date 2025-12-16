# TaskSync Mobile App (Flutter)

Flutter 기반 TaskSync 모바일 애플리케이션

---

## 🚀 시작하기

### 1. Flutter SDK 설치 확인

```bash
flutter --version
# Flutter 3.0 이상 필요
```

### 2. 패키지 설치

```bash
cd mobile-app
flutter pub get
```

### 3. Firebase 설정

#### FlutterFire CLI 사용 (권장)

```bash
# FlutterFire CLI 설치
dart pub global activate flutterfire_cli

# Firebase 자동 설정
flutterfire configure
```

프로젝트 선택 → Android 선택 → 완료

#### 수동 설정 (대안)

1. Part 1에서 다운로드한 `google-services.json` 파일을:
   - 위치: `android/app/google-services.json`에 배치

2. `lib/firebase_options.dart` 파일 수정:
   - Firebase 콘솔에서 받은 설정 값 입력

### 4. 앱 실행

```bash
# Android 에뮬레이터 또는 실제 기기 연결 후
flutter run
```

---

## 📁 프로젝트 구조

```
mobile-app/
├── lib/
│   ├── models/              # 데이터 모델
│   │   └── todo.dart
│   ├── providers/           # 상태 관리
│   │   ├── auth_provider.dart
│   │   └── todo_provider.dart
│   ├── screens/             # 화면
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   └── home_screen.dart
│   ├── widgets/             # 재사용 가능한 위젯 (Part 10에서 추가)
│   ├── services/            # 서비스 클래스 (필요시)
│   ├── utils/               # 유틸리티 (필요시)
│   ├── firebase_options.dart
│   └── main.dart
├── android/
│   └── app/
│       ├── build.gradle
│       └── google-services.json  # 추가 필요!
├── pubspec.yaml
└── README.md
```

---

## 🎯 현재 구현 상태 (Part 3 완료)

### ✅ 완료된 기능
- Flutter 프로젝트 기본 구조
- Firebase 연동 설정
- Provider 상태 관리
- Google 로그인/로그아웃
- 스플래시 스크린
- 로그인 화면
- 홈 화면 (기본 틀)

### 🚧 다음 단계 (Part 9~11에서 구현)
- Todo CRUD 기능
- Todo UI 컴포넌트
- Calendar 기능

---

## 🛠️ 기술 스택

- **Flutter 3.0+** - UI 프레임워크
- **Provider** - 상태 관리
- **Firebase Auth** - 인증
- **Cloud Firestore** - 데이터베이스
- **Google Sign In** - 소셜 로그인
- **Google Fonts** - 폰트 (Inter)
- **Table Calendar** - 캘린더 (Part 11에서 사용)

---

## 📝 중요 사항

### Firebase 설정 필수!

앱 실행 전에 꼭 해야 할 것:

1. **google-services.json** 파일 추가
   ```
   android/app/google-services.json
   ```

2. **firebase_options.dart** 설정 확인
   ```dart
   // lib/firebase_options.dart
   // FlutterFire CLI로 자동 생성하거나
   // 수동으로 Firebase 설정 입력
   ```

### 최소 요구사항

- **Android**: minSdkVersion 21 (Android 5.0)
- **Flutter**: 3.0.0 이상
- **Dart**: 3.0.0 이상

---

## 🔧 문제 해결

### Firebase 연결 안 됨
```bash
# FlutterFire CLI 재설정
flutterfire configure

# 또는 google-services.json 확인
# android/app/google-services.json 위치 확인
```

### 빌드 에러
```bash
# 캐시 클리어
flutter clean
flutter pub get
flutter run
```

### Google 로그인 안 됨
- Firebase Console → Authentication 확인
- Google 로그인 활성화 확인
- SHA-1 인증서 등록 (필요시)

---

## 📞 다음 단계

Part 3 완료! 다음은 Part 4: Vue 인증 구현입니다.

---

**Last Updated:** Part 3 완료
