//
//  Fonts.swift
//  RickAndMorty
//
//  Created by Алексей on 17.07.2024.
//

import UIKit

extension UIFont {
    enum IBMPlexSans: String {
        case bold = "IBMPlexSans-Bold"
        case extraLight = "IBMPlexSans-ExtraLight"
        case light = "IBMPlexSans-Light"
        case medium = "IBMPlexSans-Medium"
        case regular = "IBMPlexSans-Regular"
        case semiBold = "IBMPlexSans-SemiBold"
        case thimn = "IBMPlexSans-Thin"
    }
    
    enum IBMPlexSansFont {
        static func getFont(name: IBMPlexSans, size: CGFloat) -> UIFont {
            guard let font = UIFont(name: name.rawValue, size: size) else {
                print("шрифт \(name.rawValue) не найден")
                return .systemFont(ofSize: size)
            }
            return font
        }
    }
    
    enum TextFonts {
        enum NavigationBar {
            static let title = IBMPlexSansFont.getFont(name: .bold, size: 24)
            static let searchBarPlaceholder = IBMPlexSansFont.getFont(name: .regular, size: 14)
            static let cellTitle = IBMPlexSansFont.getFont(name: .regular, size: 8.43)
        }
        
        enum TableCell {
            static let title = IBMPlexSansFont.getFont(name: .medium, size: 18)
            static let subtitle = IBMPlexSansFont.getFont(name: .semiBold, size: 12)
            static let gender = IBMPlexSansFont.getFont(name: .regular, size: 12)
        }
        
        enum DetailScreen {
            static let semiboldLabel = IBMPlexSansFont.getFont(name: .semiBold, size: 16)
            static let regularLabel = IBMPlexSansFont.getFont(name: .regular, size: 16)
        }
        
        enum Error {
            enum Network {
                static let title = IBMPlexSansFont.getFont(name: .semiBold, size: 28)
                static let subtitle = IBMPlexSansFont.getFont(name: .regular, size: 16)
            }
        }
        
        enum Button {
            static let primaryTitle = IBMPlexSansFont.getFont(name: .medium, size: 18)
            static let secondaryTitle = IBMPlexSansFont.getFont(name: .regular, size: 14)
        }
        
        enum PageSheet {
            static let title = IBMPlexSansFont.getFont(name: .semiBold, size: 20)
            static let sectionTitle = IBMPlexSansFont.getFont(name: .medium, size: 14)
            static let cellTitle = IBMPlexSansFont.getFont(name: .regular, size: 12)
        }
    }
}
