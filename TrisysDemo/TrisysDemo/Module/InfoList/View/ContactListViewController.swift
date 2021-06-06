//
//  ContactListViewController.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import UIKit
import Kingfisher

//MARK:- ContactListViewController
class ContactListViewController: UIViewController {
    
    //MARK:- Varibale's & IBOutlet
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var contactListPresenter:ViewToPresenterContactListProtocol?
    var contactsList : [ContactInfo] = []


    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact List"
        view.backgroundColor = .white
        self.setUI()
    }
    
    //MARK:- Setup UI
    func setUI() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")

        tableView.separatorStyle = .singleLine
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height:1))
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 1))
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        //self.addFetchingView()
        
        contactListPresenter?.startFetchingContactList()
        
    }
}


//MARK:- PresenterToViewContactListProtocol
extension ContactListViewController : PresenterToViewContactListProtocol{
    
    func onContactListResponseSuccess(responseContactList:[ContactInfo]) {
        //self.removeFetchingView()
        self.contactsList = []
        if responseContactList.count > 0 {
            self.contactsList = responseContactList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func onContactListResponseFailed(error: String) {
        // Need to handle. Show Custom UI to notify No Data
        //self.removeFetchingView()
        
        self.contactsList = []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK:- UITableViewDataSource & UITableViewDelegate
extension ContactListViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        return UITableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
                        
//        if contactsList[indexPath.row].imageUrl != "" {
//            cell.contactImageView.kf.setImage(with: URL(string: contactsList[indexPath.row].imageUrl ?? ""))
//        } else {
//            cell.contactImageView.image = UIImage(named:"") //Add Defualt image
//        }
//        cell.contactImageView.layer.masksToBounds = true
//        cell.contactImageView.layer.cornerRadius = 20

        cell.courseName.text = contactsList[indexPath.row].title ?? ""
        
//        if contactsList[indexPath.row].tagHandle != nil && contactsList[indexPath.row].tagHandle != "" {
//            cell.contactTagLabel.text = contactsList[indexPath.row].tagHandle
//        } else {
//            cell.contactTagLabel.text = ""
//        }
        
        return cell
    }
    
}
