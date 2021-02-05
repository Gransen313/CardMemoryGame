//
//  Array+Only.swift
//  CardMemoryGame
//
//  Created by Sergey Borisov on 05.02.2021.
//

import Foundation

extension Array {
    var only: Element? {
        self.count == 1 ? first : nil
    }
}
