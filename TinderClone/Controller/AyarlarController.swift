//
//  AyarlarController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 24.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class AyarlarController: UITableViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    
    
    func butonOlustur(selector : Selector) -> UIButton {
        
        let buton = UIButton(type: .system)
        buton.layer.cornerRadius = 10
        buton.clipsToBounds = true
        buton.backgroundColor = .white
        buton.setTitle("Fotoğraf Seç", for: .normal)
        
        buton.addTarget(self, action: selector, for: .touchUpInside)
        return buton
    }
    
    
    lazy var btnGoruntu1Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    lazy var btnGoruntu2Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    lazy var btnGoruntu3Sec = butonOlustur(selector: #selector(btnGoruntuSecPressed))
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationOlustur()
        tableView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        
    }
    
    
    
    
    
    
   
    
    
    
    @objc fileprivate func btnGoruntuSecPressed(buton : UIButton) {
        
        let imagePicker = CustomImagePickerController()
        imagePicker.btnGoruntuSec = buton
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let secilenGoruntu = info[.originalImage] as? UIImage
        let btnGoruntuSec = (picker as? CustomImagePickerController)?.btnGoruntuSec
        btnGoruntuSec?.setImage(secilenGoruntu?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnGoruntuSec?.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
    
    lazy var fotoAlan : UIView = {
       let fotoAlan = UIView()
        
        
        fotoAlan.addSubview(btnGoruntu1Sec)
        
        _ = btnGoruntu1Sec.anchor(top: fotoAlan.topAnchor,
                                  bottom: fotoAlan.bottomAnchor,
                                  leading: fotoAlan.leadingAnchor,
                                  trailing: nil,
                                  padding: .init(top: 15, left: 15, bottom: 15, right: 0))
        
        btnGoruntu1Sec.widthAnchor.constraint(equalTo: fotoAlan.widthAnchor, multiplier: 0.42).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [btnGoruntu2Sec,btnGoruntu3Sec])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        fotoAlan.addSubview(stackView)
        
        _ = stackView.anchor(top: fotoAlan.topAnchor,
                             bottom: fotoAlan.bottomAnchor,
                             leading: btnGoruntu1Sec.trailingAnchor,
                             trailing: fotoAlan.trailingAnchor,
                             padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        return fotoAlan
    }()
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return fotoAlan
        }
        
        let lblBaslik = LabelBaslik()
        
        
        switch section {
        case 1 :
                lblBaslik.text = "Ad Soyad"
        case 2 :
                lblBaslik.text = "Yaş"
        case 3 :
                lblBaslik.text = "Meslek"
        case 4 :
                lblBaslik.text = "Hakkında"
        default :
            lblBaslik.text = "Hakkında"
        }
        
        return lblBaslik
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 320
        }
        return 45
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 5
       }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AyarlarCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 1 :
            cell.textField.placeholder = "Adınız ve Soyadınız"
        case 2 :
            cell.textField.placeholder = "Yaşınız"
        case 3 :
            cell.textField.placeholder = "Mesleğiniz"
        case 4 :
            cell.textField.placeholder = "Kendinizden Bahsedin"
        default :
            cell.textField.placeholder = "Kendinizden Bahsedin"
        }
        return cell
    }
    
    
    fileprivate func navigationOlustur() {
        navigationItem.title = "Ayarlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(btnIptalPressed))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Oturumu Kapat", style: .plain, target: self, action: #selector(btnOturumuKapatPressed))
    }

    @objc fileprivate func btnOturumuKapatPressed() {
        print("Oturumunuz Kapatılacaktır")
    }
    @objc fileprivate func btnIptalPressed() {
        dismiss(animated: true)
    }
    

}


class CustomImagePickerController : UIImagePickerController {
    var btnGoruntuSec : UIButton?
}

class LabelBaslik : UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 15, dy: 0))
    }
}
