//
//  MesajKayitController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 25.09.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import Foundation
import UIKit

struct Mesaj {
    let text : String
}

class MesajCell : ListeCell<Mesaj> {
    override var veri: Mesaj! {
        didSet {
            backgroundColor = .blue
        }
    }
    
}


class MesajKayitController : ListeController<MesajCell,Mesaj>{
    
    fileprivate lazy var navBar = MesajNavBar(eslesme: eslesme)
    fileprivate let navBarYukseklik : CGFloat = 125
    
    fileprivate let eslesme : Eslesme
    
    init(eslesme : Eslesme) {
        self.eslesme = eslesme
        super.init()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.btnGeri.addTarget(self, action: #selector(btnGeriPressed), for: .touchUpInside)
        
        veriler = [
            .init(text: "Udemy Kursundan Herkese Selamlar"),
            .init(text: "Udemy Kursundan Herkese Selamlar"),
            .init(text: "Udemy Kursundan Herkese Selamlar"),
            .init(text: "Udemy Kursundan Herkese Selamlar")
        ]
        
        view.addSubview(navBar)
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,boyut: .init(width: 0, height: navBarYukseklik))
        
        //collectionview hücrelerini belirtilen boşluktan itibaren oluşturmaya başlar.
        collectionView.contentInset.top = navBarYukseklik
    }
    
    
    @objc fileprivate func  btnGeriPressed() {
        navigationController?.popViewController(animated: true)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MesajKayitController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

