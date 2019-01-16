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
import Hero
// import FaveButton
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer
import MaterialComponents.MaterialSnackbar_TypographyThemer
import MaterialComponents.MaterialButtons_ButtonThemer

class InstitutionViewController: UIViewController {
    
    @IBOutlet weak var institutionScrollView: UIScrollView!
    
    private let telephoneInquiryButton: MDCButton! = {
        let button:MDCButton = MDCButton()
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: button)
        //button.frame = CGRect(x:0, y:0, width: 200, height: 50)
        button.setTitle("電話でお問い合わせ", for:.normal)
        return button
    }()
    
    var offsetY:CGFloat = 0.0
    
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
    
    @IBOutlet weak var institutionNameLabelField: UILabel! {
        didSet {
            institutionNameLabelField.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // self.title = ""
        //pagerView.addSubview(pageControl)
        //pagerView.setImageInputs(localSource)
        
        if #available(iOS 11.0, *) {
            // Large Title 打ち消し
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
        
        // self.hero.isHeroEnabled = true
        // スクロール量の取得設定
        institutionScrollView.delegate = self
        // SafeAreaのAutoLayout処理を解除(pagerViewをSafeAreaまで表示)
        institutionScrollView.contentInsetAdjustmentBehavior = .never
        
        //let button = FaveButton(frame: CGRect(x:0, y:0, width: 35, height: 35),faveIconNormal: UIImage(named: "heart"))
        // let barButtonItem = UIBarButtonItem(image: UIImage(named: "heart.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleReturnButton(_:forEvent:)))
        //button.addTarget(self, action: #selector(handleReturnButton(_:forEvent:)), for:UIControl.Event.touchDown)
        // TODO: NavigationBarにFaveButtonを組み込むと上手く動作しない。以下コメントインすると落ちる
        //button.setSelected(selected: true, animated: true)
        //let barButtonItem = UIBarButtonItem(customView: button)
        //self.navigationItem.rightBarButtonItem = barButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favorite"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleReturnButton(_:forEvent:)))
        // お気に入りボタンはNavigationBarに移行
        // pagerView.addSubview(favoriteButton)
        // 電話でお問い合わせボタン設置
        view.addSubview(telephoneInquiryButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //if #available(iOS 11.0, *) {
            //self.navigationController?.navigationBar.prefersLargeTitles = true
        //}
        // NavigationBarを透過
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        //if #available(iOS 11.0, *) {
        //    self.navigationController?.navigationBar.prefersLargeTitles = true
        //}
        // NavigationBarを元に戻す
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 電話でお問い合わせボタンを画面下部に固定
        let width = (view.bounds.width-view.center.x)/2 + view.center.x
        telephoneInquiryButton.frame = CGRect(x: view.center.x/4, y: view.frame.height-100+offsetY, width: width, height: 50)
    }
    
    @objc func didTap() {
        let fullScreenController = pagerView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    // NavigationBarのキャンセルタップされた時に呼ばれるメソッド
    @objc func handleReturnButton(_ sender: UIButton, forEvent event: UIEvent) {
        self.navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
}

/*
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
*/

extension InstitutionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        /*
        offsetY = scrollView.contentOffset.y

        let alphaVlue = (offsetY + topSafeAreaHeight) / pagerViewHeght
        print(alphaVlue)
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alphaVlue)
        */
        
        offsetY = scrollView.contentOffset.y
        let pagerViewHeight = pagerView.bounds.height
        let navigationBarHeight = (self.navigationController?.navigationBar.bounds.height)!
        print("y = \(offsetY) ph = \(pagerViewHeight)")
        let changeHeight = pagerViewHeight/2
        var alphaVlue = (offsetY - changeHeight) / changeHeight

        if alphaVlue < 0 {
            alphaVlue = 0
        }
        else if alphaVlue > 1 {
            alphaVlue = 1
        }
        else {
            alphaVlue *= 2
        }
        
        print(alphaVlue)
        let backgroundImage = UIImage.colorImage(color: UIColor(red: 1, green: 1, blue: 1, alpha: alphaVlue), size: CGSize(width: 1, height: 1))
        self.navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: .default)
        // スクロール量に応じてタイトルをnavigationBarに設定
        self.title = pagerViewHeight-navigationBarHeight > offsetY ? "" : institutionNameLabelField.text
    }
}

extension UIImage {
    class func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
