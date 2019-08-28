//
//  FotoGecisController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 27.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class FotoGecisController: UIPageViewController {
    
    var kullaniciViewModel : KullaniciProfilViewModel! {
        didSet {
            print(kullaniciViewModel.attrString)
            controllers = kullaniciViewModel.goruntuAdlari.map({(goruntuURL) -> UIViewController in
                let fotoController = FotoController(goruntuURL: goruntuURL)
                return fotoController
            })
            setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
            barViewEkle()
            
        }
    }
    
    fileprivate let seciliOlmayanBarRenk = UIColor(white: 0, alpha: 0.2)
    fileprivate let barStackView = UIStackView(arrangedSubviews: [])
    fileprivate func barViewEkle() {
        
        kullaniciViewModel.goruntuAdlari.forEach { (_) in
            let barView = UIView()
            barView.backgroundColor = seciliOlmayanBarRenk
            barView.layer.cornerRadius = 3
            barStackView.addArrangedSubview(barView)
        }
        barStackView.arrangedSubviews.first?.backgroundColor = .white
        barStackView.spacing = 4
        barStackView.distribution = .fillEqually
        
        view.addSubview(barStackView)
        
        _ = barStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8), boyut: .init(width: 0, height: 4))
        
    }
    
   var controllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        dataSource = self
        delegate = self

        
        
        
    }
    

}

extension FotoGecisController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = self.controllers.firstIndex(where: { $0 == viewController }) ?? 0
        
        if index == 0 { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = self.controllers.firstIndex(where: { $0 == viewController}) ?? 0
        print("Index değeri : \(index)")
        if index == controllers.count-1 { return nil}
        return controllers[index+1]
    }
}

extension FotoGecisController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let gosterilenFotoController = viewControllers?.first
        
        if let index = controllers.firstIndex(where:  {   $0 == gosterilenFotoController }) {
            
            barStackView.arrangedSubviews.forEach({  $0.backgroundColor = seciliOlmayanBarRenk })
            barStackView.arrangedSubviews[index].backgroundColor = .white
        }
        
        
    }
}

class FotoController : UIViewController {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "apple"))
    
    
    init(goruntuURL : String) {
        if let url = URL(string: goruntuURL) {
            imageView.sd_setImage(with: url)
        }
        super.init(nibName: nil, bundle: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.doldurSuperView()
        imageView.contentMode = .scaleAspectFill
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
