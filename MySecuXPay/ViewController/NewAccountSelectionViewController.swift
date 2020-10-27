//
//  NewAccountSelectionViewController.swift
//  SecuX EvPay
//
//  Created by Maochun Sun on 2020/6/19.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import secux_paymentkit_v2

protocol NewAccountSelectionViewControllerDelegate {
    func AddNewAccount(coinType:String)
}


class NewAccountSelectionViewController: BaseViewController {
    
    let theAccountManager = SecuXAccountManager()
    var itemArray = [String:String]()
    var selItemTxt = ""
    var selIndexPath : IndexPath?
    
    let theTableViewRowHeight : CGFloat = 50
    var theTableViewHeightConstraint : NSLayoutConstraint?
    
    var addAccountDelegate: NewAccountSelectionViewControllerDelegate?
    
    
    lazy var bkView: UIView = {
        let bkview = UIView()
        bkview.translatesAutoresizingMaskIntoConstraints = false
        bkview.backgroundColor = .white
        
        bkview.layer.cornerRadius = 10
        
        bkview.layer.shadowColor = UIColor.darkGray.cgColor
        //bkview.layer.shadowPath = UIBezierPath(roundedRect: bkview.bounds, cornerRadius: 10).cgPath
        bkview.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        bkview.layer.shadowOpacity = 0.4
        bkview.layer.shadowRadius = 3.0
        
        
        self.view.addSubview(bkview)
        
        NSLayoutConstraint.activate([
            
            bkview.leftAnchor.constraint(equalTo: self.theTableView.leftAnchor, constant: -5),
            bkview.rightAnchor.constraint(equalTo: self.theTableView.rightAnchor, constant: 5),
            bkview.topAnchor.constraint(equalTo: self.theTableView.topAnchor, constant: -6),
            bkview.bottomAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 6)
            
        ])
        
        return bkview
    }()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 70
        tableView.rowHeight = self.theTableViewRowHeight
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white //UISetting.shared.titleBKColor
        
        
        tableView.layer.cornerRadius = 5
        
        self.view.addSubview(tableView)
        
        self.theTableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 320)

        NSLayoutConstraint.activate([
            
            tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            self.theTableViewHeightConstraint!
        
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"NewAccountCoinTokenTableViewCell")
        
        return tableView
    }()
    
    
    lazy var addButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UISetting.shared.buttonColor, UISetting.shared.buttonColor])
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: UISetting.shared.boldFontName, size: 17)
        btn.setTitle(NSLocalizedString("ADD", comment: ""), for: .normal)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        
        self.view.addSubview(btn)
        
      
        NSLayoutConstraint.activate([
            
            btn.topAnchor.constraint(equalTo: self.theTableView.bottomAnchor, constant: 10),
            btn.widthAnchor.constraint(equalTo: self.theTableView.widthAnchor),
            btn.heightAnchor.constraint(equalToConstant: 45),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
       
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
         
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    
        
        
        let _ = self.bkView
        self.theTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        let tableHeight = CGFloat(self.itemArray.keys.count) * self.theTableViewRowHeight
        if tableHeight < self.view.frame.height * 0.6{
            self.theTableViewHeightConstraint?.constant = tableHeight + 10
        }else{
            self.theTableViewHeightConstraint?.constant = self.view.frame.height * 0.6
        }
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer? = nil){
        
        //if sender?.view == self.theTableView{
        //    return
        //}
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addButtonTapped(){
        
        if self.selItemTxt.count==0, self.itemArray.keys.count == 1{
            let coinType = Array(self.itemArray.keys)[0]
            //let token = self.itemArray[coinType] ?? ""
            self.selItemTxt = "\(coinType)"
        }else if self.selItemTxt.count==0{
            self.showMessage(title: "Please select a coin/token to add", message: "")
            return
        }
        
        self.addAccountDelegate?.AddNewAccount(coinType: self.selItemTxt)
    
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
        return
        
        
        
    }
}


extension NewAccountSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.itemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinType = Array(self.itemArray.keys)[indexPath.row]
        //let token = self.itemArray[coinType] ?? ""
        let cellTxt = "\(coinType)"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewAccountCoinTokenTableViewCell", for:indexPath)
        cell.selectionStyle = .default
        cell.textLabel?.text = cellTxt
        cell.textLabel?.textColor = UISetting.shared.titleBKColor
        cell.backgroundColor = .clear
        
        if cellTxt == self.selItemTxt{
            cell.backgroundColor = UISetting.shared.itemSelectColor
        }else{
            cell.backgroundColor = .white
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))

        var indexPathArr = [IndexPath]()
        indexPathArr.append(indexPath)
        if let selIdxPath = self.selIndexPath, indexPath != selIdxPath{
            indexPathArr.append(selIdxPath)
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        if let celltxt = cell?.textLabel?.text, celltxt.compare(self.selItemTxt) != .orderedSame {
            self.selItemTxt = celltxt
            self.selIndexPath = indexPath
        }else{
            self.selItemTxt = ""
            self.selIndexPath = nil
        }
        
        
        self.theTableView.reloadRows(at: indexPathArr, with: .fade)
        
        
        //self.dismiss(animated: true, completion: nil)
        //self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
        
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}


extension NewAccountSelectionViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if touch.view != self.view{
            //print("ignore touch")
            return false
        }
        return true
    }
    
}
