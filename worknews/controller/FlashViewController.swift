//
//  ViewController.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

import UIKit
import CoreData

class FlashViewController: UIViewController {

    private var apiService = ApiService()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLatestNewsData()
        // Do any additional setup after loading the view.
    }

    private func loadLatestNewsData(){
        apiService.getLatestNewsData { [weak self]
            (result) in
            
            switch result {
            case .success(let listOf):
               
                CoreData.sharedInstance.saveDataOf(news: listOf.news)
                self?.perform(#selector(self?.mainScreen))
                
                //print(result)
       
            case.failure(let error):
                self?.showAlertWith(title: "could not connect!", message: "please check")
                print("Error json: \(error)")
            }
           
        }
    }
  

func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    let action = UIAlertAction(title: "ok", style: .default) { (action) in
        self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(action)
    self.present(alertController, animated: true, completion: nil)
}
    @objc func mainScreen(){
        performSegue(withIdentifier: "newsList", sender: self)
    }
    
}
