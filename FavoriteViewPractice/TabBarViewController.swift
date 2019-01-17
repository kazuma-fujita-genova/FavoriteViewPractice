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
        // UIチェック用
        let institutionViewController = InstitutionViewController(nibName: "InstitutionViewController", bundle: nil)
        let institutionRootViewController = UINavigationController(rootViewController: institutionViewController)
        // UIチェック用
        let testViewController = TestViewController(nibName: "TestViewController", bundle: nil)
        let testRootViewController = UINavigationController(rootViewController: testViewController)
        // UIチェック用
        let scrollTestViewController = ScrollTestViewController(nibName: "ScrollTestViewController", bundle: nil)
        let scrollTestRootViewController = UINavigationController(rootViewController: scrollTestViewController)

        // setViewControllers([scrollTestRootViewController, rootViewController, testRootViewController, institutionRootViewController], animated: false)
        // setViewControllers([scrollTestRootViewController, rootViewController, testRootViewController, institutionRootViewController], animated: false)
        setViewControllers([rootViewController, testRootViewController, institutionRootViewController], animated: false)
    }
}

