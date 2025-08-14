# 변경 이력
## Private Memo 앱 - Android 15 마이그레이션

이 프로젝트의 모든 주요 변경사항은 이 파일에 문서화됩니다.

형식은 [Keep a Changelog](https://keepachangelog.com/ko/1.0.0/)를 기반으로 하며,
이 프로젝트는 [시맨틱 버저닝](https://semver.org/lang/ko/)을 준수합니다.

---

## [미출시] - 2025-08-14

### 🎯 계획된 변경사항
- Android API Level 35 (Android 15) 업데이트
- Flutter SDK 호환성 검증
- Java 버전 최적화 (21 → 17)
- 테스트 스위트 수정

---

## [1.12.01] - 2025-08-15

### ✨ 추가됨
- Android 15 (API Level 35) 지원
- Flutter 3.32.8 호환성
- 향상된 빌드 구성
- `/doc` 폴더에 포괄적인 문서

### 🔄 변경됨
- **Android 구성**
  - `compileSdkVersion`: Flutter 기본값 → 35
  - `targetSdkVersion`: Flutter 기본값 → 35
  - `minSdkVersion`: 21 (변경 없음)
  
- **Java 구성**
  - `sourceCompatibility`: JavaVersion.VERSION_21 → JavaVersion.VERSION_17
  - `targetCompatibility`: JavaVersion.VERSION_21 → JavaVersion.VERSION_17
  - `jvmTarget`: '21' → '17'

- **Flutter 구성**
  - SDK 제약: '>=3.2.3 <4.0.0' → '>=3.2.3 <4.0.0' (변경 없음, 3.32.8로 테스트됨)

### 🐛 수정됨
- `widget_test.dart`의 테스트 import 문제
  - `package:private_memo`를 `package:memo_app`으로 변경
- `memo_list_screen.dart`의 BuildContext 비동기 갭 경고
- Flutter analyze 경고 및 오류

### 🔧 기술 세부사항
- **Gradle 버전**: 8.10.2 (변경 없음)
- **Gradle 플러그인**: 8.1.0 (변경 없음)
- **Kotlin 버전**: 1.9.22 (변경 없음)
- **NDK 버전**: 27.0.12077973 (변경 없음)

---

## [1.0.1] - 2025-08-13

### 🔄 변경됨
- Gradle을 8.10.2로 업데이트
- Kotlin을 1.9.22로 업데이트
- Android Gradle 플러그인을 8.1.0으로 업데이트
- Java 버전을 21로 업그레이드

### 📝 커밋 이력
- `f30509d` - 패키지 업데이트
- `a63bf87` - gradle 1.9.22로 업그레이드
- `232b853` - 자바 버전 17 사용

---

## [1.0.0] - 2025-08-01

### ✨ 초기 릴리스 기능
- **핵심 기능**
  - 메모 생성, 읽기, 수정, 삭제
  - SQLite 로컬 데이터베이스 저장소
  - 제목 또는 내용으로 메모 검색
  
- **사용자 인터페이스**
  - Material 3 디자인 시스템
  - 로고가 있는 스플래시 화면
  - 확인과 함께 스와이프하여 삭제
  - 카드 기반 메모 목록
  - 지우기 버튼이 있는 검색 바
  
- **기술 스택**
  - Flutter SDK 3.2.3+
  - 싱글톤 패턴의 SQLite 데이터베이스
  - 상태 관리를 위한 Provider
  - Android 및 iOS용 커스텀 앱 아이콘
  - 네이티브 스플래시 화면 구성

### 📱 플랫폼 지원
- Android (minSdkVersion: 21)
- iOS
- 웹 (제한적 - 스플래시 화면 미지원)

### 📦 의존성
- `sqflite: ^2.3.3+1` - 로컬 데이터베이스
- `path: ^1.9.0` - 경로 작업
- `intl: ^0.20.2` - 날짜 포매팅
- `shared_preferences: ^2.5.3` - 사용자 설정
- `provider: ^6.1.4` - 상태 관리
- `flutter_svg: ^2.0.9` - SVG 지원
- `flutter_native_splash: ^2.3.10` - 네이티브 스플래시 화면

### 📝 커밋 이력
- `7005e61` - 검색기능 추가
- `332a996` - 안드로이드 작업이 너무 빡심

---

## 버전 이력 요약

| 버전 | 날짜 | 주요 변경사항 |
|------|------|-------------|
| 1.12.01 | 2025-08-15 | Android 15 지원, Flutter 3.32.8 호환성, 새 아이콘 |
| 1.0.1 | 2025-08-13 | 빌드 도구 및 Java 버전 업데이트 |
| 1.0.0 | 2025-08-01 | 핵심 기능이 포함된 초기 릴리스 |

---

## 마이그레이션 노트

### 1.0.x에서 1.12.01로
1. **Flutter SDK**: Flutter 3.32.8 이상 확인
2. **Java 버전**: JDK 17 권장 (이전에는 21 사용)
3. **Android Studio**: Android 15 지원을 위해 최신 버전으로 업데이트
4. **테스트**: 마이그레이션 후 모든 테스트 재실행
5. **빌드**: 클린 빌드 필요 (`flutter clean` 후 `flutter pub get`)

### 주요 변경사항
- 예상되는 주요 변경사항 없음, 철저한 테스트 권장

### 사용 중단 경고
- 이 릴리스에는 없음

---

## 링크
- [프로젝트 저장소](https://github.com/your-repo/private_memo)
- [이슈 트래커](https://github.com/your-repo/private_memo/issues)
- [Flutter 문서](https://docs.flutter.dev)
- [Android 15 문서](https://developer.android.com/about/versions/15)