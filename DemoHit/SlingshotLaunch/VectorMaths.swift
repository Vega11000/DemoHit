//
//  VectorMaths.swift
//  spaceGame
//
//  Created by Игорь Ходжгоров on 21.11.2022.
//

import CoreGraphics

func create(a: CGPoint, b: CGPoint) -> CGVector {
    return CGVector(dx: a.x - b.x ,dy: a.y - b.y)
}

func sub(a: CGVector, b: CGVector) -> CGVector {
    return CGVector(dx: a.dx - b.dx ,dy: a.dy - b.dy)
}

func add(a: CGVector, b: CGVector) -> CGVector {
    return CGVector(dx: a.dx + b.dx ,dy: a.dy + b.dy)
}

func mult(a: CGVector, b: CGFloat) -> CGVector {
    return CGVector(dx: a.dx * b ,dy: a.dy * b)
}

func multVectors(a: CGVector, b: CGVector) -> CGFloat {
    return CGFloat(a.dx * b.dx + a.dy * b.dy)
}

func angleBetweenVectors(a: CGVector, b: CGVector) -> CGFloat {
    return acos(multVectors(a: a, b: b) / (length(a: a) * length(a: b))) * 180 / .pi
}

func length(a: CGVector) -> CGFloat {
    return sqrt(CGFloat(a.dx * a.dx) + CGFloat(a.dy * a.dy))
}

func normalize(a:CGVector) -> CGVector{
    let l = length(a: a)
    return CGVector(dx: a.dx / l, dy: a.dy / l)
}
