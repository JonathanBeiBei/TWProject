//
//  MainPageInteractorMock.swift
//  TWTaskPageTests
//
//  Created by Beibei Zhu on 2021/9/24.
//

import Foundation
@testable import TWTaskPage

class MainPageInteractorMock: MainPageInteractorProtocol {
    
    let result = [
        DataModel(id: "1",
                  authorId: "11",
                  tab: "ask",
                  content: "askContentOne",
                  title: "askTitleOne",
                  lastReplyAt: "2021-09-22T09:30:30",
                  good: true,
                  top: true,
                  replyCount: 150,
                  visitCount: 120,
                  createTime: "2021-09-22T09:30:30",
                  author: Author(loginname: "autorNameOne", avatarUrl: "http://asdf")),
        DataModel(id: "2",
                  authorId: "22",
                  tab: "job",
                  content: "shareContentTwo",
                  title: "shareTitleTwo",
                  lastReplyAt: "2021-09-22T09:30:30",
                  good: true,
                  top: true,
                  replyCount: 250,
                  visitCount: 220,
                  createTime: "2021-09-22T09:30:30",
                  author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf"))
    ]
    
    let askResponseModel = ResponseModel(data: [
                                        DataModel(id: "3",
                                                  authorId: "33",
                                                  tab: "ask",
                                                  content: "askContentOne",
                                                  title: "askTitleOne",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 150,
                                                  visitCount: 120,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameOne", avatarUrl: "http://asdf")),
                                        DataModel(id: "4",
                                                  authorId: "44",
                                                  tab: "ask",
                                                  content: "shareContentTwo",
                                                  title: "shareTitleTwo",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 250,
                                                  visitCount: 220,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf")),
                                        DataModel(id: "5",
                                                  authorId: "55",
                                                  tab: "ask",
                                                  content: "jobContentTwo",
                                                  title: "jobTitleTwo",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 250,
                                                  visitCount: 220,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf"))])
    
    
    let shareResponseModel = ResponseModel(data: [
                                        DataModel(id: "3",
                                                  authorId: "33",
                                                  tab: "job",
                                                  content: "shareContentOne",
                                                  title: "askTitleOne",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 150,
                                                  visitCount: 120,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameOne", avatarUrl: "http://asdf")),
                                        DataModel(id: "4",
                                                  authorId: "44",
                                                  tab: "job",
                                                  content: "shareContentTwo",
                                                  title: "shareTitleTwo",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 250,
                                                  visitCount: 220,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf")),
                                        DataModel(id: "5",
                                                  authorId: "55",
                                                  tab: "job",
                                                  content: "jobContentTwo",
                                                  title: "jobTitleTwo",
                                                  lastReplyAt: "2021-09-22T09:30:30",
                                                  good: true,
                                                  top: true,
                                                  replyCount: 250,
                                                  visitCount: 220,
                                                  createTime: "2021-09-22T09:30:30",
                                                  author: Author(loginname: "autorNameTwo", avatarUrl: "http://asdf"))])
    
    func requestDatas(requestParameters: [String : Any]?, responseCompletion: @escaping (ResponseModel?) -> ()) {
        guard let tabKey = requestParameters?[RequestKey.Tab.rawValue] as? String else{
            return
        }
        switch tabKey {
        case TableType.AskType.rawValue:
            responseCompletion(askResponseModel)
        case TableType.ShareType.rawValue:
            responseCompletion(shareResponseModel)
        default:
            break
        }
    }
    
    func filterViaText(_ text: String, originalData: [DataModel]?) -> [DataModel]? {
        return result
    }
}
