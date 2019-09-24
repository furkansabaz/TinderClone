//
//  EslesmelerNavBar.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 24.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit


class EslesmelerNavBar : UIView {
    let btnGeri = UIButton(image: UIImage(named: "alev")!, tintColor: .lightGray)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

         let imgIkon = UIImageView(image: UIImage(named: "mesaj")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
         imgIkon.tintColor = #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1)
         
         
         let lblMesajlar = UILabel(text: "Mesajlar", font: .boldSystemFont(ofSize : 21), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1), textAlignment: .center)
         
         let lblFeed = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 21), textColor: .gray, textAlignment: .center)
         
         
        
         
         
         stackViewOlustur(imgIkon.yukseklikAyarla(45),
             yatayStackViewOlustur(lblMesajlar,lblFeed,distribution: .fillEqually)).padTop(10)
         
         
         golgeEkle(opacity: 0.15, yaricap: 10, offset: .init(width: 0, height: 10), renk: .init(white: 0, alpha: 0.3))
        
        
        addSubview(btnGeri)
        
        btnGeri.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), boyut: .init(width: 35, height: 35))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
