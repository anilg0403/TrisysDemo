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
    
    func fetchAllContactList() {
        
        let urlString = API_REPO_LIST
        
        URLSession.shared.dataTask(with: URL(string:urlString)!) { (data, response, error) in
            if error == nil{
                if let data = data {
                    do{
                        let userResponse = try JSONDecoder().decode([ContactInfo].self, from: data)
                        self.presenter?.contactListFetchSuccess(contactList:userResponse)
                    }catch let err{
                        self.presenter?.contactListFetchFailed(error:err.localizedDescription)
                    }
                }
            }else{
                self.presenter?.contactListFetchFailed(error:error?.localizedDescription ?? "Something went wrong")
            }
        }.resume()
        
    }
    
}
