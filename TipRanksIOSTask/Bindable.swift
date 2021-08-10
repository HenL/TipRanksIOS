//
//  Bindable.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation

class Bindable<T> {
    typealias Observer = (T?) -> ()
    
    var value: T? {
        didSet {
            self.observer?(value)
        }
    }
    
    var observer: Observer?
    
    func bind(_ observer: Observer?) {
        self.observer = observer
    }
}
