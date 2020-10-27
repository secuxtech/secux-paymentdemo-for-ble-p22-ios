//
//  MainTabBarController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let paymentMainVC = BaseUINavigationController(rootViewController: PaymentMainViewController())
        let accountListVC = BaseUINavigationController(rootViewController: AccountListViewController())
        let userInfoVC = BaseUINavigationController(rootViewController: SettingViewController())
        
        let paymentTab = UITabBarItem()
        paymentTab.title = "Payment"
        paymentTab.image = UIImage(named: "main_nav_payment")
        paymentTab.selectedImage = UIImage(named: "main_nav_payment_select")
        paymentTab.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.12, green: 0.13, blue: 0.13,alpha:1)], for: .selected)
        paymentMainVC.tabBarItem = paymentTab
        
        
        let accountTab = UITabBarItem()
        accountTab.title = "Accounts"
        accountTab.image = UIImage(named: "main_nav_accounts")
        accountTab.selectedImage = UIImage(named: "main_nav_accounts_select")
        accountTab.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.12, green: 0.13, blue: 0.13,alpha:1)], for: .selected)
        accountListVC.tabBarItem = accountTab
        
        
        let userTab = UITabBarItem()
        userTab.title = "User"
        userTab.image = UIImage(named: "main_nav_userinfo")
        userTab.selectedImage = UIImage(named: "main_nav_userinfo_select")
        userTab.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.12, green: 0.13, blue: 0.13,alpha:1)], for: .selected)
        userInfoVC.tabBarItem = userTab
        
        self.tabBar.barTintColor = .white
        
        viewControllers = [accountListVC, paymentMainVC, userInfoVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Accounts"{
            
            if let vc = self.selectedViewController as? UINavigationController,
                let accVC = vc.viewControllers.first as? AccountListViewController{
                accVC.updateAccountData()
            }
        }
    }
}
