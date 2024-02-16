# RE
---
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/8062ad14-0d56-4fd9-aced-ff27b775e9f5" width="200" height="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/94fefd37-8654-4575-ac6b-cbbdf1f17187" width="200" heigth="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/8f768ba6-4139-495f-9245-7f0acd2431ae" width="200" height="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/ee8b2085-c4d3-4f99-8448-3bfb98dccf81" width="200" height="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b98a8b64-28b6-4562-bd5e-8908c250a122" width="200" height="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b76c24b5-4da1-4384-b018-2713e102df33" width="200" height="400">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b9e2d34b-1a54-4462-a5b2-c1062e96f397" width="200" height="400">



## 주요 기능 
- 회원가입, 로그인
- 게시물 업로드, 조회
- 해시태그
- 댓글, 좋아요

## 구현 기능
- 정규표현식을 이용한 email, password에 대한 유효성 검증 로직 구현
- RxSwift Input/Output패턴을 사용하여 이메일 검증, 중복 내용 확인, 회원가입 로직 구현
- JWT Token기반의 로그인 구현, AccessToken과 RefreshToken 만료 되었을 때 Interceptor를 활용한 retry구현
- Moya를 활용한 네트워크 모듈화
- MultipartForm/Data를 활용해 이미지를 포함한 게시물 업로드
- Cursor-based Pagination 구현
- KeyChain을 활용한 AccessToken과 RefreshToken 저장 


## 사용 기술 스택
- UIkit(codeBase UI), MVVM
- PhotosUI
- Moya
- RxSwift
- Snapkit, Kingfisher, IQKeyboardManager
 
## 작업환경
- 개발기간: 2023년 11월 18일 ~ 2023년 12월 22일( 일)
- 디자인 및 개발: 1인
- 최소 지원버전 15.0 이상

## 트러블 슈팅
### 1. `Generic`을 활용해 네트워크 코드 추상화 및 재사용성 증가
#### 문제상황
- 네트워크 요청을 위한 사용하는 API 종류가 많아지고 요청을 위한 함수가 너무 많이 생겨서 관리가 힘들었다.
#### 해결방법
- 라우터 패턴을 사용해서 서버와 통신하는 메서드들을 나눠주었습니다.
- 제네릭을 이용해 여러 네트워크 통신에서 사용되는 타입에 유연하게 대처하도록 처리했습니다.
```swift
func apiRequest<T: Decodable>(_ target: APIManager, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.testService.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkError.decodingFailed))
                }
            case .failure(let error):
                completion(.failure(NetworkError(rawValue: error.errorCode) ?? NetworkError.unownedError))
            }
        }
    }
```
