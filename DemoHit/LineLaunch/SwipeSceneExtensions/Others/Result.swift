//
//  Result.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 27.11.2022.
//

import Foundation

extension SwipeScene {
    func gameOver(isWin: Bool) {
        let result = GameResultViewController()
        result.view.backgroundColor = .red
        result.modalPresentationStyle = .fullScreen
        result.result.text = isWin ? "Так держать" : "Попробуй еще раз"
        result.view.backgroundColor = isWin ? .green : .red
        viewController?.present(result, animated: false)
        removeChildren(in: [rocket])
        setupRocket()
        isActive = false
    }
}
