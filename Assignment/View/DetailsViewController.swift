//
//  DetailsViewController.swift
//  Assignment
//
//  Created by Dheeraj Sontakke on 31/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    
    var detailId : Int!
    
    
    let detailVM = DetailViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up the UI
        setData()
    }
    
    func setData()  {
        detailVM.getDetailForId(detailId: detailId)
        imgView.image = UIImage(data: detailVM.imgData! as Data, scale: 1)
        titleLbl.text = detailVM.title!
        timeLbl.text = detailVM.dateData!
        descLbl.text = detailVM.desc!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
