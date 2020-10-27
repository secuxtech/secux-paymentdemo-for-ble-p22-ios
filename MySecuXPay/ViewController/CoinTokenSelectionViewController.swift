//
//  CoinTokenSelectionViewController.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/25.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class CoinTokenSelectionViewController: UIViewController{
    
    var selCoinToken : (coin:String, token:String)?
    var theCoinTokenArray = [(coin:String, token:String)]()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 70
        tableView.rowHeight = 50
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.isScrollEnabled = true
        tableView.backgroundColor = UISetting.shared.titleBKColor
        
        tableView.layer.cornerRadius = 10
        
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 18),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
        
        ])
        
        tableView.register(CoinTokenSelectionTableViewCell.self, forCellReuseIdentifier: CoinTokenSelectionTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
        
        //self.view.layer.cornerRadius = 5
        
        /*
        self.theCoinTokenArray.append(("DCT", "SPC"))
        self.theCoinTokenArray.append(("LBR", "LBR"))
        self.theCoinTokenArray.append(("DASH", "DASH"))
        self.theCoinTokenArray.append(("BTC", "BTC"))
        */
        
        theCoinTokenArray = CoinTokenAccount.serverSupportedCoinAndTokenArray
        self.theTableView.reloadData()
    }
    
}


extension CoinTokenSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.theCoinTokenArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTokenSelectionTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .default
        if let commonCell = cell as? CoinTokenSelectionTableViewCell{
            
            let item = self.theCoinTokenArray[indexPath.row]
            commonCell.setup(coin: item.coin, token: item.token)
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        
        
        self.selCoinToken = self.theCoinTokenArray[indexPath.row]

        self.dismiss(animated: true, completion: nil)
        self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
        
    /*
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
        if let currSel = self.selAccount{

            var idx = 0
            for item in self.theAccounts{
                if item.name == currSel.name{
                    break
                }
                
                idx += 1
            }
            
            tableView.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryType = .none
            //tableView.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryView = nil
        }
        return indexPath
    }
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}
