//
//  TransactionHistoryViewController.swift
//  SecuX EvPay
//
//  Created by Maochun Sun on 2020/6/29.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

class TransactionHistoryViewController: BaseViewController {
    
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UISetting.shared.vcBKColor
        //tableView.estimatedRowHeight = 60
        tableView.rowHeight = 70 //UITableView.automaticDimension
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
        
        view.addSubview(tableView)

        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
            
        ])
        
        tableView.register(TransHistoryTableViewCell.self, forCellReuseIdentifier: TransHistoryTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    let refreshControl = UIRefreshControl()
    
    let accountManager = SecuXAccountManager()
    var theAccount : CoinTokenAccount?
    
    var transHistory = [SecuXTransferHistory]()
    var loadRecordCompleted = false
    
    var loadIndex = 0
    let loadItemCount = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UISetting.shared.vcBKColor
        if let navCtrl = self.navigationController as? BaseUINavigationController{
            navCtrl.showMenuIcon(show: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showProgress(info: "Loading...")
        DispatchQueue.global(qos: .default).async {
            self.loadRecords()
            self.hideProgress()
        }
        
    }
    
    func loadRecords(){
        if let account = self.theAccount{
            
            let (ret, hisArray) = self.accountManager.getTransferHistory(coinType: account.coinType,
                                                                            token: account.token,
                                                                             page: self.loadIndex,
                                                                            count: self.loadItemCount)
            if ret == .SecuXRequestOK{
                
                if self.loadIndex == 0{
                    self.transHistory.removeAll()
                }
                
                if hisArray.count == self.loadItemCount{
                    self.loadIndex += 1
                }else{
                    self.loadRecordCompleted = true
                }
                
                
                self.transHistory.append(contentsOf: hisArray)
                
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
                
            }else if ret == .SecuXRequestUnauthorized{
                
                self.handleUnauthorizedError()
                
            }else{
                self.showMessageInMainThread(title: "Download transaction records failed", message: "")
            }
        }
            
    }
    
    @objc func refreshData(){
        self.refreshControl.beginRefreshing()
        DispatchQueue.global(qos: .default).async {
            
            //self.transHistory.removeAll()
            
            self.loadIndex = 0
            self.loadRecordCompleted = false
            self.loadRecords()
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            
        }

    }
}

extension TransactionHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.transHistory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TransHistoryTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .none
        if let commonCell = cell as? TransHistoryTableViewCell{
            commonCell.setup(history: self.transHistory[indexPath.row])
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //self.theTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        
        self.tabBarController?.tabBar.isHidden = true
        
        //let detailViewCtrl = TransDetailsViewController()
        //detailViewCtrl.accountHistory = self.theAccount?.accHistory[indexPath.row]
        
        //self.navigationController?.show(detailViewCtrl, sender: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !self.loadRecordCompleted, indexPath.row == self.transHistory.count - 1{
            self.showProgress(info: "Loading...")
            DispatchQueue.global(qos: .default).async {
                self.loadRecords()
                self.hideProgress()
            }
        }
    }
    
}
