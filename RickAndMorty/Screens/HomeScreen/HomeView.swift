//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let element = UITableView(frame: .zero)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.description())
        element.backgroundColor = .none
        return element
    }()
    
    private lazy var errorNetwokImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.image = Images.errorNetwork
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let errorNetworkTitle = LabelFactory.makeLabel(text: "Network Error", alignment: .center, font: UIFont.TextFonts.Error.Network.title)
    
    private let errorNetworkSubtitle = LabelFactory.makeLabel(
        text: "There was an error connecting. \n Please check your internet.",
        alignment: .center,
        font: UIFont.TextFonts.Error.Network.subtitle,
        color: UIColor.surfErrorNetworkSubtitle,
        numberOflines: 0
    )
    
    private let button = ButtonFactory.makePrimaryButton(title: "Retry")
    
    private lazy var vStackLabels: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 5
        element.distribution = .fillProportionally
        [
            errorNetworkTitle,
            errorNetworkSubtitle
        ].forEach {
            element.addArrangedSubview($0)
        }
        return element
    }()
    
    private lazy var vStackWithButton: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 32
        element.distribution = .fillProportionally
        [
            vStackLabels,
            button
        ].forEach {
            element.addArrangedSubview($0)
        }
        return element
    }()
    
    lazy var vStack: UIStackView = {
        let element = UIStackView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        element.distribution = .fillProportionally
        [
            errorNetwokImage,
            vStackWithButton
        ].forEach {
            element.addArrangedSubview($0)
        }
        element.isHidden = true
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(vStack)
        addSubview(tableView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("HomeView is failed init")
    }
    
    // MARK: - Public properties
    func setDelegates(controller: HomeViewControlelr) {
        tableView.delegate = controller
        tableView.dataSource = controller
    }
}

// MARK: - Setup Constraints
private extension HomeView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
}
