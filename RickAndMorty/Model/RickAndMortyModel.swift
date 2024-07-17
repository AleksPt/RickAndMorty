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
    // FIXME: Удалить опционал
    let episode: [URL]?
    // FIXME: Удалить свойство
    var episodeString = "Eart"
}

struct Location: Decodable {
    let name: String
}

struct Episode: Decodable {
    let name: String
}

// FIXME: Удалить мок
extension RickAndMorty {
    static func getMockData() -> [Character] {
        let location = Location(name: "Earth")
        let fileExtension = "pdf"
        
        let result = [
            Character(
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg1", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Beth Smith",
                status: "Alive",
                species: "Human",
                gender: "Female",
                location: location,
                image: Bundle.main.url(forResource: "mockImg2", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Mr. Poopybutthole",
                status: "Alive",
                species: "Sausage Fella",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg3", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Canklanker Thom",
                status: "Dead",
                species: "Alien",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg4", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Bill",
                status: "Unknown",
                species: "Animal",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg5", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Brad",
                status: "Alive",
                species: "Human",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg6", withExtension: fileExtension)!,
                episode: nil
            ),
            Character(
                name: "Glockenspiel Jerry",
                status: "Alive (Immortal)",
                species: "Robot",
                gender: "Male",
                location: location,
                image: Bundle.main.url(forResource: "mockImg7", withExtension: fileExtension)!,
                episode: nil
            ),
        ]
        return result
    }
}
