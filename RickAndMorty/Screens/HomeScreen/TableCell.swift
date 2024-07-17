//
//  HomeCell.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

final class TableCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var background: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 24
        element.backgroundColor = UIColor.surfDarkGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var avatar: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.layer.cornerRadius = 10
        element.clipsToBounds = true
        return element
    }()
    
    private let nameLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.TableCell.title)
    
    private let subtitleLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.TableCell.subtitle)
    
    private let genderLabel = LabelFactory.makeLabel(font: UIFont.TextFonts.TableCell.gender)
    
    private lazy var vStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 6
        element.distribution = .fillEqually
        [
            nameLabel,
            subtitleLabel,
            genderLabel
        ].forEach {
            element.addArrangedSubview($0)
        }
        return element
    }()
    
    private lazy var hStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 16
        element.alignment = .leading
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        [
            avatar,
            vStack
        ].forEach {
            element.addArrangedSubview($0)
        }
        return element
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("HomeCell is failed init")
    }
    
    // MARK: - Overrides methods
    override func prepareForReuse() {
        super.prepareForReuse()
        avatar.image = nil
        nameLabel.text = nil
        subtitleLabel.text = nil
        genderLabel.text = nil
    }
    
    // MARK: - Public methods
    func configureCell(item: Character) {
        // FIXME - получение карьинки пофиксить
        avatar.image = .mockImg6
        nameLabel.text = item.name
        // FIXME - цвет статуса настроить
        subtitleLabel.text = "\(item.status) • \(item.gender)"
        genderLabel.text = item.gender
    }
    
    // MARK: - Private methods
    private func setupCell() {
        backgroundColor = .black
        addSubview(background)
        background.addSubview(hStack)
        selectionStyle = .none
    }
}

// MARK: - Setup Constraints
private extension TableCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            hStack.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            hStack.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -16),
            hStack.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 15),
            hStack.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -18),
            
            avatar.widthAnchor.constraint(equalTo: hStack.widthAnchor, multiplier: 0.2625),
        ])
    }
}
