//
//  PointsWork.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import UIKit

extension SwipeScene {
    func smoothPath() -> CGPath {
        path = UIBezierPath()
        var prevPoint: CGPoint?
        var isFirst = true

        let pathPoints = removeClosePoints(pathPoints)

        for point in pathPoints {
            if let prevPoint = prevPoint {
                let midPoint = CGPoint(
                    x: (point.x + prevPoint.x) / 2,
                    y: (point.y + prevPoint.y) / 2)
                if isFirst {
                    path.addLine(to: midPoint)
                    isFirst = false
                } else {
                    path.addQuadCurve(to: midPoint, controlPoint: prevPoint)
                }
            }
            else {
                path.move(to: point)
            }
            prevPoint = point
        }
        
        if let prevPoint = prevPoint {
            path.addLine(to: prevPoint)
        }
        
        path.flatness = 0.1
        path.miterLimit = 10
        swipeNode.path = path.cgPath
        return path.cgPath
    }
    
    func vector(from firstPoint: CGPoint, to secondPoint: CGPoint) -> CGVector  {
        var vector = CGVector()
        vector.dx = secondPoint.x - firstPoint.x
        vector.dy = secondPoint.y - firstPoint.y
        return vector
    }
    
    func removeClosePoints(_ arrayOfPoints: [CGPoint]) -> [CGPoint] {
        var arr = [CGPoint]()
        arr.append(arrayOfPoints.first!)
        for index in 1..<arrayOfPoints.count - 1 {
            let previousIndex = index - 1
            if distanceBetween(previousPoint: arrayOfPoints[previousIndex], currentPoint: arrayOfPoints[index]) > 20 {
                arr.append(arrayOfPoints[index])
            }
        }
        arr.append(arrayOfPoints.last!)
        return arr
    }
    
    func distanceBetween(previousPoint: CGPoint, currentPoint: CGPoint) -> CGFloat {
        var distance = (currentPoint.x - previousPoint.x) * (currentPoint.x - previousPoint.x)
        distance += (currentPoint.y - previousPoint.y) * (currentPoint.y - previousPoint.y)
        return sqrt(distance)
    }
}
