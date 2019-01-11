//
//  InstitutionViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2019/01/07.
//  Copyright © 2019 藤田和磨. All rights reserved.
//

import UIKit
import ImageSlideshow
import CHIPageControl
import FaveButton
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer
import MaterialComponents.MaterialSnackbar_TypographyThemer

class InstitutionViewController: UIViewController {
    
    
    let localSource = [ImageSource(imageString: "1")!, ImageSource(imageString: "2")!, ImageSource(imageString: "3")!, ImageSource(imageString: "4")!, ImageSource(imageString: "5")!]
    
    @IBOutlet weak var pagerView: ImageSlideshow! {
        didSet {
            // 画像登録
            pagerView.setImageInputs(localSource)
            // 4:3比率を保持したまま拡大表示
            pagerView.contentScaleMode = UIView.ContentMode.scaleAspectFill
            // ピンチで画像拡大表示
            pagerView.zoomEnabled = true
            // pageControl設定
            pagerView.currentPageChanged = { page in
                self.pageControl.set(progress: page, animated: true)
            }
            // 全画面表示処理
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
            pagerView.addGestureRecognizer(recognizer)
            // ページインジケーターとお気に入りボタンをセット
            pagerView.addSubview(pageControl)
        }
    }
    
    @IBOutlet weak var pageControl: CHIPageControlAleppo! {
        didSet {
            // 画像数設定
            pageControl.numberOfPages = localSource.count
            // コントローラーUIViewサイズ
            pageControl.frame = CGRect(x: 0, y:0, width: 100, height: 20)
            // コントローラーUIViewの背景色
            pageControl.backgroundColor = .none
            // ドットの大きさ
            pageControl.radius = 4
            // ドットの幅
            pageControl.padding = 8
            // ドット色
            pageControl.tintColor = .white
            // アクティブなドット色
            pageControl.currentPageTintColor = .white
            // 非アクティブなドットの透明度
            pageControl.inactiveTransparency = 0.8
        }
    }
    
    @IBOutlet weak var favoriteButton: FaveButton! {
        didSet {
            favoriteButton.delegate = self
        }
    }
    
    @IBOutlet weak var institutionNameLabelField: UILabel! {
        didSet {
            institutionNameLabelField.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = ""
        //pagerView.addSubview(pageControl)
        //pagerView.setImageInputs(localSource)
        pagerView.addSubview(favoriteButton)
    }
    
    @objc func didTap() {
        let fullScreenController = pagerView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
}

extension InstitutionViewController: FaveButtonDelegate {

    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        // TODO: お気に入りボタンタップ処理
        if selected {
            // 画面下部トースト表示
            let toastMessage = MDCSnackbarMessage()
            toastMessage.text = "かかりつけの病院に登録しました"
            MDCSnackbarManager.show(toastMessage)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
