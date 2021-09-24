//
//  MainPagePresenterProtocol.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/24.
//

protocol MainPagePresenterProtocol {
    func loadContents(_ parameters: [String : Any]?)
    func searchActions(_ text: String, originalData: [DataModel]?)
}
