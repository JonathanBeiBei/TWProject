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
//    private var images = [ImageModel]()
    
    var contentUpdated = PublishSubject<Void>()
//    var numberOfSections: Int { return 1}
//    var numberOfRows: Int { images.count }
    
    //MARK: - init method
    init(interactor: MainPageInteractor) {
        self.interactor = interactor
    }
    
    //MARK: - Private helper method
    private func loadData() {
//        interactor.getImages { [weak self] (imageModelList) in
//            guard let strongSelf = self else { return }
//            DispatchQueue.main.async {
//                strongSelf.images = imageModelList
//                strongSelf.contentUpdated.onNext(())
//            }
//        }
    }

    //MARK: - Public helper methods
    func initializeContentLoad() {
        loadData()
    }
    
//    func imageItem(forIndex index: Int) -> ImageModel {
//        guard images.indices.contains(index) else { fatalError("Invalid index passed") }
//        return images[index]
//    }
}
