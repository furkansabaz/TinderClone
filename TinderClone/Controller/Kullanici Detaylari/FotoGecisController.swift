//
//  FotoGecisController.swift
//  TinderClone
//
//  Created by Furkan Sabaz on 27.08.2019.
//  Copyright © 2019 Furkan Sabaz. All rights reserved.
//

import UIKit

class FotoGecisController: UIPageViewController {
    
    
    let controllers = [
    FotoController(image: #imageLiteral(resourceName: "boost")),
    FotoController(image: #imageLiteral(resourceName: "profilKapat")),
    FotoController(image: #imageLiteral(resourceName: "kapat")),
    FotoController(image: #imageLiteral(resourceName: "like")),
    FotoController(image: #imageLiteral(resourceName: "superLike")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        dataSource = self
        

        
        
        setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
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

class FotoController : UIViewController {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "apple"))
    
    init(image : UIImage) {
        self.imageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.doldurSuperView()
        imageView.contentMode = .scaleAspectFit
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
