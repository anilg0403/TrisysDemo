//
//  ContactData.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation

struct ContactData :  Codable {
    
    let contactList : [ContactInfo]?
    
    enum CodingKeys: String, CodingKey {
        case contactList = "contacts"
    }

}
