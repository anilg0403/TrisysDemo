//
//  ContactListPresenter.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation
import UIKit

//MARK:- ContactListPresenter : View -> Presenter
class ContactListPresenter:ViewToPresenterContactListProtocol{
    
    weak var view: PresenterToViewContactListProtocol?
    var interactor: PresenterToInteractorContactListProtocol?
    var router: PresenterToRouterContactListProtocol?
    
    func startFetchingContactList() {
        interactor?.fetchAllContactList()
    }
    
}

//MARK:- ContactListPresenter : Interactor -> Presenter
extension ContactListPresenter : InteractorToPresenterContactListProtocol{
    func contactListFetchSuccess(contactList:[ContactInfo]) {
        view?.onContactListResponseSuccess(responseContactList:contactList)
    }
    
    func contactListFetchFailed(error: String) {
        view?.onContactListResponseFailed(error:error)
    }
    
}
