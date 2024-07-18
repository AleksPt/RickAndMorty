//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

final class HomeViewControlelr: UIViewController {
    
    private let homeView = HomeView()
    // FIXME - датасорс изменить
    private let dataSource: [Character] = RickAndMorty.getMockData()

    // MARK: - Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.setDelegates(controller: self)
        title = "Rick & Morty Characters"
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
    }
}

// MARK: - UITableViewDataSource
extension HomeViewControlelr: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME - датасорс изменить
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableCell.description(),
            for: indexPath
        ) as? TableCell else {
            return UITableViewCell()
        }
        cell.configureCell(item: item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewControlelr: UITableViewDelegate {
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
        // FIXME - датасорс изменить
        detailVC.configureSceen(item: dataSource[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
