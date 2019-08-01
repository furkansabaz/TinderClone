//
//  ViewController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 31.07.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ustStackView = AnaGorunumUstStackView()
    let yesilView = UIView()
    //MARK:- ÜST MENÜDEKİ bUTONLARI TUTAR
    let butonlarStackView = AnaGorunumAltStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        yesilView.backgroundColor = .green
        
        layoutDuzenle()
        
    }
    
    
    //MARK:- LAYOUT DÜZENLEYEN FONKSİYON
    func layoutDuzenle() {
        let genelStackView = UIStackView(arrangedSubviews: [ustStackView, yesilView,butonlarStackView])
        genelStackView.axis = .vertical
        view.addSubview(genelStackView)
        
        
        genelStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }


}

