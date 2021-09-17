//
//  HomePageEntity.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/15.
//

import UIKit



struct ResultData: Decodable {
    let data: [DataModel]?
}

struct DataModel: Decodable {
    let id: String?
    let author_id: String?
    let tab: String?
    let content: String?
    let title: String?
    let last_reply_at: String?
    let good: Bool?
    let top: Bool?
    let reply_count: Int?
    let visit_count: Int?
    let create_at: String?
    let author: Autor?
}

struct Autor: Decodable {
    let loginname: String?
    let avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case loginname
        case avatarUrl = "avatar_url"
    }
}
