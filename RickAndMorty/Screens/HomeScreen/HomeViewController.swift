//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

protocol HomeViewControlelrDelegate: AnyObject {
    func showNetworkError(isHidden: Bool)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Private properties
    private let homeView = HomeView()
    private let networkManager = NetworkManager.shared
    private var rickAndMorty: RickAndMorty?
    private var character: Character?

    // MARK: - Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setDelegates(controller: self)
        homeView.retryButton.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        networkManager.delegate = self
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
        fetchData(from: NetworkManager.APIEndpoint.baseURL.url)
    }
    
    // MARK: - Private methods
    private func fetchData(from url: URL?) {
        networkManager.fetch(RickAndMorty.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                rickAndMorty = success
                homeView.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func didTapRetryButton() {
        fetchData(from: NetworkManager.APIEndpoint.baseURL.url)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = rickAndMorty?.results[indexPath.row] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.description(),
            for: indexPath
        ) as? CharacterCell else {
            return UITableViewCell()
        }
        cell.configureCell(item: item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.configureScreen(item: rickAndMorty?.results[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - HomeViewControlelrDelegate
extension HomeViewController: HomeViewControlelrDelegate {
    func showNetworkError(isHidden: Bool = false) {
        switch isHidden {
        case false:
            homeView.vStack.isHidden = false
            title = ""
        case true:
            homeView.vStack.isHidden = true
            title = "Rick & Morty Characters"
        }
    }
}
