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
    
    func filterFromText(_ text: String, originalData: [DataModel]?) -> [DataModel]? {
        guard let modelArray = originalData else {
            return nil
        }
        if text.isEmpty  {
            return modelArray
        }
        return modelArray.filter { item in
            var filtered = false
            if let name = item.author?.loginname {
                filtered = name.uppercased().contains(text.uppercased())
            }
            if let title = item.title {
                filtered = title.uppercased().contains(text.uppercased()) || filtered
            }
            
            return filtered
        }
    }
}
