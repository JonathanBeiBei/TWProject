//
//  MainPageModel.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/23.
//

import Foundation


struct ResponseModel: Codable {
    let data: [DataModel]?
}

struct ItemModel: Codable {
    let id: String?
    let authorId: String?
    let tab: String?
    let content: String?
    let title: String?
    let lastReplyAt: String?
    let good: Bool?
    let top: Bool?
    let replyCount: Int?
    let visitCount: Int?
    let createTime: String?
    let author: AuthorModel?

    enum CodingKeys: String, CodingKey{
        case id, tab, content, title, good, top, author
        case authorId = "author_id"
        case lastReplyAt = "last_reply_at"
        case replyCount = "reply_count"
        case visitCount = "visit_count"
        case createTime = "create_at"
    }
}

struct AuthorModel: Codable {
    let loginname: String?
    let avatarUrl: String?

    private enum CodingKeys: String, CodingKey {
        case loginname
        case avatarUrl = "avatar_url"
    }
}