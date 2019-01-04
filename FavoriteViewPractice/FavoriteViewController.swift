//
//  FavoriteViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import FaveButton
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer
import MaterialComponents.MaterialSnackbar_TypographyThemer


class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    let photos = ["3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "かかりつけ"
        setupTableView()
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
        return photos.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FavoriteTableViewCell
        cell.delegate = self
        // 画像を設定
        cell.photos = self.photos
        // TODO: セルの背景色をランダムに設定する。（後で削除）
        // cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

        return cell
    }
}

// MARK: - CollectionCellDelegate
extension FavoriteViewController: CollectionCellDelegate {
    
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

