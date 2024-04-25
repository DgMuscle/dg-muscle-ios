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
