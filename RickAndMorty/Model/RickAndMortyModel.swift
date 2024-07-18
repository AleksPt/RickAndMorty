//
//  RickAndMortyModel.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import Foundation

struct RickAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
}

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: URL
    let episode: [URL]
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
}
