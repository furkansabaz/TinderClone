//
//  EslesmeCell.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 27.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

class EslesmeCell : ListeCell<Eslesme> {
    
    let imgProfil =  UIImageView(image: UIImage(named: "kisi4"),contentMode: .scaleAspectFill)
    let lblKullaniciAdi = UILabel(text: "Sefa123", font: .systemFont(ofSize: 15, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 2)
    
    override var veri: Eslesme! {
        didSet {
            lblKullaniciAdi.text = veri.kullaniciAdi
            imgProfil.sd_setImage(with: URL(string: veri.profilGoruntuUrl))
        }
    }
    
    
    override func viewleriOlustur() {
        super.viewleriOlustur()
        
        imgProfil.clipsToBounds = true
        imgProfil.boyutlandir(.init(width: 80, height: 80))
        imgProfil.layer.cornerRadius = 40
        stackViewOlustur(stackViewOlustur(imgProfil,alignment: .center),lblKullaniciAdi)
    }
}
