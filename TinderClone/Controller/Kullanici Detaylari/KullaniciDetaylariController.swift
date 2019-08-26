//
//  KullaniciDetaylariController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 26.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class KullaniciDetaylariController: UIViewController {

    
    
    lazy var scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
        
    }()
    
    
    let imgProfil : UIImageView = {
        
        let img = UIImageView(image: #imageLiteral(resourceName: "apple"))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let lblBilgi : UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Sibel Kara 40\nÖğretmen\nÖğrencilerimi çok severim"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        view.addSubview(scrollView)
        scrollView.doldurSuperView()
        
        
        scrollView.addSubview(imgProfil)
        imgProfil.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        
        scrollView.addSubview(lblBilgi)
        _ = lblBilgi.anchor(top: imgProfil.bottomAnchor, bottom: nil, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureKapat)))
        
    }
    
    @objc fileprivate func tapGestureKapat() {
        self.dismiss(animated: true)
    }
    


}

extension KullaniciDetaylariController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yFark = scrollView.contentOffset.y
        print("Y Fark : ",yFark)
        var width = view.frame.width - 2*yFark
        width = max(view.frame.width,width)
        
        
        imgProfil.frame = CGRect(x: min(0,yFark), y: min(0,yFark), width: width, height: width)
        
    }
}
