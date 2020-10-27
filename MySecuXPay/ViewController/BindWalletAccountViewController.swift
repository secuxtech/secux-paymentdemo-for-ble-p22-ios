//
//  BindWalletAccountViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/4/6.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class BindWalletAccountViewController: BaseViewController {
    
    let maxInputFieldLen: CGFloat = 400
    var inputBoxOffset = 30.0
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 24)
        label.text = "Bind an account"
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
        return label
    }()
    
    lazy var nameInput: IconUITextField = {
     
        let input = IconUITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        //input.borderStyle = .roundRect
        input.keyboardType = UIKeyboardType.emailAddress
        
        input.returnKeyType = .done
        
        input.attributedPlaceholder = NSAttributedString(string: "Account Name",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                         NSAttributedString.Key.font: UIFont(name: "Arial", size: 17.0)!])
    
        input.tintColor = .white
        //input.layer.masksToBounds = true
        //input.layer.cornerRadius = 5.0
        
        //input.backgroundColor = .white //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
        //input.textColor = UIColor.darkGray
        //input.leftImage = UIImage(named: "accountIcon")
        
        input.backgroundColor = .clear
        input.textColor = .white
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        
        input.leftPadding = 10
        input.font = UIFont(name: "Arial", size: 19.0)
        
        
        self.view.addSubview(input)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
                input.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                input.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30),
                input.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                input.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                input.heightAnchor.constraint(equalToConstant: 45),
                input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
        
        
        return input
    }()
    
    lazy var coinTokenSelView: CoinTokenSelectionView = {
        let theView = CoinTokenSelectionView()
        theView.translatesAutoresizingMaskIntoConstraints = false
        theView.isHidden = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(coinTokenSelViewTappedAction(_:)))

        theView.isUserInteractionEnabled = true
        theView.addGestureRecognizer(tap)
        
        theView.setup(coin: "DASH", token: "DASH")
        
        self.view.addSubview(theView)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.nameInput.bottomAnchor, constant: 20),
                theView.widthAnchor.constraint(equalToConstant: maxInputFieldLen),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            ])
        }else{
            NSLayoutConstraint.activate([
                
                theView.topAnchor.constraint(equalTo: self.nameInput.bottomAnchor, constant: 20),
                theView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                theView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                theView.heightAnchor.constraint(equalToConstant: 50),
                theView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
        
        return theView
    }()
    
    lazy var createNewAccountButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("Create New Account", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 40),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.coinTokenSelView.bottomAnchor, constant: 40),
                btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    lazy var restoreAccountButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [.clear, .clear])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("Restore Account", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(restoreAccountButtonTapped), for: .touchUpInside)
        
        //btn.layer.shadowColor = UIColor.black.cgColor
        //btn.layer.shadowRadius = 2
        //btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        //btn.layer.shadowOpacity = 0.3
        
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UISetting.shared.buttonColor.cgColor
        btn.layer.borderWidth = 2
        
        self.view.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.createNewAccountButton.bottomAnchor, constant: 20),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.createNewAccountButton.bottomAnchor, constant: 20),
                btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.titleBKColor
        
        let _ = self.nameInput
        let _ = self.coinTokenSelView
        let _ = self.createNewAccountButton
        let _ = self.restoreAccountButton
        
        self.nameInput.becomeFirstResponder()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func coinTokenSelViewTappedAction(_ sender: UITapGestureRecognizer){
        
        if CoinTokenAccount.serverSupportedCoinAndTokenArray.count == 0{
            return
        }
        
        self.coinTokenSelView.dropdownToggle()
        
        
        let vc = CoinTokenSelectionViewController()
        var vcHeight = 50 * CoinTokenAccount.serverSupportedCoinAndTokenArray.count + 10
        if vcHeight > 300{
            vcHeight = 300
        }
        
        let vcWidth = 320 //self.coinTokenSelView.frame.width
        vc.preferredContentSize = CGSize(width: vcWidth, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.view
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationController?.sourceRect = CGRect(x: self.coinTokenSelView.frame.origin.x + self.coinTokenSelView.frame.width / 2 , y: self.coinTokenSelView.frame.origin.y + 45, width: 0, height: 0)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .lightGray
    
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func createNewAccountButtonTapped(){
        let vc = CreateWalletAccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func restoreAccountButtonTapped(){
        let vc = RestoreWalletAccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BindWalletAccountViewController: UIPopoverPresentationControllerDelegate{
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        
        print("popup menu dismissed")
        
        DispatchQueue.main.async {
            self.coinTokenSelView.dropdownToggle()
        }
        
        if let vc = popoverPresentationController.presentedViewController as? CoinTokenSelectionViewController,
            let item = vc.selCoinToken {
            
            DispatchQueue.main.async {
                self.coinTokenSelView.setup(coin: item.coin, token: item.token)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
