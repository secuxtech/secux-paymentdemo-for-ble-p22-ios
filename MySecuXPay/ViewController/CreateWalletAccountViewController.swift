//
//  CreateWalletAccountViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/4/6.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class CreateWalletAccountViewController: BaseViewController {
    
    let maxInputFieldLen: CGFloat = 400
    var inputBoxOffset = 30.0
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 24)
        label.text = "Create New \(coinType) Account"
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
    
    lazy var msgLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.init(name: UISetting.shared.boldFontName, size: 17)
        label.text = "Please write down the words below\nin sequence"
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
        return label
    }()
    
    lazy var wordCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()

        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 10);

        // 設置每一行的間距
        layout.minimumLineSpacing = 5

        // 設置每個 cell 的尺寸
        layout.itemSize = CGSize(
            width: CGFloat(UIScreen.main.bounds.width)/3 - 20.0,
            height: 30)
        layout.scrollDirection = .vertical
        
        let thecv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        thecv.translatesAutoresizingMaskIntoConstraints = false
        
        thecv.delegate = self
        thecv.dataSource = self
        
        thecv.backgroundColor = UISetting.shared.vcBKColor
        
        self.view.addSubview(thecv)
        
        
        thecv.register(MnemonicWordCollectionViewCell.self, forCellWithReuseIdentifier: MnemonicWordCollectionViewCell.cellIdentifier())
        
        
        
        NSLayoutConstraint.activate([
            
            thecv.topAnchor.constraint(equalTo: self.msgLabel.bottomAnchor, constant: 15),
            thecv.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            thecv.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            thecv.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -20)

        ])
        
        return thecv
    }()
    
    
    lazy var nextButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60),
                btn.widthAnchor.constraint(equalToConstant: self.maxInputFieldLen),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        }else{
            NSLayoutConstraint.activate([
                
                btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60),
                btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: CGFloat(inputBoxOffset)),
                btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: CGFloat(0-inputBoxOffset)),
                //input.widthAnchor.constraint(equalToConstant: 200),
                btn.heightAnchor.constraint(equalToConstant: 45),
                btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                
            ])
        }
       
        return btn
    }()
    
    var coinType = "DASH"
    var wordArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.titleBKColor
        
        let _ = self.msgLabel
        let _ = self.nextButton
        
        let _ = self.wordCollectionView
        
        generateWords()
    }
    
    func generateWords(){
    
        /*
        if let generatedWords = try? Mnemonic.generate(strength: Mnemonic.Strength.veryHigh){
            let ret = generatedWords.joined(separator: " ")
            seed = generatedWords
            print("\(ret)")
    
        }
        */
        
     
        
        let generatedWords = DSWallet.generateRandomSeed()
        self.wordArray = generatedWords.components(separatedBy: " ")
        print("\(generatedWords)")
        
        let seed = DSBIP39Mnemonic.sharedInstance()?.deriveKey(fromPhrase: "pupil wild pulp follow practice future upset donate trigger expand bachelor lucky permit board design", withPassphrase: nil)
        print("\(seed?.hexDescription ?? "")")
        
        //let chain = DSChain.mainnet()
        let chain = DSChain.testnet()
        
        let wallet = DSWallet.standardWallet(withSeedPhrase: "pupil wild pulp follow practice future upset donate trigger expand bachelor lucky permit board design", setCreationDate: Date.timeIntervalBetween1970AndReferenceDate, for: chain, storeSeedPhrase: false, isTransient: false)
        
    
        let account = wallet?.account(withNumber: 0)
        
        
        //let derivationPath = account?.defaultDerivationPath
        //let path = derivationPath?.privateKeyString(at: 0, internal: false, fromSeed: seed!)
        //let bip44addrs = account?.bip44DerivationPath?.allChangeAddresses
        
        
        print(account?.bip32DerivationPath?.stringRepresentation ?? "")
        print(account?.bip44DerivationPath?.stringRepresentation ?? "")
        
        //let privkey1 = account?.bip44DerivationPath?.serializedExtendedPrivateKey(fromSeed: seed)
        account?.bip44DerivationPath?.generateExtendedPublicKey(fromSeed: seed!, storeUnderWalletUniqueId: nil)
        //let pubkey2 = account?.bip44DerivationPath?.serializedExtendedPublicKey()
        
        
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
        
        let privkeyArr = account?.bip44DerivationPath?.serializedPrivateKeys([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], internal: false, fromSeed: seed!)
        for i in 0 ... 10{
            print(privkeyArr![i])
        }
        
        /*
        //let deriPath = DSDerivationPath.init(serializedExtendedPrivateKey: privkeyArr![0] as! String, fundsType: DSDerivationPathType.authentication, signingAlgorithm: DSDerivationPathSigningAlgorith.ECDSA, on: chain)
        //print(deriPath?.stringRepresentation ?? "")
    
        //let subpath = DSFundsDerivationPath.init(serializedExtendedPrivateKey: privkeyArr![0] as! String, fundsType: DSDerivationPathType.authentication, signingAlgorithm: DSDerivationPathSigningAlgorith.ECDSA, on: chain)
        
    
        let ptr = UnsafeMutablePointer<UInt>.allocate(capacity: 5)
        ptr[0] = UInt(44 | BIP32_HARD)
        ptr[1] = UInt(5 | BIP32_HARD)
        ptr[2] = UInt(0 | BIP32_HARD)
        ptr[3] = 0
        ptr[4] = 0
        
        let bip32path = DSFundsDerivationPath.init(indexes: ptr, length: 5, type: DSDerivationPathType.authentication, signingAlgorithm: DSDerivationPathSigningAlgorith.ECDSA, reference: DSDerivationPathReference.BIP32, on: chain)
        
        let pubkey = bip32path?.generateExtendedPublicKey(fromSeed: seed!, storeUnderWalletUniqueId: nil)
       
        let address = bip32path?.address(at: IndexPath(row:0, section:0))
        
        print(bip32path!.stringRepresentation)
        print(bip32path?.serializedExtendedPublicKey())
    
        */

        let root = DSDerivationPath.serializedPrivateMaster(fromSeed: seed, for: chain)
        print("\(root ?? "")")
        
        //NSUInteger indexes[] = {FEATURE_PURPOSE_HARDENED, coinType | BIP32_HARD, 3 | BIP32_HARD, 1 | BIP32_HARD};
        //return [DSAuthenticationKeysDerivationPath derivationPathWithIndexes:indexes length:4 type:DSDerivationPathType_Authentication signingAlgorithm:DSDerivationPathSigningAlgorith_ECDSA reference:DSDerivationPathReference_ProviderVotingKeys onChain:chain];
   
        //let derivationPath = 
        //derivationPath.setAccount(account as! DSAccount)
        
        //let accountExtPK = derivationPath.serializedPrivateKeys(atIndexPaths: [IndexPath(row: 0, section: 0)], fromSeed: seed!)
        
        //print("\(accountExtPK)")
        
        //let path = DSFundsDerivationPath.bip44DerivationPath(on: chain, forAccountNumber: 0)
        //path.address(at: IndexPath(row: 0, section: 0))
        
        
        
        
        
        
    }
    
    @objc func nextButtonTapped(){
        
    }
    
    
}


extension CreateWalletAccountViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wordArray.count
    }
    //cellForItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MnemonicWordCollectionViewCell.cellIdentifier(), for: indexPath)
        
        if let commonCell = cell as? MnemonicWordCollectionViewCell{
            commonCell.setup(num:indexPath.row + 1, word:self.wordArray[indexPath.row])
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("Select item")
    }
}
