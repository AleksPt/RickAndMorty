//
//  SpinnerFactory.swift
//  RickAndMorty
//
//  Created by Алексей on 18.07.2024.
//

import UIKit

final class SpinnerFactory {
    static func makeSpinner(style: UIActivityIndicatorView.Style = .large) -> UIActivityIndicatorView {
        let element = UIActivityIndicatorView(style: style)
        element.hidesWhenStopped = true
        element.color = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        element.startAnimating()
        return element
    }
}
