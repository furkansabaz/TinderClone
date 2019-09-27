//
//  MesajCell.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 27.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit
class MesajCell : ListeCell<Mesaj> {
    
    let mesajContainer = UIView(arkaPlanRenk: #colorLiteral(red: 0.881370306, green: 0.8761312366, blue: 0.885397613, alpha: 1))
    // gönderilen veya alınan mesajı tutar - gösterir
    let txtMesaj : UITextView  = {
        
        let txt = UITextView()
        txt.backgroundColor = .clear
        txt.font = .systemFont(ofSize: 20)
        txt.isScrollEnabled = false
        txt.isEditable = false
        return txt
    }()
    
    override var veri: Mesaj! {
        didSet {
            
            txtMesaj.text = veri.mesaj
            
            if veri.benimMesajim {
                mesajConstraint.trailing?.isActive = true
                mesajConstraint.leading?.isActive = false
                mesajContainer.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                txtMesaj.textColor = .white
            } else {
                mesajConstraint.trailing?.isActive = false
                mesajConstraint.leading?.isActive = true
                mesajContainer.backgroundColor = #colorLiteral(red: 0.8832117915, green: 0.8782526851, blue: 0.8868549466, alpha: 1)
                txtMesaj.textColor = .black
            }
            
        }
    }
    var mesajConstraint : AnchorConstraints!
    override func viewleriOlustur() {
        super.viewleriOlustur()
        
        addSubview(mesajContainer)
        mesajContainer.layer.cornerRadius = 15
         mesajConstraint =  mesajContainer.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        mesajConstraint.leading?.constant = 20
        mesajConstraint.trailing?.isActive = false
        
        mesajConstraint.trailing?.constant = -20
        //Sağ Tarafta
        
        mesajContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 260).isActive = true
        //mesajContainer.genislikAyarla(260)
        mesajContainer.addSubview(txtMesaj)
        //txtMesaj.doldurSuperView()
        txtMesaj.doldurSuperView(padding: .init(top: 5, left: 13, bottom: 5, right: 13))
        
    }
    
}
