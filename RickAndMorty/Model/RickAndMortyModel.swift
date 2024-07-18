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
    // FIXME: Удалить свойство
    var episodeString: String {
        "Eart"
    }
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
}

// FIXME: Удалить мок
//extension RickAndMorty {
//    static func getMockData() -> [Character] {
//        let location = Location(name: "Earth")
//        
//        let result = [
//            Character(
//                name: "Rick Sanchez",
//                status: "Alive",
//                species: "Human",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Beth Smith",
//                status: "Alive",
//                species: "Human",
//                gender: "Female",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Mr. Poopybutthole",
//                status: "Alive",
//                species: "Sausage Fella",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Canklanker Thom",
//                status: "Dead",
//                species: "Alien",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Bill",
//                status: "Unknown",
//                species: "Animal",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Brad",
//                status: "Alive",
//                species: "Human",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//            Character(
//                name: "Glockenspiel Jerry",
//                status: "Alive (Immortal)",
//                species: "Robot",
//                gender: "Male",
//                location: location,
//                image: nil,
//                episode: nil
//            ),
//        ]
//        return result
//    }
//}
