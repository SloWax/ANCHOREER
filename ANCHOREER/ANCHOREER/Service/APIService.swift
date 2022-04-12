//
//  APIService.swift
//  ANCHOREER
//
//  Created by 표건욱 on 2022/04/10.
//

import Foundation
import RxSwift
import Alamofire
import Toast

typealias Success = (Data?) -> Void
typealias Failure = (ErrorModel) -> Void

protocol APIType {

    var path: String { get }

    var method: HTTPMethod { get }

    var headers: HTTPHeaders? { get }
    
    var parameter: Parameters? { get }
}

struct NaverHeader {
    static let id     = "X-Naver-Client-Id"
    static let secret = "X-Naver-Client-Secret"
}

struct NaverHeaderValue {
    static let id     = "BZo8f2uvyihNO5hauGS2"
    static let secret = "VZOqbE2eWT"
}


class APIService {
    static let shared = APIService()
    
    func request(api: APIType) -> Observable<Data?> {
        return Observable<Data?>.create { observer -> Disposable in
            Request.shared
                .method(api: api,
                        success: { data in
                    
                    observer.onNext(data)
                    observer.onCompleted()
                },
                        failure: { error in
                    observer.onError(NSError(domain: error.errorMessage, code: Int(error.errorCode) ?? 0))
                })
            
            return Disposables.create()
        }
    }
}


class Request {
    static let shared = Request()
    
    func method(api: APIType,
                success: @escaping Success,
                failure: @escaping Failure) {
        
        let alamofire = AF.request(api.path,
                                   method: api.method,
                                   parameters: api.parameter,
                                   encoding: URLEncoding.default,
                                   headers: api.headers)
        
        alamofire
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let data):
                    success(data)
                case .failure(let error):
                    self.handleError(response)
//                    failure(error)
                }
            }
    }
    
    private func handleError(_ response: DataResponse<Data?, AFError>) -> ErrorModel? {
        if let result = response.data {
            if let error = try? JSONDecoder().decode(ErrorModel.self, from: result) {
//                if !ignoreMessages.contains(error.message) {
//                    // 4040 (미니플레이어 종료시)
//                    error.code == 4040 ? print(error.code, error.message) : Toast(text: error.message).show()
//                }
                return error
            }
        }

//        Toast(text: "ToastDisconnect".localized()).show()
        return nil
    }
}
