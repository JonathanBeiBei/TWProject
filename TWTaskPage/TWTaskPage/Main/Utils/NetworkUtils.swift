//
//  NetworkUtils.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation
import Alamofire
import RxSwift

class NetworkUtils<T: Codable> {

    func request(url: String, requestParameters: [String: Any]?) -> Observable<T?> {
        return Observable.create { observer in
            AF.request(url, method: .get, parameters: requestParameters).responseJSON { response in
                switch response.result {
                case .success(let responseDictionary):
                    guard let result = responseDictionary as? [String: Any] else {
                        observer.onNext(nil)
                        return
                    }
                    let resultModel = result.object() as T?
                    observer.onNext(resultModel)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
