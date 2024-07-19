//
//  FavoritesTip.swift
//  RickAndMorty
//
//  Created by Алексей on 19.07.2024.
//

import Foundation
import TipKit

struct EasterEggTip: Tip {

   var title: Text {
      Text("Привет, Сёрферы!")
   }

   var message: Text? {
      Text("Этот парень смог засунуть меня в приложение, так что возьмите его на стажировку и не пожалеете 😉")
   }

   var image: Image? {
       Image(.surfLogo)
   }
    
    @Parameter
    static var hasViewedTip: Bool = true
    
    var rules: [Rule] {
        #Rule(Self.$hasViewedTip) { $0 == true }
    }
}
