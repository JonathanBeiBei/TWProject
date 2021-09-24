//
//  MainPagePresenter.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation
import RxSwift

class MainPagePresenter {
    
    //MARK: - Properties
    private let interactor: MainPageInteractorProtocol?
    
    var askContentUpdated = PublishSubject<ResponseModel?>()
    var shareContentUpdated = PublishSubject<ResponseModel?>()
    var filterContentUpdated = PublishSubject<[DataModel]?>()
    
    //MARK: - init method
    init(interactor: MainPageInteractorProtocol) {
        self.interactor = interactor
    }
}

extension MainPagePresenter: MainPagePresenterProtocol {
    
    func loadContents(_ parameters: [String : Any]?) {
        interactor?.requestDatas(requestParameters: parameters) { responseModel in
            guard let tabKey = parameters?[RequestKey.Tab.rawValue] as? String else{
                return
            }
            switch tabKey {
            case TableType.AskType.rawValue:
                self.askContentUpdated.onNext(responseModel)
            case TableType.ShareType.rawValue:
                self.shareContentUpdated.onNext(responseModel)
            default:
                break
            }
        }
    }
    
    func searchActions(_ text: String, originalData: [DataModel]?) {
        let datas = interactor?.filterViaText(text, originalData: originalData)
        self.filterContentUpdated.onNext(datas)
    }
}
