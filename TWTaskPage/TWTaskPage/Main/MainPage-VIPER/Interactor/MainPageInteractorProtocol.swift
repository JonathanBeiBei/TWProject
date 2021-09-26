//
//  MainPageInteractorProtocol.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/24.
//

import RxSwift

protocol MainPageInteractorProtocol {
    func requestTableDatas(requestParameters: [String: Any]?) -> Observable<ResponseModel?>
    func filterViaText(_ text: String, originalData: [DataModel]?) -> [DataModel]?
}
