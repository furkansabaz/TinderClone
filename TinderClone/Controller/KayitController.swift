//
//  KayitController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 5.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class KayitController: UIViewController {

    let btnFotografSec : UIButton = {
       
        let btn = UIButton(type: .system)
        
        btn.setTitle("Fotoğraf Seç", for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        
        btn.setTitleColor(.black, for: .normal)

        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        
        btn.heightAnchor.constraint(equalToConstant: 280).isActive = true
        return btn
    }()
    
    
    let txtEmailAdresi : OzelTextField = {
        
        let txt =  OzelTextField(padding: 15)
        txt.backgroundColor = .white
        txt.placeholder = "Email Adresiniz"
        txt.keyboardType = .emailAddress
        
        return txt
    }()
    
    let txtAdiSoyadi : OzelTextField = {
        
        let txt = OzelTextField(padding: 15)
        
        txt.backgroundColor = .white
        txt.placeholder = "Ad ve Soyad"
        
        return txt
        
    }()
    
    
    let txtParola : OzelTextField = {
        
        let txt = OzelTextField(padding: 15)
        
        txt.backgroundColor = .white
        txt.placeholder = "Parolanız"
        txt.isSecureTextEntry = true
        return txt
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        arkaPlanGradientAyarla()
        //view.backgroundColor = .gray
        
        
        let kayitSV = UIStackView(arrangedSubviews: [
        btnFotografSec,
        txtEmailAdresi,
        txtAdiSoyadi,
        txtParola
        ])
        
        view.addSubview(kayitSV)
        
        kayitSV.axis = .vertical
        
        kayitSV.spacing = 10
        _ = kayitSV.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 45, bottom: 0, right: 45))
        
        kayitSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func arkaPlanGradientAyarla() {
        
        
        let gradient = CAGradientLayer()
        let ustRenk = #colorLiteral(red: 0.6392156863, green: 0.8, blue: 0.9568627451, alpha: 1)
        let altRenk = #colorLiteral(red: 0.1215686275, green: 0.1490196078, blue: 0.737254902, alpha: 1)
        
        gradient.colors = [ustRenk.cgColor, altRenk.cgColor]
        
        gradient.locations = [0,1]
        
        view.layer.addSublayer(gradient)
        gradient.frame = view.bounds
        
        
    }


}
