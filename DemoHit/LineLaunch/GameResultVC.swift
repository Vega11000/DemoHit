//
//  GameResultViewController.swift
//  RocketSwipeGameplay
//
//  Created by Кирилл Пигалкин on 26.11.2022.
//

import UIKit

final class GameResultViewController: UIViewController {

    let result: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        showResult()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: false)
    }
    
    func showResult() {
        view.addSubview(result)
        result.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            result.widthAnchor.constraint(equalTo: view.widthAnchor),
            result.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            result.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            result.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
