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
    
    var askContentObservable: Observable<ResponseModel?>?
    var shareContentObservable: Observable<ResponseModel?>?
    var filterContentUpdated = PublishSubject<[DataModel]?>()
    
    //MARK: - init method
    init(interactor: MainPageInteractorProtocol) {
        self.interactor = interactor
    }
}

extension MainPagePresenter: MainPagePresenterProtocol {

    func searchActions(_ text: String, originalData: [DataModel]?) {
        let datas = interactor?.filterViaText(text, originalData: originalData)
        self.filterContentUpdated.onNext(datas)
    }
    
    func loadDisplayContents(_ parameters: [String : Any]?) {
        let observable = interactor?.requestTableDatas(requestParameters: parameters)
        guard let tabKey = parameters?[RequestKey.Tab.rawValue] as? String else{
            return
        }
        switch tabKey {
        case TableType.AskType.rawValue:
            self.askContentObservable = observable
        case TableType.ShareType.rawValue:
            self.shareContentObservable = observable
        default:
            break
        }
    }
}
