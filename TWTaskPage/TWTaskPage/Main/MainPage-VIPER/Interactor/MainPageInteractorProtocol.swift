//
//  MainPageInteractorProtocol.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/24.
//

import RxSwift

protocol MainPageInteractorProtocol {
    
    func requestDatas(requestParameters: [String: Any]?, responseCompletion: @escaping  (_ responseModel: ResponseModel?) -> ())
    
    func filterViaText(_ text: String, originalData: [DataModel]?) -> [DataModel]?
    
    func requestTableDatas(requestParameters: [String: Any]?) -> Observable<ResponseModel?>
}
