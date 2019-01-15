//
//  InstitutionDetailBlockView.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2019/01/10.
//  Copyright © 2019 藤田和磨. All rights reserved.
//

import UIKit

class InstitutionDetailBlockView: UIView {
    
    @IBOutlet weak var captionLabelField: UILabel!
    
    @IBOutlet weak var descriptionLabelField: UILabel!
    
    // コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // IBで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {

        // View生成. File's Ownerはself
        guard let view = UINib(nibName: "InstitutionDetailBlockView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        // viewのサイズをあわせる
        view.frame = self.bounds
        // 伸縮させる
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //上線のCALayerを作成
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        
        // Viewに上線を追加
        view.layer.addSublayer(topBorder)
        view.backgroundColor = .red
        //addする。viewオブジェクトの2枚重ねになる。
        self.addSubview(view)
    }

}
