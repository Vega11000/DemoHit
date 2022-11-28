//
//  TabBarController.swift
//  DemoHit
//
//  Created by Илья Калганов on 23.11.2022.
//

import UIKit


final class TabBarController: UITabBarController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isOpaque = true
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemCyan
        tabBar.backgroundColor = .white
        setupTabBar()
    }
}

private extension TabBarController {
    
    func setupTabBar() {
        let navVCSlingshotLaunch = NavigationController(rootViewController: SlingshotLaunchViewController())
        let navVCLineLaunch = NavigationController(rootViewController: SwipeViewController())
        
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .semibold
        )
        
        navVCSlingshotLaunch.tabBarItem = UITabBarItem(
            title: "SlingshotLaunch",
            image: UIImage(systemName: "arrowtriangle.up.circle"),
            tag: 0
        )
        navVCSlingshotLaunch.tabBarItem.selectedImage = UIImage(systemName: "arrowtriangle.up.circle",
                                                                          withConfiguration: configuration)
        
        navVCLineLaunch.tabBarItem = UITabBarItem(
            title: "LineLaunch",
            image: UIImage(systemName: "line.diagonal"),
            tag: 1
        )
        navVCLineLaunch.tabBarItem.selectedImage = UIImage(systemName: "line.diagonal",
                                                                          withConfiguration: configuration)
        
        setViewControllers([
            navVCSlingshotLaunch, navVCLineLaunch
        ], animated: false)
    }
}
