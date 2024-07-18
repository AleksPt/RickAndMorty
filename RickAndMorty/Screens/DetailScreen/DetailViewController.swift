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
    func configureSceen(item: Character?) {
        guard let item else { return }
        title = item.name
        
        detailView.setupView(
            status: item.status,
            species: item.species,
            gender: item.gender,
            episodes: item.episodeString,
            location: item.location.name
        )
        
        networkManager.fetchImage(
            from: item.image) { [weak self] result in
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
}
