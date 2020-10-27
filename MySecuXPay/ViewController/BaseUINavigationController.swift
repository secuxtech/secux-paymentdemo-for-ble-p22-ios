//
//  BaseUINavigationController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/11.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

protocol BaseUINavigationControllerMenuDelegate {
    func selectManuItem(item:String)
}

class BaseUINavigationController: UINavigationController{
    
    var popToRootFlag = false
    var gobackCount = 1
    var menuItemArray = [String]()
    var menuDelegate : BaseUINavigationControllerMenuDelegate?
    
    
    lazy var menuButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "menu_icon"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "menu_icon"), for: .highlighted)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        btn.isHidden = true
        self.navigationBar.addSubview(btn)

        NSLayoutConstraint.activate([

            //btn.topAnchor.constraint(equalTo: self.navigationBar.topAnchor, constant: 2),
            btn.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor, constant: 0),

            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10)

        ])

        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = .black
        self.navigationBar.tintColor = UIColor.white
        //navRootVC.navigationBar.barTintColor = .blue
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white];
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.backIndicatorImage = UIImage()
        self.navigationBar.isTranslucent = false
        
        self.navigationBar.barTintColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 24)!,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let titleImgView = UIImageView(image: UIImage(named: "SecuX_Logo"))
        titleImgView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationBar.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: self.navigationBar.centerXAnchor).isActive = true
        titleImgView.centerYAnchor.constraint(equalTo: self.navigationBar.centerYAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if popToRootFlag {
            return super.popToRootViewController(animated: animated)?.last
        }else if self.gobackCount > 1{
            let viewControllers = self.viewControllers

            if viewControllers.count >= self.gobackCount {
                for _ in 1..<self.gobackCount {
                    let _ = super.popViewController(animated: false)
                }

            }
        }

        return super.popViewController(animated: animated)
    }
    
    func showMenuIcon(show:Bool){
        self.menuButton.isHidden = !show
    }
    
    func setMenuItemArray(itemArr:[String]){
        self.menuItemArray = itemArr
    }
    
    @objc func menuTapped(){
        
        /*
        let vc = MainMenuViewController()
        vc.itemArray = self.menuItemArray
        var vcHeight = 50 * self.menuItemArray.count + 10
        if vcHeight > 300{
            vcHeight = 300
        }
        
        let vcWidth = 200 //self.coinTokenSelView.frame.width
        vc.preferredContentSize = CGSize(width: vcWidth, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.menuButton //self.coinTokenSelView
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up //UIPopoverArrowDirection(rawValue: 0) //
        popoverPresentationController?.sourceRect = CGRect(x:200, y:10, width: 0, height: 0)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .clear
        
        self.present(vc, animated: true, completion: nil)
        */
        
        let vc = MainMenuViewController()
        var vcHeight = 50 * self.menuItemArray.count + 10
        if vcHeight > 220{
            vcHeight = 220
        }
        vc.preferredContentSize = CGSize(width: 180, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        vc.itemArray = self.menuItemArray

        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.menuButton
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0) //UIPopoverArrowDirection.up // UIPopoverArrowDirection(rawValue: 0)
        //popoverPresentationController?.sourceRect = CGRect(x: (self.topViewController?.view)!.frame.width-180, y: 110, width: 200, height: 10)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .clear

        self.present(vc, animated: true, completion: nil)
        
    }
}


extension BaseUINavigationController: UIPopoverPresentationControllerDelegate{
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        print("popup menu dismissed")
        
        DispatchQueue.global().async {
            if let vc = popoverPresentationController.presentedViewController as? MainMenuViewController, vc.selItemTxt.count > 0{
                //let item = vc.selItemTxt
                self.menuDelegate?.selectManuItem(item: vc.selItemTxt)
            }
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
