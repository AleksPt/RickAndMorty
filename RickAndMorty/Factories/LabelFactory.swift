//
//  LabelFactory.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

final class LabelFactory {
    static func makeLabel(
        font: UIFont,
        color: UIColor = .white,
        numberOflines: Int = 1
    ) -> UILabel {
        let element = UILabel()
        element.numberOfLines = numberOflines
        element.textColor = .white
        element.font = font
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }
    
    static func makeColorAttributedString(
        fullString: String,
        highlightedSubstring: String
    ) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullString)
        
        let range = (fullString as NSString).range(of: highlightedSubstring)
        
        var color: UIColor
        
        if highlightedSubstring.lowercased().contains("alive") {
            color = UIColor.surfGreen
        } else if highlightedSubstring.lowercased().contains("dead") {
            color = UIColor.surfRed
        } else {
            color = UIColor.surfGray
        }
        
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        
        return attributedString
    }
    
    static func makeBoldAttributedString(
        fullString: String,
        highlightedSubstring: String
    ) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullString)
        
        let range = (fullString as NSString).range(of: highlightedSubstring)
        
        attributedString.addAttribute(
            .font,
            value: UIFont.TextFonts.DetailScreen.semiboldLabel,
            range: range
        )
        
        return attributedString
    }
}
