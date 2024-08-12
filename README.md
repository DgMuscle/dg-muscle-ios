# dg-muscle-ios

효율적으로 비교하고 기록하여 점진적 과부하를 이루고 근 성장을 이루자는 목적의 프로젝트.

<details>
<summary> Update Third Party Libraries Acknowledgments </summary>

Install `swift-package-list`

```
brew tap FelixHerrmann/tap & brew install swift-package-list
```

Generate Settings.bundle

```
swift-package-list dg-muscle-ios.xcworkspace --output-type settings-bundle --requires-license --output-path dg-muscle-ios/resources
```

</details>

## Environment

- xcodes: 15.4
- ruby: 3.3.2(managed by rbenv)
- bundler: 2.5.9
- mise: 2024.7.4
- tuist: 4.22.0

## Tech

<table border="0">
 <tr>
    <td>SwiftUI</td>
    <td>Firebase Functions</td>
    <td>Combine</td>
 </tr>
  <tr>
    <td>UIKit</td>
    <td>Firestorage</td>
    <td>Swift Concurrency</td>
 </tr>
 <tr>
    <td>Tuist</td>
    <td>Remote Push Notification</td>
    <td>Swinject</td>
 </tr>
 <tr>
    <td>Github Action</td>
    <td>Widget Extension</td>
 </tr>
 <tr>
    <td>Fastlane</td>
 </tr>
</table>

### Basic Architecture

![image](https://github.com/DgMuscle/dg-muscle-ios/assets/34573243/a127df42-9f0c-41e5-b151-aebb86533973)

**프레젠테이션 계층**

- 뷰(View)와 뷰모델(ViewModel) 구성요소를 포함합니다.
- 사용자 인터페이스와 애플리케이션과의 상호작용을 관리합니다.
- 도메인 계층으로 요청을 보내고, 응답을 받아 사용자 인터페이스를 업데이트합니다.

**도메인 계층**

- 애플리케이션의 중심으로, 엔티티, 유즈케이스, 리포지토리 인터페이스를 포함합니다.
- 프레젠테이션 계층과 데이터 계층 사이의 매개체 역할을 하며, 비즈니스 로직과 작업을 정의합니다.
- 외부 영향으로부터 독립적으로 비즈니스 규칙과 기능이 올바르게 적용되도록 보장합니다.

**데이터 계층**

- 데이터 영속성 및 검색 작업을 관리합니다.
- API 서버로의 네트워크 요청 및 장치 파일 시스템을 통한 로컬 데이터 저장과 같은 외부 리소스와 인터페이스하는 리포지토리를 포함합니다.
- 도메인 계층에서 받은 지시에 따라 데이터를 가져오고, 저장하고, 업데이트하는 역할을 수행합니다.

**의존성 방향**

- 각 계층은 자신 바로 아래에 있는 계층에만 의존하게 하였습니다. 이는 관심사의 명확한 분리를 촉진합니다.
- 한 계층에서의 변경이 다른 계층에 최소한의 영향만 미치도록 합니다.

이 아키텍쳐는 각 구성요소간 책임을 명확히 구분함으로써 유지보수성과 테스트 가능성이 높은 애플리케이션을 만드는 데 도움을 주며, 소프트웨어 설계에서 SRP, DIP 원칙들을 준수합니다.

### Module Graph

<img width=750 src="https://github.com/user-attachments/assets/7ce436ce-ee71-4a02-8ba8-5b80c4a71ad3" />

### Features

| Feature  | Purpose                                                                |
| -------- | ---------------------------------------------------------------------- |
| Auth     | 회원가입 및 로그인의 유저의 인증 관리                                  |
| History  | 유저의 운동일지 기록 추가, 수정, 삭제 및 UI                            |
| Exercise | 유저의 운동종목 추가, 수정, 삭제                                       |
| My       | 유저의 프로필 이미지 등록 및 닉네임 설정 등 그 외의 자잘한 기능들 포함 |
| HeatMap  | 위젯 및 History 모듈에서 공통으로 사용될 히트맵 UI 관련 기능           |
| Friend   | 다른 유저들과의 Connection 구축                                        |
| Rapid   | Rapid API 를 이용한 Exercise DB 구축                                        |
| Weight   | Apple HealthKit 을 이용한 유저의 체중 관리 모듈                                        |

## CI/CD

- Github Action을 활용하여 메인 branch에 코드가 붙기전 빌드 및 테스트 케이스를 검증
- 배포용 인증서 및 프로비저닝 프로파일을 Private Repository(storage: git)에 저장
- match를 활용하여 storage로 부터 필요한 프로비저닝 프로파일 다운
- 다운 받은 프로파일을 이용하여 앱 빌드
- App Store Connect API 인증
- 테스트 플라이트 배포
