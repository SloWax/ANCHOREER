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


typealias MyResult = (Result<Data?, NSError>) -> Void


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
        return Observable<Data?>.create { [weak self] observer -> Disposable in
            self?.method(api: api) { result in
                switch result {
                case .success(let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func method(api: APIType, completion: @escaping MyResult) {
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
                    completion(.success(data))
                case .failure:
                    guard let error = self.handleError(response) else { return }
                    completion(.failure(error))
                }
            }
    }
    
    private func handleError(_ response: DataResponse<Data?, AFError>) -> NSError? {
        if let result = response.data, let error = try? JSONDecoder().decode(ErrorModel.self, from: result) {
            return NSError(domain: error.errorMessage, code: Int(error.errorCode) ?? 0)
        }
        return NSError(domain: "정의되지 않은 에러", code: 0)
    }
}
