//
//  FactoryPlanets.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 24.11.2022.
//

import Foundation

final class FactoryPlanets {
    
    func getSmallPlanet() -> Planet {
        return Planet(mass: 40)
    }
    
    func getMediumPlanet() -> Planet {
        return Planet(mass: 70)
    }
    
    func getBigPlanet() -> Planet {
        return Planet(mass: 100)
    }
}
