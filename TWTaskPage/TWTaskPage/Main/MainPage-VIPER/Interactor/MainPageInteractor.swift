//
//  MainPageInteractor.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation
import Alamofire

class MainPageInteractor {
    
    private struct Constants {
        static let url = "https://cnodejs.org/api/v1/topics"
    }
    
    func obtainSelectedData(requestParameters: [String: Any]?, responseCompletion: @escaping  (_ responseModel: ResponseModel?) -> ()) {
        NetworkUtils<ResponseModel>().request(url: Constants.url,  requestParameters: requestParameters) { model in
            responseCompletion(model)
        }
    }
}
