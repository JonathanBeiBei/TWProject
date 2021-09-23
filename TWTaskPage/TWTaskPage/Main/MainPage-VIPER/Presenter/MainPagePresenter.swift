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
    private let interactor: MainPageInteractor
    var askContentUpdated = PublishSubject<ResponseModel?>()
    var shareContentUpdated = PublishSubject<ResponseModel?>()
    
    //MARK: - init method
    init(interactor: MainPageInteractor) {
        self.interactor = interactor
    }
    
    //MARK: - Private helper method
    private func loadData(_ parameters: [String : Any]?) {
        interactor.obtainSelectedData(requestParameters: parameters) { responseModel in
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

    //MARK: - Public helper methods
    func initializeContentLoad(_ parameters: [String : Any]?) {
        loadData(parameters)
    }
}
