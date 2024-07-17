//
//  LabelFactory.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

final class LabelFactory {
    static func makeLabel(font: UIFont, color: UIColor = .white, numberOflines: Int = 1) -> UILabel {
        let element = UILabel()
        element.numberOfLines = numberOflines
        element.textColor = .white
        element.font = font
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
}
