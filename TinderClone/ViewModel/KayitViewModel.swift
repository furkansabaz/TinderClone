//
//  KayitViewModel.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 5.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class KayitViewModel {
    
    var emailAdresi : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    var adiSoyadi : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    var parola : String? {
        didSet {
            veriGecerliKontrol()
        }
    }
    
    fileprivate func veriGecerliKontrol() {
        
        let gecerli = emailAdresi?.isEmpty == false && adiSoyadi?.isEmpty == false && parola?.isEmpty == false
        kayitVerileriGecerliObserver?(gecerli)
    }
    
    var kayitVerileriGecerliObserver : ((Bool) -> ())?
    
    
    
}
