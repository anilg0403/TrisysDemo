//
//  ContactListProtocol.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation
import UIKit

//MARK:- View -> Presenter
protocol ViewToPresenterContactListProtocol:class{
    var view: PresenterToViewContactListProtocol? {get set}
    var interactor: PresenterToInteractorContactListProtocol? {get set}
    var router: PresenterToRouterContactListProtocol? {get set}
    func startFetchingContactList()
}

//MARK:- Presenter -> View
protocol PresenterToViewContactListProtocol:class {
    func onContactListResponseSuccess(responseContactList:[ContactInfo])
    func onContactListResponseFailed(error:String)
}

//MARK:- Presenter -> Router
protocol PresenterToRouterContactListProtocol:class {
    static func createContactListModule()->ContactListViewController
}

//MARK:- Presenter -> Interactor
protocol PresenterToInteractorContactListProtocol:class {
    var presenter:InteractorToPresenterContactListProtocol? {get set}
    func fetchAllContactList()
}

//MARK:- Interactor -> Presenter
protocol InteractorToPresenterContactListProtocol:class {
    func contactListFetchSuccess(contactList:[ContactInfo])
    func contactListFetchFailed(error:String)
}
