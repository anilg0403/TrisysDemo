//
//  ContactTableViewCell.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    let parentView = UIView() //Added to addShadow to cell
    var profileImgView = UIImageView.init()
    
    let usernameLbl = UILabel.init()
    let titleLbl = UILabel.init()
    let descriptionLbl = UILabel.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set any attributes of your UI components here.
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 5
        
        profileImgView.translatesAutoresizingMaskIntoConstraints = false
        profileImgView.backgroundColor = .clear
        profileImgView.clipsToBounds = true
        profileImgView.layer.cornerRadius = 30
        profileImgView.contentMode = .scaleAspectFill
        
        usernameLbl.translatesAutoresizingMaskIntoConstraints = false
        usernameLbl.font = UIFont.systemFont(ofSize:16)
        usernameLbl.numberOfLines = 0

        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.font = UIFont.systemFont(ofSize: 13)
        titleLbl.numberOfLines = 0

        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionLbl.font = UIFont.systemFont(ofSize:11)
        descriptionLbl.numberOfLines = 0
        
        // Add the UI components
        contentView.addSubview(parentView)
        parentView.addSubview(profileImgView)
        parentView.addSubview(usernameLbl)
        parentView.addSubview(titleLbl)
        parentView.addSubview(descriptionLbl)

        /* Adding Constraints */
        parentView.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant:8).isActive = true
        parentView.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant:-8).isActive = true
        parentView.topAnchor.constraint(equalTo:contentView.topAnchor, constant:15).isActive = true
        parentView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant:-15).isActive = true

        
        profileImgView.leadingAnchor.constraint(equalTo:parentView.leadingAnchor, constant:10).isActive = true
        profileImgView.widthAnchor.constraint(equalToConstant:60).isActive = true
        profileImgView.heightAnchor.constraint(equalToConstant:60).isActive = true

        
        usernameLbl.leadingAnchor.constraint(equalTo:profileImgView.trailingAnchor, constant:15).isActive = true
        usernameLbl.trailingAnchor.constraint(equalTo:parentView.trailingAnchor, constant:-5).isActive = true
        usernameLbl.topAnchor.constraint(equalTo:parentView.topAnchor, constant:0).isActive = true
        
        titleLbl.leadingAnchor.constraint(equalTo:usernameLbl.leadingAnchor, constant:0).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo:usernameLbl.trailingAnchor, constant:0).isActive = true
        titleLbl.topAnchor.constraint(equalTo:usernameLbl.bottomAnchor, constant:0).isActive = true
        
        descriptionLbl.leadingAnchor.constraint(equalTo:usernameLbl.leadingAnchor, constant:0).isActive = true
        descriptionLbl.trailingAnchor.constraint(equalTo:usernameLbl.trailingAnchor, constant:0).isActive = true
        descriptionLbl.topAnchor.constraint(equalTo:titleLbl.bottomAnchor, constant:6).isActive = true
        descriptionLbl.bottomAnchor.constraint(equalTo:parentView.bottomAnchor, constant:0).isActive = true

        profileImgView.centerYAnchor.constraint(equalTo:parentView.centerYAnchor, constant:0).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
