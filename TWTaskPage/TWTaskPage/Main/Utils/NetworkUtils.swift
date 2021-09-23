//
//  NetworkUtils.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation
import Alamofire

class NetworkUtils<T: Codable> {
    
    typealias CompletionClosure = (_ model: T?) -> Void
    var completionClosure: CompletionClosure = { _ in }
    
    func request(url: String, requestParameters: [String: Any]?, responseCompletion: @escaping CompletionClosure) {
        AF.request(url, method: .get, parameters: requestParameters).responseJSON { response in
            self.completionClosure = responseCompletion
            switch response.result {
            case .success(let responseDictionary):
                guard let result = responseDictionary as? [String: Any] else {
                    responseCompletion(nil)
                    return
                }
                let resultModel = result.object() as T?
                self.completionClosure(resultModel)
            case .failure( _):
                self.completionClosure(nil)
            }
        }
    }
}
