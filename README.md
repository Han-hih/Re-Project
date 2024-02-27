
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/36b364b0-b274-463c-b70b-037368f7a487" width="75" height="75"> 

# RE 


> 여행 경험을 기록하고 공유하는 블로그 서비스

<img src="https://github.com/Han-hih/Re-Project/assets/109748526/8062ad14-0d56-4fd9-aced-ff27b775e9f5" width="130" height="300">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/8f768ba6-4139-495f-9245-7f0acd2431ae" width="130" height="300">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/ee8b2085-c4d3-4f99-8448-3bfb98dccf81" width="130" height="300">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b98a8b64-28b6-4562-bd5e-8908c250a122" width="130" height="300">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b76c24b5-4da1-4384-b018-2713e102df33" width="130" height="300">
<img src="https://github.com/Han-hih/Re-Project/assets/109748526/b9e2d34b-1a54-4462-a5b2-c1062e96f397" width="130" height="300">


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
- 네트워크 요청을 위한 사용하는 API 종류가 많아지고 요청을 위한 함수가 너무 많이 생겨서 관리가 힘들었습니다.
#### 해결방법
- Moy에서 제공하는 라우터 패턴을 사용해서 서버와 통신하는 메서드들을 나눠주었습니다.
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

### 2. ImageDownSampling
#### 문제상황
- 서버에 올리는 이미지 사이즈가 너무 커서 서버와 주고 받을 때 용량을 줄여야 했습니다.
#### 해결방법
- kCGImageSource를 이용해서 다운샘플링을 진행했습니다.
 <img width="1562" alt="c566eeb21b554f566353a4635fdb4468fa200dbbeecfb1c2829a152f527a2ba5" src="https://github.com/Han-hih/Re-Project/assets/109748526/7a7d96a7-f6e1-4bd7-8ceb-98fde9d1611f">
 
```swift
extension UIImage {
    func downSample(size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let imageSourceOption = [kCGImageSourceShouldCache: false] as CFDictionary
        let data = self.jpegData(compressionQuality: 0.1)! as CFData
        let imageSource = CGImageSourceCreateWithData(data, imageSourceOption)!
        
        let maxPixel = max(size.width, size.height) * scale
        let downSampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixel
        ] as CFDictionary
        
        let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
        
        let newImage = UIImage(cgImage: downSampledImage)
        print("original Image: \(self), resize: \(newImage)")
        return newImage
    }
}
```




