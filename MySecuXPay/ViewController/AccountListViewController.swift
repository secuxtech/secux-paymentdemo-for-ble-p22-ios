//
//  AccountListViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2
import swiftScan
//import Floaty

enum CoinTokenAccountOperation : String{
    case send = "Send"
    case receive = "Receive"
    case delete = "Delete"
    case history = "History"
}


class AccountListViewController: BaseViewController{
    
    let refreshControl = UIRefreshControl()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Accounts"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0.44, green: 0.44, blue: 0.44,alpha:1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 116),
                label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            ])
        }else{
            NSLayoutConstraint.activate([
            
                label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
             
            
            ])
        }
        
        
        return label
    }()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UISetting.shared.vcBKColor
        //tableView.estimatedRowHeight = 60
        tableView.rowHeight = 100 //UITableView.automaticDimension
        //tableView.allowsSelection = true
        //tableView.frame = self.view.bounds
        
        //tableView.borderColor = UIColor.black
        //tableView.borderWidth = 5.0
        
        tableView.showsVerticalScrollIndicator = false
    
        //tableView.estimatedRowHeight = 50
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        
        self.view.addSubview(tableView)

        if UIScreen.main.bounds.width > 460{
            NSLayoutConstraint.activate([
                
                tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
                tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 116),
                tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -116),
                tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
        }else{
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
                tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
                tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
                tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
                
            ])
        }
        
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    /*
    lazy var floatButton : Floaty = {
        let floaty = Floaty()
        
        floaty.hasShadow = true
        floaty.buttonColor = UISetting.shared.buttonColor
        floaty.plusColor = UISetting.shared.titleBKColor
        floaty.overlayColor = UIColor(red: 255, green: 255, blue: 255, alpha:0)
        floaty.openAnimationType = .fade
        floaty.itemTitleColor = .gray
        floaty.itemShadowColor = UIColor(red: 255, green: 255, blue: 255, alpha:0)
        floaty.itemButtonColor = UISetting.shared.titleBKColor
        floaty.itemSize = 50
        floaty.itemSpace = 12
        floaty.paddingX = 14
        floaty.paddingY = 74
        
        
        floaty.addItem("Unbind", icon: UIImage(named: "logout_btn")!, handler: { item in
            //self.logout()
            floaty.close()
            
            guard let account = self.theSelectedCell?.theAccount else{
                self.showMessageInMainThread(title: "No account", message: "")
                return
            }
            
            let alert = UIAlertController(title: "Unbind \(account.token) account?", message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                action in
                
                /*
                let (ret, data) = self.theAccountManager.unbindAccount(coinType: account.coinType, accountAddress: account.accountName)
                if ret == SecuXRequestResult.SecuXRequestOK, let account = MyAccount.shared.theUserAccount{
                    let _ = self.theAccountManager.getCoinAccountList(userAccount: account)
                    MyAccount.shared.setUserAccount(userAccount: account)
                    self.theTableView.reloadData()
                }else{
                    var errorMsg = ""
                    if let data = data, data.count > 0{
                        errorMsg = String(data: data, encoding: .utf8) ?? ""
                    }
                    self.showMessage(title: "Unbind failed!", message: errorMsg)
                }
                */
            })
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        })
        
        floaty.addItem("Bind", icon: UIImage(named: "account_info_btn")!, handler: { item in
            //self.showAccountInfo()
            floaty.close()
            
            //let vc = BindWalletAccountViewController()
            //self.navigationController?.pushViewController(vc, animated: true)
        })
        
        floaty.addItem("Add", icon: UIImage(named: "account_info_btn")!, handler: { item in
            //self.showAccountInfo()
            floaty.close()
        })
        
        self.view.addSubview(floaty)
        
        return floaty
    }()
    */
    
    lazy var addAccountButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_add"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "btn_add_click"), for: .highlighted)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addAccountAction), for: .touchUpInside)
        btn.isHidden = true
        self.view.addSubview(btn)

        NSLayoutConstraint.activate([

           
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),

            btn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)

        ])

        return btn
    }()
    
    
    let theAccountManager = SecuXAccountManager()
    var theSelectedCell : AccountTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(accountOperationMenuTapped))
        //let test = UIBarButtonItem(image: UIImage(named: "btn_add"), style: .plain, target: self, action: #selector(accountOperationMenuTapped))
        //self.navigationController?.navigationItem.rightBarButtonItems = [add, test]

        if let navCtrl = self.navigationController as? BaseUINavigationController{
            navCtrl.menuDelegate = self
        }
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
        
        if let navCtrl = self.navigationController as? BaseUINavigationController{
            navCtrl.setMenuItemArray(itemArr: [/*CoinTokenAccountOperation.send.rawValue, CoinTokenAccountOperation.history.rawValue,*/ CoinTokenAccountOperation.receive.rawValue, CoinTokenAccountOperation.delete.rawValue]);
        }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = ""
        
        //if MyAccount.shared.getCoinTokenAccount(coinType: "LBR") == nil{
            
        //    self.addAccount(coinType: "LBR")
            
        //}else{
            self.theTableView.reloadData()
        //}
    
        let _ = showAddbutton()
        
        //#if DEBUG
        //let _ = self.floatButton
        //#endif
        
        if let _ = self.theSelectedCell{
            if let navCtrl = self.navigationController as? BaseUINavigationController{
                navCtrl.showMenuIcon(show: true)
            }
            
        }else{
            if let navCtrl = self.navigationController as? BaseUINavigationController{
                navCtrl.showMenuIcon(show: false)
            }
        }
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //#if DEBUG
        //self.floatButton.close()
        //#endif
    }
    
    /*
    func getAccountInfo(){
        let accountManager = SecuXAccountManager()
        let theUserAccount = SecuXUserAccount(email: "maochuntest7@secuxtech.com", phone: "0975123456", password: "12345678")
        

        //Login test
        var (ret, data) = accountManager.loginUserAccount(userAccount: theUserAccount)
        guard ret == SecuXRequestResult.SecuXRequestOK else{
            print("login failed!")
            if let data = data{
                print("Error: \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
            }
            return
        }
        print("login done")
        
        //Get account balance
        (ret, data) = accountManager.getAccountBalance(userAccount: theUserAccount)
        guard ret == SecuXRequestResult.SecuXRequestOK else{
            print("get balance failed!")
            if let data = data{
                print("Error: \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
            }
            return
        }
        print("get account balance done")
        
        MyAccount.shared.setUserAccount(userAccount: theUserAccount)
        
        DispatchQueue.main.async {
            self.theTableView.reloadData()
        }
        
    }
    */
    
    
    @objc func addAccountAction(){
        
        
        let vc = NewAccountSelectionViewController()
        vc.itemArray = showAddbutton()
        vc.addAccountDelegate = self
        
        //for i in 0..<20{
        //    vc.itemArray["coin\(i)"] = "token\(i)"
        //}
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func refreshData(){
         print("refresh account list")
         self.refreshControl.beginRefreshing()
        
         DispatchQueue.main.async {
            self.theTableView.reloadData()
            self.refreshControl.endRefreshing()
         }
    }
    
    func updateAccountData(){
        self.theTableView.reloadData()
    }
    
    
    func getAvailableCoinTokenDict() -> [String : String] {
        var dict = [String : String]()
        dict["LBR"] = "Coin1"
        dict["CELO"] = "cUSD"
        //dict["DCT"] = "SPC"
        
        return dict;
    }
    
    func showAddbutton() -> [String : String]{
        
        var addDict = [String : String]()
        
        let dict = getAvailableCoinTokenDict()
        let keys = dict.keys
        
        for key in keys{
            guard let token = dict[key] else{
                continue
            }
            
            if  let _ = MyAccount.shared.getCoinTokenAccount(coinType: key, token: token){
                continue
            }
            
            addDict[key] = token
        }
        
        
        if !Setting.shared.forItriTestFlag{
        
            DispatchQueue.main.async {
                if addDict.count == 0{
                    self.addAccountButton.isHidden = true
                }else{
                    self.addAccountButton.isHidden = false
                }
            }
        }
        
        
        return addDict
    }

    /*
    func showAccountInfo(){
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    */
    
    func deleteAccount(account: CoinTokenAccount){
        
        if !Setting.shared.hasInternet.value{
          
            showMessage(title: "No network! Please check your phone's network setting.", message: "")
            return
        
        }
        
        self.showProgress(info: "Deleting...")
        
        DispatchQueue.global().async {
            let (ret, data) = self.theAccountManager.unbindAccount(coinType: account.coinType, accountName: account.accountName)
            self.hideProgress()
            if ret == SecuXRequestResult.SecuXRequestUnauthorized{
                self.handleUnauthorizedError()
            }else if ret != .SecuXRequestOK{
                var error = ""
                if let data = data{
                    error = String(decoding: data, as: UTF8.self)
                }
                self.showMessageInMainThread(title: "Delete acount failed!", message: error)
            }else{
                
                if let account = MyAccount.shared.theUserAccount{
                    let (ret, data) = self.theAccountManager.getCoinAccountList(userAccount: account)
                    if ret == SecuXRequestResult.SecuXRequestOK{
                        MyAccount.shared.setUserAccount(userAccount: account)
                        
                        DispatchQueue.main.async {
                            self.theTableView.reloadData()
                        }
                        
                    }else{
                        var error = ""
                        if let data = data{
                            error = String(decoding: data, as: UTF8.self)
                        }
                        self.showMessageInMainThread(title: "Load account list failed!", message: error)
                    }
                }
                
                let _ = self.showAddbutton()
                
            }
        }
        
    }
    
    func addAccount(coinType:String){
        self.showProgress(info: "Adding...")
        
        DispatchQueue.global().async {
            
            
            let (ret, data) = self.theAccountManager.addAccount(coinType: coinType)
            
            self.hideProgress()
            
            if ret == SecuXRequestResult.SecuXRequestUnauthorized{
                self.handleUnauthorizedError()
            }else if ret == SecuXRequestResult.SecuXRequestFailed{
                var error = ""
                if let data = data{
                    error = String(decoding: data, as: UTF8.self)
                }
                
                self.showMessageInMainThread(title: "Add new \(coinType) account failed!", message: error)
                
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
                
                
            }else{
                
                if let account = MyAccount.shared.theUserAccount{
                    let (ret, data) = self.theAccountManager.getCoinAccountList(userAccount: account)
                    if ret == SecuXRequestResult.SecuXRequestOK{
                        MyAccount.shared.setUserAccount(userAccount: account)
                        
                        let _ = self.showAddbutton()
                        
                        DispatchQueue.main.async {
                            self.theTableView.reloadData()
                        }
                        
                    }else{
                        var error = ""
                        if let data = data{
                            error = String(decoding: data, as: UTF8.self)
                        }
                        self.showMessageInMainThread(title: "Reload account list failed!", message: error)
                    }
                }
            }
            
        }
    }
}

extension AccountListViewController: BaseUINavigationControllerMenuDelegate{
    func selectManuItem(item: String) {
        guard let opt = CoinTokenAccountOperation.init(rawValue: item) else{
            return
        }
        
        guard let account = self.theSelectedCell?.theAccount else{
            return
        }
        
        switch opt {
        case .delete:
            
            DispatchQueue.main.async {
                
                let alert = UIAlertController(title: "Delete the account?", message: "", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
                
                let okAction = UIAlertAction(title: "DELETE", style: .default, handler: {
                    action in
                    
                    self.deleteAccount(account: account)
                })
                
                alert.addAction(cancelAction)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                
             
            }
           
            break
            
        case .history:
            DispatchQueue.main.async {
                let vc = TransactionHistoryViewController()
                vc.theAccount = account
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
        case .receive:
            DispatchQueue.main.async {
                let vc = ReceiveViewController()
                vc.theAccount = account
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            break
            
        case .send:
            DispatchQueue.main.async {
                var style = LBXScanViewStyle()
                style.centerUpOffset = 44
                style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On
                style.photoframeLineW = 6
                style.photoframeAngleW = 24
                style.photoframeAngleH = 24
                style.colorAngle = UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)
                style.isNeedShowRetangle = true
                style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
                style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
                
                let vc = LBXScanViewController()
                vc.scanStyle = style
                vc.scanResultDelegate = self
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
      
        }
    }
    
}

extension AccountListViewController: LBXScanViewControllerDelegate{
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        
        print("scan ret = \(scanResult.strScanned ?? "")")
        
        /*
         {"amount":"100", "coinType":"DCT", "deviceID": "4ab10000726b"}
        */
        
        if let accInfoStr = scanResult.strScanned, let accInfoData = accInfoStr.data(using: .utf8){
            do {
                if let accJson = try JSONSerialization.jsonObject(with:accInfoData, options: []) as? [String: String]{
                    
                    guard let accName = accJson["Name"] else{
                        self.showMessage(title: "No account name info.", message: "Send abort!")
                        return
                    }
                    guard let coin = accJson["Coin"] else{
                        self.showMessage(title: "No account coin info.", message: "Send abort!")
                        return
                    }
                    guard let token = accJson["Token"] else{
                        self.showMessage(title: "No account token info.", message: "Send abort!")
                        return
                    }
                    
                    print("pasing result: \(accName) \(coin) \(token)")
                    
                    let accountArray = MyAccount.shared.getCoinTokenAccountArray(coin: coin, token: token)
                    if accountArray.count == 0{
                        self.showMessage(title: "No \(coin):\(token) account available!", message: "Send abort!")
                        return
                    }else if accountArray[0].accountName.compare(accName) == .orderedSame{
                        self.showMessage(title: "Invalid account name", message: "Send abort!")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let vc = SendViewController()
                        vc.theAccount = accountArray[0]
                        vc.toAccountName = accName
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                   
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
            
            return
        }
        
        self.showMessage(title: "Invalid QRCode!", message: "Please try again.")
    }
    
}

extension AccountListViewController: NewAccountSelectionViewControllerDelegate{
    func AddNewAccount(coinType: String) {
        self.addAccount(coinType: coinType)
    }

}


extension AccountListViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MyAccount.shared.theCoinTokenAccountArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .none
        if let commonCell = cell as? AccountTableViewCell,
            let account = MyAccount.shared.theCoinTokenAccountArray?[indexPath.row]{
            
            commonCell.setup(account: account)
            
            DispatchQueue.global().async {
                let (ret, data) = self.theAccountManager.getAccountBalance(userAccount: MyAccount.shared.theUserAccount!, coinType: account.coinType, token: account.token)
                
                DispatchQueue.main.async {
                    commonCell.showBalance()
                }
                
                if ret == SecuXRequestResult.SecuXRequestOK{
                    
                }else if ret == SecuXRequestResult.SecuXRequestNoToken || ret == SecuXRequestResult.SecuXRequestUnauthorized{
                    self.handleUnauthorizedError()
                }else{
                    var error = ""
                    if let data = data{
                        error = String(data: data, encoding: .utf8) ?? ""
                    }
                    logw("Get account \(account.accountName) balance failed! \(error)")
                    //self.showMessageInMainThread(title: "Get account \(account.accountName) balance failed!", message: error)
                }
            }
            
            /*
            if indexPath.row == 0{
                commonCell.onTapped(flag: true)
                self.theSelectedCell = commonCell
            }else{
                commonCell.onTapped(flag: false)
            }
            */
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        self.theSelectedCell?.onTapped(flag: false)
        
        if !Setting.shared.forItriTestFlag{
            if let cell = tableView.cellForRow(at: indexPath)as? AccountTableViewCell{
                if self.theSelectedCell != cell{
                    
                    cell.onTapped(flag:true)
                    self.theSelectedCell = cell
                }else{
                    self.theSelectedCell = nil
                }
            }
            
            if let _ = self.theSelectedCell{
                if let navCtrl = self.navigationController as? BaseUINavigationController{
                    navCtrl.showMenuIcon(show: true)
                }
                
            }else{
                if let navCtrl = self.navigationController as? BaseUINavigationController{
                    navCtrl.showMenuIcon(show: false)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //let movedObject = self.self.sectionArray[sourceIndexPath.section].itemNameArr[sourceIndexPath.row]
        //self.sectionArray[sourceIndexPath.section].itemNameArr.remove(at: sourceIndexPath.row)
        //self.sectionArray[destinationIndexPath.section].itemNameArr.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
