//
//  SiteCellTableViewCell.swift
//  Final_Project
//
//  Created by Xcode User on 2020-04-18.
//  Copyright © 2020 Dhruvil Patel. All rights reserved.
//

import UIKit

class SiteCellTableViewCell: UITableViewCell {

    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let descriptionLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 30)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 12)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .blue
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        descriptionLabel.backgroundColor = .clear
        descriptionLabel.textColor = .blue
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(descriptionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 20,y: 11,width: 127,height: 21)
        secondaryLabel.frame = CGRect(x: 20,y: 48,width: 127,height: 21)
        secondaryLabel.frame = CGRect(x: 168,y: 11,width: 226,height: 96)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
