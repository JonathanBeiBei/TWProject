//
//  LoadAndCacheImages.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/17.
//

import UIKit

let MomentsImagesPath = "/Documents/ImagesCache/"

class LoadAndCacheImages: NSObject {
    
    private struct Constant {
        static let PrefixCount = 15
        static let SuffixCount = 20
        static let TypeCount = 5
    }
    
    static let shard: LoadAndCacheImages = LoadAndCacheImages()
    var cache = NSCache<AnyObject, AnyObject>()
    func obtainImage(_ url: String, complete: @escaping (_ data: Data?, _ url: String) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            // firstly: obtain form Cache
            var data: Data? = self?.cache.object(forKey: self?.getImageName(filePath: url) as AnyObject) as? Data
            if let resultData = data {
                DispatchQueue.main.async {
                    complete(resultData, url)
                }
                return
            }
            // Second: obtain from local
            data = self?.readImageFromSandbox(fileName: url)
            if data != nil {
                DispatchQueue.main.async {
                    complete(data, url)
                }
                return
            }
            // last: download
            do {
                let imgUrl = URL(string: url)
                data = try Data(contentsOf: imgUrl!)
                DispatchQueue.main.async {
                    complete(data, url)
                }
                if data != nil {
                    // write to Cache
                    self?.whiteImageToCache(fileName: url, data: data!)
                    // write to local
                    self?.writeImageToSandbox(fileName: url, data: data!)
                }
                return
            } catch _ {
                return
            }
        }
    }
    
    // write to Cache
    private func whiteImageToCache(fileName: String, data: Data) {
        let key = self.getImageName(filePath: fileName)
        self.cache.setObject(data as AnyObject, forKey: key as AnyObject)
    }
    
    // write to local
    private func writeImageToSandbox(fileName: String, data: Data) {
        let path: String = NSHomeDirectory() + MomentsImagesPath
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path){
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let imagePath = path + getImageName(filePath: fileName)
        try? data.write(to: URL(fileURLWithPath: imagePath))
    }
    
    // find for local sandbox
    private func readImageFromSandbox(fileName: String) -> Data? {
        let fileManager = FileManager.default
        let imageName = getImageName(filePath: fileName)
        let urlsForDocDirectory = fileManager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent(MomentsImagesPath + imageName)
        
        do {
            let readHandler = try FileHandle(forReadingFrom:file)
            let data = readHandler.readDataToEndOfFile()
            return data
        } catch _ {
            return nil
        }
    }
    
    // generate image name via URL string
    private func getImageName(filePath: String) -> String {
        filePath.md5
    }
}
