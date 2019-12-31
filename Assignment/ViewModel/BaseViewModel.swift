//
//  BaseViewModel.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation

class BaseViewModel {
    
    
    //setting is allowed only in view model
    private (set) var list : [Response.DataContent]!
    private (set) var savedData : [IshaDataList]?
    private (set) var shouldHideLoader : Bool!
    
    
    // MARK: Output Events
    var reloadTable: () -> () = { }
    var showAlert: () -> () = {}
    var removeLoader : () -> () = {}
    
    init() {
        // getAppData()
    }
    func getAppData() {
        
        //check whether core data has data
        savedData = fetchAllData()
        
        if savedData?.count == 0{
            //calling API and converting the json Data into corresponding class objects......
            self.shouldHideLoader = false
            Webservice.getAllListObjects(callback: { (response, error) in
                if let dataList = response{
                    self.list = dataList.data
                    self.removeLoader()
                    self.saveInDb()
                    self.shouldHideLoader = true
                }else{
                    print(error?.localizedDescription)
                    self.showAlert()
                }
            })
        }
    }
    
    // MARK: Saving
    private func saveInDb(){
        //save in core data
        print("save in core data...")
        DatastoreManager.shared.deleteAllSavedData()
        for item in self.list! {
            let thumbNailURL = item.rt_wp_rest_thumbnail
            let thumbNailData = convertURLIntoData(url: thumbNailURL)
            DatastoreManager.shared.save(title: item.title, excerpt: item.excerpt, thumbNail: thumbNailData)
        }
        savedData = fetchAllData()
        reloadTable()        
    }
    
    // MARK: Fetching
    func fetchAllData() -> [IshaDataList]{
        let savedData = DatastoreManager.shared.fetchAllSavedOptions()
        self.shouldHideLoader = true
        return savedData
    }
    
    // MARK: Converting the image to NSDATA
    func convertURLIntoData(url : URL) -> NSData{
        let thumbNailData = NSData(contentsOf: url)!
        return thumbNailData
    }
    
    
}
