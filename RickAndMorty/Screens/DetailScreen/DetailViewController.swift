//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
    }
    
    // MARK: - Public methods
    func configureSceen(item: Character?) {
        guard let item else { return }
        title = item.name
        detailView.setupView(
            image: .mockImg6,
            status: item.status,
            species: item.species,
            gender: item.gender,
            episodes: item.episodeString,
            location: item.location.name
        )
    }
}
