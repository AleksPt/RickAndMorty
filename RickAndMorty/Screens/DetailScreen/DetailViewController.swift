//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    private let networkManager = NetworkManager.shared
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
    }
    
    // MARK: - Public methods
    func configureScreen(item: Character?) {
        guard let item else { return }
        title = item.name
        fetchImage(from: item.image)
        setupEpisodes(character: item)
    }
    
    // MARK: - Private methods
    private func fetchImage(from url: URL) {
        networkManager.fetchImage(from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                detailView.imageView.image = UIImage(data: success)
                detailView.spinner.stopAnimating()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func fetchEpisode(from url: URL, closure: @escaping(Episode) -> Void) {
        networkManager.fetch(Episode.self, from: url) { result in
            switch result {
            case .success(let episode):
                closure(episode)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupEpisodes(character: Character) {
        var episodesStrings = [String]()
        let dispatchGroup = DispatchGroup()
        
        character.episode.forEach {
            dispatchGroup.enter()
            fetchEpisode(from: $0) { result in
                episodesStrings.append(result.name)
                dispatchGroup.leave()
                
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            detailView.setupView(
                status: character.status,
                species: character.species,
                gender: character.gender,
                episodes: episodesStrings.joined(separator: ", "),
                location: character.location.name
            )
        }
        
    }


}
