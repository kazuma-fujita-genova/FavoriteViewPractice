//
//  FavoriteViewController.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    let photos = ["1","2","3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "かかりつけ"
        setupTableView()
    }

    private func setupTableView() {
        favoriteTableView?.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        // Cell区切り線を消す
        favoriteTableView.separatorStyle = .none
        favoriteTableView?.dataSource = self
        favoriteTableView?.delegate = self
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return photos.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FavoriteTableViewCell

        return cell
    }
}
