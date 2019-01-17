//
//  ScrollTestViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2019/01/16.
//  Copyright © 2019 藤田和磨. All rights reserved.
//

import UIKit

class ScrollTestViewController: UIViewController {

    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
    }
}

extension ScrollTestViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("header view origin y B\(headerView.frame.origin.y)")
        //headerView.frame.origin.y = scrollView.contentOffset.y
        //print("header view origin y A\(headerView.frame.origin.y)")
        print(scrollView.contentOffset.y)
        headerViewTopConstraint.constant = scrollView.contentOffset.y
        headerView.frame.origin.y = scrollView.contentOffset.y
        //print(headerViewTopConstraint.constant)
    }
}
