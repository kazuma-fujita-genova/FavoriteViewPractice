//
//  FavoriteViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import FaveButton
import ImageSlideshow
import Hero
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer
import MaterialComponents.MaterialSnackbar_TypographyThemer


class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    fileprivate let heroTransition = HeroTransition()
    
    // let photos = ["3","4","5","6","7"]
    // let defaultPhoto = ["1"]
    let localSource = [ImageSource(imageString: "1")!, ImageSource(imageString: "2")!, ImageSource(imageString: "3")!, ImageSource(imageString: "4")!, ImageSource(imageString: "5")!]
    
    let defaultLocalSource = [ImageSource(imageString: "1")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "かかりつけ"
        if #available(iOS 11.0, *) {
            // Large Title TODO: 何故か効かない
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        // HeroTransitionを設定
        self.navigationController?.delegate = self
        //self.navigationController?.hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))
        self.navigationController?.hero.navigationAnimationType = .autoReverse(presenting: .zoom)

        // self.hero.isHeroEnabled = true
        // self.hero.isEnabled = true
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //if #available(iOS 11.0, *) {
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        //}
        // NavigationBarを透過
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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

    private func setupTableView() {
        favoriteTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        // Cell選択時の背景色変更を解除
        favoriteTableView.allowsSelection = false
        // Cell区切り線を消す
        favoriteTableView.separatorStyle = .none
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return localSource.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FavoriteTableViewCell
        cell.delegate = self
        
        // TODO: とりあえず2セル分は複数画像
        if 2 > indexPath.row {
            // 画像を設定
            cell.pagerView.setImageInputs(localSource)
            // cell.photos = self.photos
            // cell.pagerView.isInfinite = true
            cell.lastRceptionStackView.isHidden = true
        } else {
            // 画像1枚の時の処理
            // cell.photos = self.defaultPhoto
            cell.pagerView.setImageInputs(defaultLocalSource)
            // cell.pagerView.isInfinite = false
            cell.lastRceptionStackView.isHidden = false
        }
        // TODO: セルの背景色をランダムに設定する。（後で削除）
        // cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        cell.pagerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInstitutionViewButton(gestureRecognizer:))))
        return cell
    }
    
    @objc func handleInstitutionViewButton(gestureRecognizer: UITapGestureRecognizer) {
        let institutionViewController = InstitutionViewController(nibName: "InstitutionViewController", bundle: nil)
        //let institutionNavigationController = UINavigationController(rootViewController: institutionViewController)
        // 施設詳細画面は画面下部TabBar非表示
        institutionViewController.hidesBottomBarWhenPushed = true
        // Push遷移
        self.navigationController?.show(institutionViewController, sender: nil)
        //self.navigationController?.show(institutionNavigationController, sender: nil)
        //self.present(institutionViewController, animated: true, completion: nil)
    }
}

// MARK: - CollectionCellDelegate
extension FavoriteViewController: TableViewCellDelegate {
    
    func faveButton(_ cell: FavoriteTableViewCell, faveButton: FaveButton, didSelected selected: Bool) {
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

extension FavoriteViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return heroTransition.navigationController(navigationController, interactionControllerFor: animationController)
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return heroTransition.navigationController(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }
}
