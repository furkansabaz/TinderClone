//
//  EslesmelerMesajlarController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

class EslesmelerMesajlarController : UICollectionViewController {
    
    let navBar : UIView = {

        let nb = UIView(arkaPlanRenk: .white)
        
        let imgIkon = UIImageView(image: UIImage(named: "mesaj")?.withRenderingMode(.alwaysTemplate), contentMode: .scaleAspectFit)
        imgIkon.tintColor = #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1)
        
        
        let lblMesajlar = UILabel(text: "Mesajlar", font: .boldSystemFont(ofSize : 21), textColor: #colorLiteral(red: 0.9987122416, green: 0.3161283731, blue: 0.372920841, alpha: 1), textAlignment: .center)
        
        let lblFeed = UILabel(text: "Feed", font: .boldSystemFont(ofSize: 21), textColor: .gray, textAlignment: .center)
        
        
       
        
        
        nb.stackViewOlustur(imgIkon.yukseklikAyarla(45),
            nb.yatayStackViewOlustur(lblMesajlar,lblFeed,distribution: .fillEqually)).padTop(10)
        
        
        nb.golgeEkle(opacity: 0.15, yaricap: 10, offset: .init(width: 0, height: 10), renk: .init(white: 0, alpha: 0.3))
        return nb
        
    }()
    
    
    
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        view.addSubview(navBar)
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, boyut: .init(width: 0, height: 160))
    }
    
    
}
