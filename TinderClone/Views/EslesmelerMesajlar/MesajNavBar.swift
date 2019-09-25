//
//  MesajNavBar.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

class MesajNavBar : UIView {
    
    let imgKullaniciProfil = DaireselImageView(genislik: 50, image: #imageLiteral(resourceName: "kisi4"))
    
    //let imgKullaniciProfil = UIImageView(image: #imageLiteral(resourceName: "kisi4"), contentMode: .scaleAspectFill)
    
    let lblKullaniciAdi = UILabel(text: "Yusuf123", font: .systemFont(ofSize: 17))
    
    let  btnGeri = UIButton(image: #imageLiteral(resourceName: "geri"),tintColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    let btnBayrak = UIButton(image: #imageLiteral(resourceName: "bayrak"),tintColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1))
    
    fileprivate let eslesme : Eslesme
    
    init(eslesme : Eslesme) {
        self.eslesme = eslesme
        lblKullaniciAdi.text = eslesme.kullaniciAdi
        imgKullaniciProfil.sd_setImage(with: URL(string: eslesme.profilGoruntuUrl))
        super.init(frame : .zero)
        
        
        backgroundColor = .white
        golgeEkle(opacity: 0.3, yaricap: 10, offset: .init(width: 0, height: 10), renk: .init(white: 0, alpha: 0.5))
        

        
        
        let ortaSV = yatayStackViewOlustur(stackViewOlustur(imgKullaniciProfil,lblKullaniciAdi,spacing: 10, alignment: .center),  alignment : .center)

        
        yatayStackViewOlustur(btnGeri, ortaSV, btnBayrak).withMarging(.init(top: 0, left: 15, bottom: 0, right: 15))
        
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
