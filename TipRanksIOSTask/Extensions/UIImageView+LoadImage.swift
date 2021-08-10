//
//  UIImageView+LoadImage.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 09/08/2021.
//

import UIKit

extension UIImageView {
    func setImage(withUrl url: URL?) {
        ImageLoader.shared.setImage(withUrl: url, imageView: self)
    }
}
