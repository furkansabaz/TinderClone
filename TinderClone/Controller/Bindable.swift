//
//  Bindable.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 6.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation


class Bindable<K> {
    var deger : K? {
        didSet {
            gozlemci?(deger)
        }
    }
    
    var gozlemci : ((K?) -> ())?
    
    func degerAta(gozlemci : @escaping (K?) -> ()) {
        self.gozlemci = gozlemci
    }
}
