//
//  ViewController.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import UIKit

var vSpinner : UIView?

class ViewController: UIViewController {
    let vM = BaseViewModel()
    var detailId : Int!
    @IBOutlet weak var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up UI
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        vM.showAlert = {[weak self] in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                self!.showSimpleAlert(errorMsg: "The Internet connection appears to be offline")
            }
        }
        if vM.shouldHideLoader == true{
            removeSpinner()
        }
    }
    
    func setup(){
        showSpinner(onView: self.view)
        vM.getAppData()
        vM.reloadTable = {[weak self] in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                _self.listTableView.reloadData()
            }
        }
        vM.removeLoader = {[weak self] in
            guard let _self = self else { return }
            DispatchQueue.main.async {
                _self.removeSpinner()
            }
        }
    }
}

// MARK: Spinner Function
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
// MARK: Tableview Delegates and DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vM.savedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = listTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        // cell.configure(info: )
        cell.configure(info: vM.savedData!,index: indexPath)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailId = indexPath.row
        performSegue(withIdentifier: "Show Detail", sender: nil)
        
    }
}

// MARK: Alert Function
extension ViewController {
    
    func showSimpleAlert(errorMsg : String) {
        let alertController = UIAlertController(title: "Alert", message: errorMsg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
        
    }
}

// MARK: Data Pasing using SEGUE
extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Show Detail") {
            let detailViewController: DetailsViewController = segue.destination as! DetailsViewController
            detailViewController.detailId = self.detailId
        }
    }
}
