//
//  BitMaskCategory.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import Foundation

struct BitMask {
    static let player: UInt32 = 0x1 << 1
    static let station: UInt32 = 0x1 << 2
    static let planet: UInt32 = 0x1 << 3
    static let asteroid: UInt32 = 0x1 << 4
}
