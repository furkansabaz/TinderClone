//
//  Mesaj.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 26.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import Firebase

struct Mesaj {
    let mesaj : String
    let benimMesajim : Bool
    
    let gondericiID  : String
    let aliciID : String
    let timestamp : Timestamp
    
    init(mesajVerisi : [String : Any]) {
        
        self.mesaj = mesajVerisi["Mesaj"] as? String ?? ""
        self.gondericiID = mesajVerisi["GondericiID"] as? String ?? ""
        self.aliciID = mesajVerisi["AliciID"] as? String ?? ""
        
        self.timestamp = mesajVerisi["Timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.benimMesajim = Auth.auth().currentUser?.uid == self.gondericiID
    }
}
