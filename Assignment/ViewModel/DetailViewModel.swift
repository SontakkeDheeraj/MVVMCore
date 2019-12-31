//
//  DetailViewModel.swift
//  Assignment
//
//  Created by Dheeraj Sontakke on 31/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation
class DetailViewModel {
    var savedData : [IshaDataList]?
    
    private (set) var title : String!
    private (set) var dateData : String!
    private (set) var desc : String!
    private (set) var imgData : NSData!
    
    init() {
       
    }
    
    
    func getDetailForId(detailId : Int)  {
        savedData = fetchAllData()
        print(savedData![detailId])
        title = savedData![detailId].title!
        
        //here date is hardcoded since it is not stored in core data
        
        dateData = "26, Dec 2019 "
        desc = savedData![detailId].excerpt!
        imgData = savedData![detailId].thumbnail!
    }
    
    private func fetchAllData() -> [IshaDataList]{
        let savedData = DatastoreManager.shared.fetchAllSavedOptions()
        return savedData
    }
    
    
    
    
}
