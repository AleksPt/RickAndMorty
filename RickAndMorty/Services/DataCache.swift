//
//  DataCache.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import Foundation

class DataCache {
    static let shared = DataCache()
    
    private let cache = NSCache<NSString, NSData>()
    
    private init() {}
    
    func setData(_ data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func getData(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
}
