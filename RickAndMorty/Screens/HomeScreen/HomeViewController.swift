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
    private var isLoadingMoreData = false
    private var currentPage = 1
    
    // MARK: - Private properties
    private let homeView = HomeView()
    private let networkManager = NetworkManager.shared
    private var rickAndMorty: RickAndMorty?
    private let searchController = UISearchController()
    private var filteredCharacter: [Character] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    // MARK: - Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        homeView.setDelegates(controller: self)
        homeView.retryButton.addTarget(
            self,
            action: #selector(didTapRetryButton),
            for: .touchUpInside
        )
        networkManager.delegate = self
        fetchData(from: NetworkManager.APIEndpoint.baseURL(page: currentPage).url)
    }
    
    // MARK: - Private methods
    private func fetchData(from url: URL?) {
        homeView.spinner.startAnimating()
        isLoadingMoreData = true
        networkManager.fetch(RickAndMorty.self, from: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                if let _ = rickAndMorty?.results {
                    rickAndMorty?.results += success.results
                } else {
                    rickAndMorty = success
                }
                homeView.tableView.reloadData()
                isLoadingMoreData = false
                homeView.spinner.stopAnimating()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func searchData(query: String) {
        networkManager.fetch(RickAndMorty.self, from: NetworkManager.APIEndpoint.search(name: query.lowercased()).url) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                filteredCharacter = success.results
                homeView.tableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
                
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [.foregroundColor: UIColor.white]
            )
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }

            textField.font = UIFont.TextFonts.NavigationBar.searchBarPlaceholder
            textField.textColor = .white
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Actions
    @objc private func didTapRetryButton() {
        fetchData(from: NetworkManager.APIEndpoint.baseURL(page: currentPage).url)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacter.count : rickAndMorty?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let character = isFiltering
                    ? filteredCharacter[indexPath.row]
                    : rickAndMorty?.results[indexPath.row]
        
        guard let character else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterCell.description(),
            for: indexPath
        ) as? CharacterCell else {
            return UITableViewCell()
        }
        cell.configureCell(item: character)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = isFiltering ? filteredCharacter[indexPath.row] : rickAndMorty?.results[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.configureScreen(item: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !isLoadingMoreData {
                fetchData(
                    from: NetworkManager.APIEndpoint.baseURL(
                        page: currentPage + 1
                    ).url
                )
                currentPage += 1
            }
        }
    }


}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        searchData(query: searchText)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.placeholder = nil
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.placeholder = "Search"
        }

}

// MARK: - HomeViewControlelrDelegate
extension HomeViewController: HomeViewControlelrDelegate {
    func showNetworkError(isHidden: Bool = false) {
        switch isHidden {
        case false:
            homeView.vStack.isHidden = false
            homeView.tableView.isHidden = true
            title = ""
        case true:
            homeView.vStack.isHidden = true
            homeView.tableView.isHidden = false
            title = "Rick & Morty Characters"
        }
    }
}
