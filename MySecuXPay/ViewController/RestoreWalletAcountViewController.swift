//
//  RestoreWalletAcountViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/4/6.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit


class RestoreWalletAccountViewController: BaseViewController {
    
    let maxInputFieldLen: CGFloat = 400
    var inputBoxOffset = 30.0
    
    var coinType = ""
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 24)
        label.text = "Restore \(self.coinType) account"
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
    
    lazy var warningLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 15)
        label.text = "Input your 24-word Backup Phrase\nin the correct sequence below"
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40)
            
        ])
        
        return label
    }()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        //tableView.estimatedRowHeight = 60
        tableView.rowHeight = 70 //UITableView.automaticDimension
        //tableView.allowsSelection = true
        //tableView.frame = self.view.bounds
        
        //tableView.borderColor = UIColor.black
        //tableView.borderWidth = 5.0
        
        tableView.showsVerticalScrollIndicator = false
    
        //tableView.estimatedRowHeight = 50
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        
        
        //tableView.addSubview(refreshControl)
        //refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        
        self.view.addSubview(tableView)

        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                tableView.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 20),
                tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 116),
                tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -116),
                tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
            ])
        }else{
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 20),
                tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
                
            ])
        }
        
        tableView.register(MnemonicWordTableViewCell.self, forCellReuseIdentifier: MnemonicWordTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    
    lazy var restoreButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("Restore Account", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.theTableView.bottomAnchor, constant: 20),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.topAnchor.constraint(equalTo: self.theTableView.bottomAnchor, constant: 20),
                btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    var wordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.titleBKColor
        
        for _ in 1...12{
            wordArray.append("")
        }
        
        wordArray[0] = "bar"
        wordArray[1] = "course"
        wordArray[2] = "harbor"
        wordArray[3] = "bargain"
        wordArray[4] = "load"
        wordArray[5] = "magic"
        wordArray[6] = "grunt"
        wordArray[7] = "soldier"
        wordArray[8] = "mean"
        wordArray[9] = "initial"
        wordArray[10] = "salad"
        wordArray[11] = "fuel"
        
        let _ = self.restoreButton
        self.theTableView.reloadData()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func restoreButtonTapped(){
        
        var wordsPhrase = ""
        for i in 0...11{
            if let cell = self.theTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? MnemonicWordTableViewCell{
                if !cell.isValid{
                    //self.showMessage(title: "Word \(i+1) is invalid!", message: "")
                    //return
                }
            }
            
            wordsPhrase.append("\(self.wordArray[i]) ")
        }
        
        
        wordsPhrase = DSBIP39Mnemonic.sharedInstance()?.normalizePhrase(wordsPhrase) ?? ""
        guard let seed = DSBIP39Mnemonic.sharedInstance()?.deriveKey(fromPhrase: wordsPhrase, withPassphrase: nil) else{
            logw("generate seed failef")
            self.showMessage(title: "Generate seed failed!", message: "")
            return
        }
        print("\(seed.hexDescription )")

        //let chain = DSChain.mainnet()
        let chain = DSChain.testnet()
        let wallet = DSWallet.standardWallet(withSeedPhrase: wordsPhrase, setCreationDate: Date.timeIntervalBetween1970AndReferenceDate, for: chain, storeSeedPhrase: false, isTransient: false)


        let account = wallet?.account(withNumber: 0)
        
        print(account?.bip44DerivationPath?.stringRepresentation ?? "")

        account?.bip44DerivationPath?.generateExtendedPublicKey(fromSeed: seed, storeUnderWalletUniqueId: nil)
        
        var addressArr = [String]()
        for i in 0 ... 10{
            if let address = account?.bip44DerivationPath?.address(at: UInt32(i), internal: false){
                print("\(i) \(address)")
                addressArr.append(address)
            }
        }
        
        var pubkeyArr = [Data]()
        for i in 0 ... 10{
            if let pubkey = account?.bip44DerivationPath?.publicKeyData(at:UInt32(i), internal: false){
                print("\(i) \(pubkey.hexDescription)")
                pubkeyArr.append(pubkey)
            }
        }
        
        let privkeyArr = account?.bip44DerivationPath?.serializedPrivateKeys([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], internal: false, fromSeed: seed)
        for i in 0 ... 10{
            print(privkeyArr![i])
        }
        
        
        let accManager = SecuXAccountManager()
        let (ret, data) = accManager.bindNewAccount(coinType: "DASH", accountAddress: addressArr[0], name: "DASH-test1")
        if ret == SecuXRequestResult.SecuXRequestOK, let account = MyAccount.shared.theUserAccount{
            let _ = accManager.getCoinAccountList(userAccount: account)
            MyAccount.shared.setUserAccount(userAccount: account)
            MyAccount.shared.updateCoinAddressAndSeedDict(address: addressArr[0], seed: seed)
        }else{
            var errorMsg = ""
            if let data = data, data.count > 0,
               let msg = String(data: data, encoding: .utf8){
                errorMsg = "Error: " +  msg
            }
            
            self.showMessage(title: "Bind account failed!", message: errorMsg)
        }
    }
    
}


extension RestoreWalletAccountViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.wordArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("item \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MnemonicWordTableViewCell.cellIdentifier(), for:indexPath)
        //cell.selectionStyle = .none
        if let commonCell = cell as? MnemonicWordTableViewCell{
            commonCell.setup(num: indexPath.row, word:self.wordArray[indexPath.row])
            commonCell.delegate = self
        }
        
        return cell
    }


}


extension RestoreWalletAccountViewController: MnemonicWordTableViewCellDelegate{
    func inputWord(num: Int, word: String) {
        print("inputWord \(num) \(word)")
        self.wordArray[num] = word
    }
    
    
}
