//
//  Card.swift
//  Concentration
//
//  Created by Austen Williams on 12/12/19.
//  Copyright © 2019 Austen Williams. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUinqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUinqueIdentifier()
    }
}
