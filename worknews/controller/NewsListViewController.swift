//
//  NewsListViewController.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

import UIKit
import CoreData

class NewsListViewController: UIViewController, UpdateTableViewDelegate {
   
  
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel = NewsListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.tableView.dataSource = self
        self.viewModel.delegate = self
        loadData()
        

        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        viewModel.retrivedDataFromCoreData()
    }
    
    func reloadData(sender: NewsListViewModel) {
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newSelected" {
            guard let detailVc = segue.destination as? NewsDetailViewController else{
                return
            }
            
            guard let selectedNewCell = sender as? UITableViewCell else {return}
            if let indexPath = tableView.indexPath(for: selectedNewCell) {
                let selectedNew = viewModel.object(indexPath: indexPath)
                detailVc.viewModel = NewsDetailViewModel(newDetails: selectedNew)
                
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                
            }
        }
    }

    private func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
    }
    
}
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = viewModel.object(indexPath: indexPath)
        
        if let newCell = cell as? NewsListTableViewCell {
            if let new = object {
                newCell.setCellWithValueOf(new)
            }
        }
        return cell
        
    }
  
    
}
