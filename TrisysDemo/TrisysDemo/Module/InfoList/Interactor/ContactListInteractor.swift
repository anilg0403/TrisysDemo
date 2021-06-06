//
//  ContactListInteractor.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation
import UIKit

class ContactListInteractor:PresenterToInteractorContactListProtocol{
    
    var presenter: InteractorToPresenterContactListProtocol?
    
   // func fetchAllContactList() {
//        ContantAPIClient().getContacts { (data) in
//            let jsonDecoder = JSONDecoder()
//            let contactsData = try! jsonDecoder.decode(ContactData.self, from: data)
//            self.presenter?.contactListFetchSuccess(contactData:contactsData)
//        }
//    }
     
    
    func fetchAllContactList() {
        
        let urlString = API_REPO_LIST
        
        URLSession.shared.dataTask(with: URL(string:urlString)!) { (data, response, error) in
            if error == nil{
                if let data = data {
                    do{
                        let userResponse = try JSONDecoder().decode([ContactInfo].self, from: data)
                        print("userResponse : \(userResponse)")
                        //self.presenter?.repoListFetchSuccess(repoObjModel:userResponse, currentPageNumber:currentPageNumber)
                    }catch let err{
                        //self.presenter?.repoListFetchFailed(error:err.localizedDescription)
                    }
                }
            }else{
                //self.presenter?.repoListFetchFailed(error:error?.localizedDescription ?? "Something went wrong")
            }
        }.resume()
        
    }
    
}
