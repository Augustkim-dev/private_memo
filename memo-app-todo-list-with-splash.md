# Flutter 메모장 앱 개발 To-Do 리스트

## 1. 프로젝트 생성 및 기본 구조 만들기
- Flutter 프로젝트 생성
  ```bash
  flutter create memo_app
  cd memo_app
  ```
- pubspec.yaml 파일에 필요한 패키지 추가
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    sqflite: ^2.3.0
    path: ^1.8.3
    intl: ^0.19.0  # 날짜 포맷팅용
    flutter_native_splash: ^2.3.5  # 스플래시 화면용
  ```
- 패키지 설치
  ```bash
  flutter pub get
  ```

## 2. 스플래시 화면 구현
- flutter_native_splash 패키지 설정 (pubspec.yaml에 추가)
- pubspec.yaml 파일에 스플래시 설정 추가
  ```yaml
  flutter_native_splash:
    color: "#FFFFFF"
    image: assets/splash_logo.png
    android: true
    ios: true
  ```
- 스플래시 이미지 준비 (assets/splash_logo.png)
- 스플래시 화면 생성 실행
  ```bash
  flutter pub run flutter_native_splash:create
  ```
- 또는 커스텀 스플래시 화면 구현 (lib/screens/splash_screen.dart)
  - 타이머를 사용하여 일정 시간 후 메인 화면으로 이동
  - 애니메이션 효과 추가 (페이드인, 스케일 등)
  - 초기 데이터 로딩 진행

## 3. 데이터베이스 설계
- SQLite 테이블 구조 설계
  ```sql
  CREATE TABLE memos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TEXT NOT NULL
  );
  ```
- 데이터베이스 헬퍼 클래스 구현 (lib/database/database_helper.dart)
  - 데이터베이스 초기화
  - CRUD 메서드 구현 (생성, 읽기, 수정, 삭제)

## 4. 메모 모델 클래스 만들기
- lib/models/memo.dart 파일 생성
- Memo 클래스 구현 (id, title, content, createdAt 필드)
- JSON 변환 메서드 구현 (toMap, fromMap)

## 5. 화면 설계 및 구현
- 화면 구성:
  - 스플래시 화면 (lib/screens/splash_screen.dart)
  - 목록 화면 (lib/screens/memo_list_screen.dart)
  - 입력 화면 (lib/screens/memo_add_screen.dart)
  - 상세 보기 화면 (lib/screens/memo_detail_screen.dart)
  - 수정 화면 (lib/screens/memo_edit_screen.dart)
- 앱 라우팅 설정 (lib/main.dart)
  - 초기 라우트를 스플래시 화면으로 설정

## 6. 목록 화면 기능 구현
- Scaffold 위젯으로 기본 화면 구성
- AppBar에 제목과 [새메모] 버튼 추가
- FutureBuilder와 ListView.builder로 메모 목록 표시
- 각 항목에 제목과 날짜 표시
- ListTile 클릭 시 상세 화면으로 이동 기능
- 상태 관리 (메모 추가/수정 후 목록 새로고침)

## 7. 입력 화면 기능 구현
- TextField 위젯으로 제목, 내용 입력 필드 구현
- 키보드 처리 (다음 필드로 이동, 키보드 숨기기 등)
- [저장하기] 버튼으로 데이터베이스에 저장 기능
- 입력 유효성 검사 (빈 제목/내용 처리)
- 저장 후 목록 화면으로 돌아가기 (Navigator.pop)

## 8. 상세 보기 화면 기능 구현
- 레이아웃 구성 (제목, 날짜, 내용 표시)
- AppBar에 [수정] 버튼 추가
- 메모 ID를 통해 데이터베이스에서 메모 정보 로드
- 날짜 포맷팅 (intl 패키지 활용)
- 수정 버튼 클릭 시 수정 화면으로 이동 기능

## 9. 수정 화면 기능 구현
- 입력 화면과 유사한 UI 구성
- 선택한 메모의 기존 데이터 불러와서 TextField에 표시
- 데이터 수정 및 저장 기능
- 저장 후 상세 화면으로 돌아가기
- 변경 사항이 없을 경우 처리

## 10. 전체 앱 테스트 및 디버깅
- 각 기능별 테스트:
  - 앱 시작 및 스플래시 화면 테스트
  - 메모 추가 테스트
  - 메모 조회 테스트
  - 메모 수정 테스트
  - 메모 삭제 테스트 (필요시)
- 화면 전환 테스트
- 데이터 유효성 테스트
- 다양한 입력 시나리오 테스트

## 11. UI/UX 개선
- 테마 및 색상 설정
- 폰트 스타일 적용
- 애니메이션 추가 (화면 전환, 리스트 아이템 등)
- 사용자 피드백 요소 추가 (저장 완료 메시지 등)
- 에러 처리 및 사용자 안내 메시지

## 12. 앱 최적화 및 완성
- 코드 리팩토링
- 성능 최적화 (불필요한 리빌드 방지)
- 앱 아이콘 설정
- 다크 모드 지원 (선택적)
- 실제 기기 테스트
