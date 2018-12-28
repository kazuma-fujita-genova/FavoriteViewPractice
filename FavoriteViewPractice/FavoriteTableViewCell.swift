//
//  FavoriteTableViewCell.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var reserveDateTextField: UITextField! {
        didSet {
            self.reserveDateTextField.placeholder = "日付を選択"
        }
    }
    /*
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
        
        self.reserveDatePicker.addTarget(self, action:#selector(datePickerValueChanged), for: UIControl.Event.valueChanged)

        reserveDateTextField.inputView = reserveDatePicker
        
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateInputDone))
        // Doneボタンを追加
        toolbar.setItems([doneButton], animated: true)
        
        reserveDateTextField.inputAccessoryView = toolbar
        
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func dateInputDone(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd"
        reserveDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd"
        reserveDateTextField.text = dateFormatter.string(from: sender.date)
    }
}
