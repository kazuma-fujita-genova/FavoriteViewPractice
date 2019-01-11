//
//  MDCCustomTextField.swift
//  FavoriteViewPractice
//
//  Created by 藤田和磨 on 2019/01/07.
//  Copyright © 2019 藤田和磨. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields

class MDCCustomTextField: MDCTextField {

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    // 範囲選択カーソル非表示
    //override func selectionRects(for range: UITextRange) -> [Any] {
    //    return []
    //}
    
    // コピー・ペースト・選択等のメニュー非表示
    //override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    //    return false
    //}
}
