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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
