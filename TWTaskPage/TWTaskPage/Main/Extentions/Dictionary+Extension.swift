//
//  Dictionary+Extension.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/16.
//


import Foundation

extension Dictionary {
    var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    var jsonString: String? {
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func object<T: Decodable>() -> T? {
        if let data = data,
            let obj = try? JSONDecoder().decode(T.self, from: data) {
            return obj
        } else {
            return nil
        }
    }
}

