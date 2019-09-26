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
    let benimMesajim : Bool
}

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
            
            txtMesaj.text = veri.text
            
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
            .init(text: "Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar.Udemy Kursundan Herkese Selamlar", benimMesajim: false ),
            .init(text: "Nasılsın", benimMesajim: true),
            .init(text: "Udemy Kursundan Herkese Selamlar", benimMesajim: false),
            .init(text: "Udemy Kursundan Herkese Selamlar", benimMesajim: true)
        ]
        
        view.addSubview(navBar)
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,boyut: .init(width: 0, height: navBarYukseklik))
        
        //collectionview hücrelerini belirtilen boşluktan itibaren oluşturmaya başlar.
        collectionView.contentInset.top = navBarYukseklik
        
        
        let statusBar = UIView(arkaPlanRenk: .white)
        view.addSubview(statusBar)
        statusBar.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        collectionView.verticalScrollIndicatorInsets.top = navBarYukseklik
        
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
        
        
        let tahminiHucre = MesajCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        //mesaj içeriğini hücreye aktardık
        tahminiHucre.veri = self.veriler[indexPath.item]
        
        tahminiHucre.layoutIfNeeded()
        
        let tahminiBoyut = tahminiHucre.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return .init(width: view.frame.width, height: tahminiBoyut.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

