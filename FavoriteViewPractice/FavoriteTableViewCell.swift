//
//  FavoriteTableViewCell.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import FSPagerView
import CHIPageControl
import FaveButton

import MaterialComponents.MaterialTextFields

class FavoriteTableViewCell: UITableViewCell {

    
    var allTextFieldControllers = [MDCTextInputControllerUnderline]()
    
    // TODO: デフォルト表示用ダミー画像を設定
    var photos = ["1"]
    
    // VC内で呼ばれるCell拡張Delegate
    weak var delegate: TableViewCellDelegate?
    
    @IBOutlet weak var favoriteButton: FaveButton!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            // 再利用する画像PagerViewCell設定
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerViewCell")
            // 無限ループ設定
            self.pagerView.isInfinite = true
            // Automatic Slider
            // pagerView.automaticSlidingInterval = 4
            // エフェクト coverFlow .linear, .overlap は以下を有効
            // pagerView.transformer = FSPagerViewTransformer(type: .linear)
            // pagerView.itemSize = CGSize(width: 300, height: 200)
            // pagerView.itemSize = FSPagerView.automaticSize
            // pagerView.interitemSpacing = 16
            // エフェクト .crossFading, .zoomOut, .depth のときは以下を有効
            // pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
            self.pagerView.itemSize = FSPagerView.automaticSize
            self.pagerView.decelerationDistance = 1
        }
    }
    
    @IBOutlet weak var pageControl: CHIPageControlAleppo! {
        didSet {
            // コントローラーUIViewサイズ
            self.pageControl.frame = CGRect(x: 0, y:0, width: 100, height: 20)
            // コントローラーUIViewの背景色
            self.pageControl.backgroundColor = .none
            // ドットの大きさ
            self.pageControl.radius = 4
            // ドットの幅
            self.pageControl.padding = 8
            // ドット色
            self.pageControl.tintColor = .white
            // アクティブなドット色
            self.pageControl.currentPageTintColor = .white
            // 非アクティブなドットの透明度
            self.pageControl.inactiveTransparency = 0.8
        }
    }
    
    @IBOutlet weak var institutionLabelField: UILabel! {
        didSet {
            self.institutionLabelField.adjustsFontSizeToFitWidth = true
            self.institutionLabelField.font = UIFont.boldSystemFont(ofSize: 22)
        }
    }
    
    @IBOutlet weak var localIdTextField: MDCTextField! {
        didSet {
            // 10キー表示
            self.localIdTextField.keyboardType = UIKeyboardType.numberPad

            let fieldController = MDCTextInputControllerUnderline(textInput: self.localIdTextField)
            fieldController.placeholderText = "診察券番号"
            fieldController.floatingPlaceholderScale = 0.9
            fieldController.textInputFont = UIFont.systemFont(ofSize: 17)
            fieldController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 17)
            fieldController.floatingPlaceholderActiveColor = UIColor.init(red: 58/255, green: 158/255, blue: 210/255, alpha: 100/100)
            fieldController.textInputClearButtonTintColor = .lightGray
            self.allTextFieldControllers.append(fieldController)
            
            // self.localIdTextField.delegate = self
            // self.localIdTextField.frame = CGRect(x: 0, y: 0, width: 190, height: 20)
        }
    }
    
    @IBOutlet weak var reserveDateTextField: MDCTextField! {
        didSet {
            // キャレット非表示
            // self.reserveDateTextField.tintColor = .clear
            // self.reserveDateTextField.delegate = self

            let fieldController = MDCTextInputControllerUnderline(textInput: self.reserveDateTextField)
            fieldController.placeholderText = "次回予約日時メモ"
            fieldController.floatingPlaceholderScale = 0.9
            fieldController.textInputFont = UIFont.systemFont(ofSize: 17)
            fieldController.inlinePlaceholderFont = UIFont.systemFont(ofSize: 17)
            //fieldController.color
            fieldController.floatingPlaceholderActiveColor = UIColor.init(red: 58/255, green: 158/255, blue: 210/255, alpha: 100/100)
            fieldController.textInputClearButtonTintColor = .lightGray
            self.allTextFieldControllers.append(fieldController)
            
        }
    }
    
    @IBOutlet weak var lastRceptionStackView: UIStackView!
    
    @IBOutlet weak var lastReceptionCaptionLabelField: UILabel! {
        didSet {
            self.lastReceptionCaptionLabelField.font = UIFont.systemFont(ofSize: 15)
            self.lastReceptionCaptionLabelField.textColor = .gray
        }
    }
    
    @IBOutlet weak var lastRceptionLabelField: UILabel!
    
    
    /* TODO: awakeFromNib中で設定しないとキーボードがセットできない。調査
    var reserveDatePicker: UIDatePicker! {
        didSet {
            
            // YYYY/MM/DD HH:mm
            self.reserveDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
            //タイムゾーンの設定
            self.reserveDatePicker.timeZone = NSTimeZone.local
            // 初期値を現在日時に指定
            self.reserveDatePicker.locale = Locale.current
            // 分刻みを5分単位で設定
            self.reserveDatePicker.minuteInterval = 5
            
            self.reserveDatePicker.addTarget(self, action: Selector(("datePickerValueChanged:")), for: UIControl.Event.valueChanged)
        }
    }
    */
    
    let reserveDatePicker = UIDatePicker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
        // YYYY/MM/DD HH:mm
        self.reserveDatePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        //タイムゾーンの設定
        self.reserveDatePicker.timeZone = NSTimeZone.local
        // 初期値を現在日時に指定
        self.reserveDatePicker.locale = Locale.current
        // 分刻みを5分単位で設定
        self.reserveDatePicker.minuteInterval = 5
        
        self.reserveDatePicker.addTarget(self, action:#selector(hundleDatePickerValueChanged), for: UIControl.Event.valueChanged)
        // UIDatePickerをキーボードに設定
        reserveDateTextField.inputView = reserveDatePicker
        
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(hundleDatePickerEditingDidEnd))
        // Doneボタンを追加
        toolbar.setItems([doneButton], animated: true)
        // UIToolbarをキーボードに設定
        reserveDateTextField.inputAccessoryView = toolbar
        
        pagerView.dataSource = self
        pagerView.delegate = self
        favoriteButton.delegate = self
        
        pagerView.addSubview(pageControl)
        pagerView.addSubview(favoriteButton)
    }
    
    // Done
    @objc func hundleDatePickerEditingDidEnd(sender:UIDatePicker) {
        // let dateFormatter = DateFormatter()
        // dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        // reserveDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    // datepickerが変更されたらtextfieldに表示
    @objc func hundleDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm"
        reserveDateTextField.text = dateFormatter.string(from: sender.date)
    }
}

// MARK: - TableViewCellDelegate
protocol TableViewCellDelegate: class {
    // VC内で呼ばれるFaveButtonDelegate拡張メソッド
    func faveButton(_ cell: FavoriteTableViewCell, faveButton: FaveButton, didSelected selected: Bool)
}

// MARK: - FaveButtonDelegate
extension FavoriteTableViewCell: FaveButtonDelegate {
    // VC内でCell情報を利用できるようFaveButtonDelegateを拡張
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        delegate?.faveButton(self, faveButton:faveButton, didSelected: selected)
    }
}

// 画像カルーセル処理。UI部分のみなのでCell内で実装
// MARK: - FSPagerViewDataSource, FSPagerViewDelegate
extension FavoriteTableViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        // pageControlドット数
        pageControl.numberOfPages = photos.count
        return photos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerViewCell", at: index)
        
        // cell.contentView.layer.shadowOpacity = 0.4
        // cell.contentView.layer.opacity = 0.86
        cell.imageView?.image = UIImage(named: self.photos[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.set(progress: targetIndex, animated: true)
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.set(progress: pagerView.currentIndex, animated: true)
    }
}

/*
extension FavoriteTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        localIdTextField.resignFirstResponder()
        reserveDateTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        localIdTextField.resignFirstResponder()
        reserveDateTextField.resignFirstResponder()
    }
}
*/
