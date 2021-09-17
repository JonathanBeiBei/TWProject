//
//  HomePageWorker.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit
import Alamofire

let url = "https://cnodejs.org/api/v1/topics"

protocol HomePageWorkerProtocol {
    func obtainSelectedOneData(requestParameters: [String: Any]?, responseCompletion: @escaping  (_ responseModel: ResultData?) -> ())
}

class HomePageWorker {

}

extension HomePageWorker: HomePageWorkerProtocol {
    func obtainSelectedOneData(requestParameters: [String: Any]?, responseCompletion: @escaping  (_ responseModel: ResultData?) -> ()) {
        AF.request(url, method: .get, parameters: requestParameters).responseJSON { response in
            switch response.result {
            case .success(let responseDictionary):
                guard let result = responseDictionary as? [String: Any] else {
                    responseCompletion(nil)
                    return
                }
                let resultModel = result.object() as ResultData?
                print(resultModel)
                responseCompletion(resultModel)
            case .failure( _):
                responseCompletion(nil)
            }
        }
    }
}

