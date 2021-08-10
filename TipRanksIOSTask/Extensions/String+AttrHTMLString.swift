//
//  String+AttrHTMLString.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 09/08/2021.
//

import UIKit

extension String {
    func decodeHTMLToAttrString() -> NSAttributedString? {
        if let attrString = try? NSMutableAttributedString(data: Data(self.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil), attrString.length > 0 {
            
            // html font size is too small, set custom font size
            attrString.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], range: NSRange(location: 0, length: attrString.length-1))
            return attrString
        }
        return nil
    }
}
