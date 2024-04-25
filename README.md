# dg-muscle-ios

효율적으로 비교하고 기록하여 점진적 과부하를 이루고 근 성장을 이루자는 목적의 프로젝트.

### [Introduction](https://judicious-hoof-33e.notion.site/dgmuscle-ios-a7162152c1594a09902d7d6c07da8bdd?pvs=74)

<div>
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/336a9f76-1897-4ff9-9955-a9b287f5577f" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/f38bd62b-52ad-442d-ada8-050c198996a4" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/c1e9dee3-7fdc-4b2f-9c59-cdc7b7488584" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/a0d03403-ffdf-4039-9d1e-c4a739263223" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/1c1838e7-8050-41c3-8f6c-4e93e17f6c76" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/b253ca7f-85b1-4fd1-a2c7-efb024fb15a4" width=200 />
  <img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/d0386438-5300-4511-98df-41dbb86390af" width=200 />
</div>

![RPReplay_Final1713610744-ezgif com-resize](https://github.com/donggyushin/dg-muscle-ios/assets/34573243/5067705b-f234-47f5-8ca8-df15cbf625ca)

## Architecture
![Architecture](https://github.com/donggyushin/dg-muscle-ios/assets/34573243/8dc77855-10d8-4b71-ab5d-2df01beaef2b)

### Entity
이들은 어플리케이션의 비지니스 객체입니다. 가장 일반적이고 코어한 데이터 및 규칙을 따릅니다. <br />
__예)__ DGUser, Exercise, History 등 어플리케이션의 메인 데이터 및 객체.

### Usecase
이 레이어에는 어플리케이션의 비즈니스 로직을 담당합니다. 현 프로젝트 내에서는 ViewModel 쪽에 주로 포함되어져서 UI 레이어와 겹치는 경우가 대부분이지만 Test 코드에서 검증하는 로직쪽이 실질적으로 이 레이어에 해당됩니다. 
필요시(비즈니스 로직이 공통적으로 필요하게 되어지는 경우)에 더 안쪽 레이어로 언제든지 옮겨질 수 있으며, 분리되기 쉬운 구조로 유지합니다.


### Interface Adapter
이 레이어는 Usecase, Entity 와 같은 내부 레이어와 데이터베이스나 프레임워크, UI와 같은 외부 레이어간의 데이터 조정을 위해 존재합니다. <br />
__예)__ Repository

### External
서버, 데이터베이스, 디바이스, 프레임워크와 같은 도구를 포함하는 가장 바깥쪽의 레이어입니다. 이 레이어는 내부 레이어에 영향을 주지 않으면서 쉽게 변경 될 수 있도록 의도되었습니다. <br />
__예)__ [dg-muscle-functions](https://github.com/donggyushin/dg-muscle-funcstions), SwiftUI, UIKit, File in Device

## Main Model

<img src="https://github.com/donggyushin/dg-muscle-ios/assets/34573243/4bd3b634-8100-4719-8ae7-e1c32389dc38" />

### Exercise

유저가 직접 등록하는 운동 모델. 이름과 운동을 통하여 발전시키고자 하는 타겟 부위를 담고 있음

### History

유저의 운동 기록 모델. Exercise Id 와 여러개의 Set가 모여서 하나의 Record를 이루고, 여러개의 Record가 모여서 그 날의 운동 기록을 구성.

### Concern

| Concern  | Purpose                                                                |
| -------- | ---------------------------------------------------------------------- |
| Auth     | 회원가입 및 로그인의 유저의 인증 관리                                  |
| History  | 유저의 운동일지 기록 추가, 수정, 삭제 및 UI                            |
| Exercise | 유저의 운동종목 추가, 수정, 삭제                                       |
| Setting  | 유저의 프로필 이미지 등록 및 닉네임 설정 등 그 외의 자잘한 기능들 포함 |

## CI

Github Action을 활용하여 메인 branch에 코드가 붙기전 빌드 및 테스트 케이스를 검증

## CD

Fastlane을 이용하여 배포 절차 간소화

1. 배포용 인증서 및 프로비저닝 프로파일을 Private Repository(storage: git)에 저장
2. match를 활용하여 storage로 부터 필요한 프로비저닝 프로파일 다운
3. 다운 받은 프로파일을 이용하여 앱 빌드
4. App Store Connect API 인증
5. 테스트 플라이트 배포
