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
    
    var refreshControl = UIRefreshControl()

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
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        /* Fetch Data */
        contactListPresenter?.startFetchingContactList()
        
    }
    
    //MARK:- Helper MEthods
    @objc func refresh(_ sender: AnyObject) {
        /* Fetch Data */
        contactListPresenter?.startFetchingContactList()
    }
}


//MARK:- PresenterToViewContactListProtocol
extension ContactListViewController : PresenterToViewContactListProtocol{
    
    func onContactListResponseSuccess(responseContactList:[ContactInfo]) {
        self.contactsList = []
        if responseContactList.count > 0 {
            self.contactsList = responseContactList
        }
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func onContactListResponseFailed(error: String) {
        
        // Need to handle. Show Custom UI to notify No Data
        /* ... */
        
        self.contactsList = []
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
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
        return UITableView.automaticDimension //56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.selectionStyle = .none
        
        /* Here : Kingfisher mamange async loading of image. In live proj we can developed our own logic for image loading */
        if contactsList[indexPath.row].profileImage != "" {
            cell.profileImgView.kf.setImage(with: URL(string: contactsList[indexPath.row].profileImage ?? ""))
        } else {
            cell.profileImgView.image = UIImage(named:"") //Add Defualt image
        }

        cell.usernameLbl.text = contactsList[indexPath.row].userName ?? ""
        cell.titleLbl.text = contactsList[indexPath.row].title ?? ""
        cell.descriptionLbl.text = contactsList[indexPath.row].description ?? ""
        
        return cell
    }
    
}
