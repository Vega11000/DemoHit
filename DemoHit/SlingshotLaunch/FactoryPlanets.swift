//
//  FactoryPlanets.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 24.11.2022.
//

import Foundation

final class PlanetFactory {
    
    func makeSmallPlanet() -> Planet {
        let planet = Planet(mass: 40, imageName: "earth")
        return planet
    }
    
    func makeMediumPlanet() -> Planet {
        let planet = Planet(mass: 70, imageName: "earth")
        return planet
    }
    
    func makeBigPlanet() -> Planet {
        let planet = Planet(mass: 100, imageName: "earth")
        return planet
    }
}
