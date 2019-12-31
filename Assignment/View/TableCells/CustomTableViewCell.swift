//
//  CustomTableViewCell.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(info : [IshaDataList], index : IndexPath){
        self.titleLbl.text = info[index.row].title
        self.imgView.image = UIImage(data: info[index.row].thumbnail! as Data, scale: 1)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
