//
//  ButtonFactory.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import UIKit

final class ButtonFactory {
    static func makePrimaryButton(title: String) -> UIButton {
        let element = UIButton(type: .system)
        element.setTitle(title, for: .normal)
        element.titleLabel?.font = UIFont.TextFonts.Button.primaryTitle
        element.tintColor = .white
        element.backgroundColor = UIColor.surfMarine
        element.layer.cornerRadius = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
}
