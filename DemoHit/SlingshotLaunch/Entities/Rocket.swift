//
//  Rocket.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 22.11.2022.
//

import SpriteKit

final class Rocket: PhysicalBody {
    
    //TODO добавить свойство bool значение, есть вектор или нет
    
    func applyGravitationalAttraction(to planet: Planet) {
        let gravitationalConstant : CGFloat = 250                               // грав постоянная
        let offset = create(a: planet.position, b: position)                    //вектор от одной до другой
        let length = length(a: offset)                                          //длина вектора
        let direction = normalize(a: offset)                                    //единичный вектор

        let force = gravitationalConstant * ((planet.mass * mass) / (length) )  //я знаю, что радиус в квадрате должен быть, но так играбельнее)))
        
        let forceVector = mult(a: direction, b: force)                          //вектор перемножаем на силу притяжения
        
        node.physicsBody?.applyForce(forceVector)
    }
}
