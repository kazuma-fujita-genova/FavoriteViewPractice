//
//  TabBarViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let favoriteViewController = storyboard.instantiateViewController(withIdentifier:"FavoriteView")
        let rootViewController = UINavigationController(rootViewController: favoriteViewController)
        setViewControllers([rootViewController], animated: false)
    }
}
