//
//  EslesmelerMesajlarController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 23.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit


class EslesmeCell : ListeCell<UIColor> {
    
    let imgProfil =  UIImageView(image: UIImage(named: "kisi4"),contentMode: .scaleAspectFill)
    let lblKullaniciAdi = UILabel(text: "Sefa123", font: .systemFont(ofSize: 15, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 2)
    override var veri: UIColor! {
        didSet {
            backgroundColor = veri
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



class EslesmelerMesajlarController : ListeController<EslesmeCell,UIColor>, UICollectionViewDelegateFlowLayout {
    
    
    let navBar = EslesmelerNavBar()
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 125, height: 145)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veriler = [.yellow, .green, .orange, .purple]
        
        navBar.btnGeri.addTarget(self, action: #selector(btnGeriPressed), for: .touchUpInside)
        collectionView.backgroundColor = .white
        view.addSubview(navBar)
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, boyut: .init(width: 0, height: 150))
        
        collectionView.contentInset.top = 150
    }
    
    @objc fileprivate func btnGeriPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
