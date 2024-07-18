//
//  NetwokManager.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let networkMonitor = NetworkMonitor.shared
    weak var delegate: HomeViewControlelrDelegate?
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL?, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard networkMonitor.isConnected else {
            delegate?.showNetworkError(isHidden: false)
            return
        }
        
        delegate?.showNetworkError(isHidden: true)
        
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let url else {
                return
            }
            
            if let cachedImage = DataCache.shared.getData(forKey: url.absoluteString) {
                DispatchQueue.main.async {
                    completion(.success(cachedImage))
                }
                return
            }
            
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DataCache.shared.setData(imageData, forKey: url.absoluteString)
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

// MARK: - APIEndpoint
extension NetworkManager {
    enum APIEndpoint {
        case baseURL(page: Int)
        case search(name: String)
        
        var url: URL {
            switch self {
            case .baseURL(let page):
                return URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
            case .search(let name):
                return URL(string: "https://rickandmortyapi.com/api/character/?name=\(name)")!
            }
        }
    }
}
