//
//  DetailView.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: - UI
    private lazy var background: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 24
        element.backgroundColor = UIColor.surfDarkGray
        element.translatesAutoresizingMaskIntoConstraints = false
        [
            imageView,
            statusView,
            vStack
        ].forEach {
            element.addSubview($0)
        }
        return element
    }()
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 12
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var statusView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.cornerRadius = 16
        element.backgroundColor = UIColor.surfGreen
        element.addSubview(statusLabel)
        return element
    }()
    
    private let statusLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.DetailScreen.semiboldLabel)
    
    private let speciesLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.DetailScreen.semiboldLabel, numberOflines: 0)
    
    private let genderLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.DetailScreen.semiboldLabel, numberOflines: 0)
    
    private let episodesLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.DetailScreen.semiboldLabel, numberOflines: 0)
    
    private let locationLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.DetailScreen.semiboldLabel, numberOflines: 0)
    
    private lazy var vStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 12
        element.alignment = .leading
        element.translatesAutoresizingMaskIntoConstraints = false
        [
            speciesLabel,
            genderLabel,
            episodesLabel,
            locationLabel
        ].forEach {
            element.addArrangedSubview($0)
        }
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(background)
        setupConstraints()
        
        imageView.image = .mockImg6
        statusLabel.text = "Alive"
        speciesLabel.text = "Species: Human"
        genderLabel.text = "Gender: Male"
        episodesLabel.text = "Episodes: 6, 11, 30"
        locationLabel.text = "Last known location: Earth"
    }
    
    required init?(coder: NSCoder) {
        fatalError("DetailView is failed init")
    }
    
    // MARK: - Overrides methods
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.heightAnchor.constraint(equalToConstant: background.frame.width - 32).isActive = true
    }
}

// MARK: - Setup Constraints
private extension DetailView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            statusView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            statusView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            statusView.heightAnchor.constraint(equalToConstant: 31.92),
            
            statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
            
            vStack.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 24),
            vStack.leadingAnchor.constraint(equalTo: statusView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: statusView.trailingAnchor),
            
            background.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            background.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 16),
        ])
    }
}
