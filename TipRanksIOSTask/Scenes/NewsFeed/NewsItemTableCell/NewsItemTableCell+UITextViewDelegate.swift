//
//  NewsItemTableCell+UITextViewDelegate.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 10/08/2021.
//

import UIKit

extension NewsItemTableCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL)
        }
        return false
    }
}
