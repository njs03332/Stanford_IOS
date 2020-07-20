//
//  Card.swift
//  Concentration
//
//  Created by Yuri Kim on 2020/07/15.
//  Copyright © 2020 Yuri Kim. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        // returns new unique identifier
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()  // Card type calls static func
        
    }
}
