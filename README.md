## 프로젝트 리포트

```
프로젝트 진행 보고서입니다.
```
### 개요
- 목표 : 요구사항에 최대한 부합하도록 개발하며, 세밀하고 정교한 작업을 통해 높은 완성도를 달성.
- 사용 기술 : `SwiftUI`, `Alamofire`, `Combine`, `Kingfisher`, `Lottie-iOS`
- 기간 : 2025.01.18 - 2025.01.21

### 회고록
- 개인적으로 프로젝트를 진행하며 진행사항 및 정리한 것을 올린 위키입니다.
[프로젝트 위키](https://github.com/QuaRang1225/project-angkorlife/wiki)
  
### 주요 기능
<div align="left">
  <img src="https://github.com/user-attachments/assets/8bc94fd5-90e8-4a35-8fb5-9c79888eb417" width="150"/>
  <img src="https://github.com/user-attachments/assets/0300d074-f4a8-421f-bc73-671562817868" width="150"/>
  <img src="https://github.com/user-attachments/assets/3c393d14-7ce3-497e-838b-463bcdf67c21" width="150"/>
  <img src="https://github.com/user-attachments/assets/7209d8eb-70b3-4b57-8bc3-a064f57fa863" width="150"/>
  <img src="https://github.com/user-attachments/assets/67b5d55e-1856-4974-9f71-4b0fcfe8154a" width="150"/>
</div>

1.	타이머
2.	투표 참여자 리스트
3.	투표 참여자 프로필 캐러셀
4.	로그아웃
5.	새로고침 기능


### 성과 및 결과

1.	Alamofire를 활용한 네트워크 레이어 구현
- Alamofire를 활용해 서버 통신을 위한 네트워크 레이어 구현함.
- 구조
  - Client: API 요청을 처리하는 중앙 네트워크 클라이언트를 생성했으며, Alamofire.Session을 커스터마이징해 모니터링 추가함.
  - Monitor: 네트워크 상태 변화를 감지하기 위한 네트워크 모니터링 도구 설계.
  - Router: API 엔드포인트를 정리하고 요청을 관리하기 위한 라우터 설계.
  - APIService: 도메인별 비즈니스 로직을 분리해 클린 아키텍처 기반으로 설계함.
    
<img src="https://github.com/user-attachments/assets/ee784451-a708-4ee3-847d-3d6ca9a4c470" width="400"/>

2. 다중 콘텐츠 처리
- 투표 기능 개발 중, API 요청 시 성공과 실패에 따라 서로 다른 형식으로 응답을 주는 구조를 확인함.
  -	성공 시: 응답 데이터 없이 상태 코드 200만 반환함.
  -	실패 시: 상태 코드 400과 함께 JSON 형식으로 에러 코드 및 메시지를 반환함.
-	해결 아이디어
     - 상태 코드를 기준으로 성공/실패를 분기 처리해 통일된 방식으로 응답 처리함.
     - 성공 시: 빈 텍스트를 반환하도록 처리.
     - 실패 시: 상태 코드가 200~300 범위를 벗어날 경우, 응답 데이터를 디코딩해 에러 메시지를 반환.

-	코드 구현
```swift
static func requset(router:APIRouter)-> AnyPublisher<String,AFError> {
    return APIClient.shared.session
        .request(router)
        .validate(statusCode: 200..<300)
        .publishString()
        .tryMap { response -> String in
            guard let code = response.response?.statusCode else { return "" }
            switch code {
            case 200..<300:
                guard let value = response.value, value.isEmpty else { return "" }
                return value
            default:
                guard let data = response.data else { return "" }
                let error = try JSONDecoder().decode(ErrorMessage.self, from: data)
                return error.errorMessage
            }
        }
        .mapError { $0.asAFError ?? AFError.explicitlyCancelled }
        .eraseToAnyPublisher()
}
```
3.	3초마다 자동으로 넘어가는 투표 참여자 프로필 캐러셀

- 기본 SwiftUI의 TabView는 마지막 페이지에서 첫 페이지로 자연스럽게 이동하는 기능이 없음.
  
- 구현 요구사항
   -	커스텀 캐러셀을 구현해 마지막 페이지에서 첫 페이지로 부드럽게 이동하도록 설계.
	 -	3초마다 자동으로 페이지가 넘어가는 기능 추가.
- 캐러셀 로직
   -	양쪽 끝에 각각의 페이지를 추가해 페이지가 자연스럽게 순환하도록 설정함.
	    - 예: 1~4페이지일 경우, 1페이지 앞에 4페이지를 추가, 4페이지 뒤에 1페이지를 추가.
	 -	페이지 범위를 벗어난 경우, 자동으로 현재 페이지를 이동시킴.
	    -	예: 1페이지 전으로 이동 시 마지막 페이지로 이동, 마지막 페이지 후로 이동 시 첫 페이지로 이동.
	 -	타이머를 사용해 3초마다 다음 페이지로 자동 이동하도록 구현함.

### 미완료된 목표
[해당이슈](https://github.com/QuaRang1225/project-angkorlife/issues/5)

- 원래는 스크롤 시 자동으로 페이지가 중앙에 위치하도록 하는 스냅 스크롤링을 구현하려 했음.
- 구현은 완성했지만, 스크롤 시 타이머가 작동 중인 첫 번째 페이지에서 불완전한 움직임이 발견되었음.
- 해당 문제를 해결하기 위한 추가 시간이 필요했으나, 프로젝트 완료 기한 내 수정이 어렵다고 판단하여 기본적으로 제공되는 ScrollView를 사용하는 것으로 대체함.



### 느낀 점
```
프로젝트를 진행하면서, 작은 기능을 개발하더라도 세심한 주의가 필요하다는 것을 깨달았습니다.
무엇을 하든 차근차근 제대로 진행하는 것이 공부든 업무든 중요한 덕목이라는 생각이 들었습니다.
개인적인 사정으로 한 달 가량 개발을 쉬었었는데, 이번 과제를 통해 개발의 재미를 다시 한 번 느낄 수 있었고,
회사의 한정된 기능을 직접 개발하면서 작은 소속감을 느낄 수 있었습니다.
이런 과제를 진행할 기회를 주셔서 감사드리며, 앞으로 더 성장하는 개발자가 되겠습니다.
참고로, 미완료된 목표는 과제가 끝난 후에도 개인적으로 해결할 계획입니다.

감사합니다.
```
