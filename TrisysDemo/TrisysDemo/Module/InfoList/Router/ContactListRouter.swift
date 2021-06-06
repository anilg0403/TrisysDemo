//
//  ContactListRouter.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import UIKit

class ContactListRouter:PresenterToRouterContactListProtocol{
    
    static func createContactListModule() -> ContactListViewController {
        
        let view = ContactListViewController()
        
        let presenter: ViewToPresenterContactListProtocol & InteractorToPresenterContactListProtocol = ContactListPresenter()
        let interactor: PresenterToInteractorContactListProtocol = ContactListInteractor()
        let router:PresenterToRouterContactListProtocol = ContactListRouter()
        
        view.contactListPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
}
