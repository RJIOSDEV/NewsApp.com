//
//  NewsListTableViewCell.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var newTitle: UILabel!
    
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newOverView: UILabel!
    @IBOutlet weak var newImage: UIImageView!
  
    private var apiService = ApiService()
    private var urlString: String = ""
    
    func setCellWithValueOf(_ new:NewEntity) {
        updateUI(title: new.titles, overView: new.overView, name: new.name, Image: new.image)
    }
    
    private func updateUI(title:String?, overView: String?,name: String?, Image: String?){
        self.newTitle.text = title
        self.newDate.text = name
        self.newOverView.text = overView
        
        guard let backdropString = Image else {return}
        urlString = backdropString
        
        guard let backdropImageUrl = URL(string: urlString) else {
            self.newImage.image = UIImage(named: "no image available")
            return
        }
        
        self.newImage.image = nil

        apiService.getImageDataFrom(url: backdropImageUrl) { [weak self] (data: Data)
            in
            if let image = UIImage(data: data) {
                self?.newImage.image = image
            }else{
                self?.newImage.image = UIImage(named: "no image available")
            }
            
            
            

        }
        viewsAttributes()
    }
    
    private func viewsAttributes() {
        newImage.layer.cornerRadius = 20
        newImage.layer.borderWidth = 0.8
        newImage.contentMode = .scaleAspectFill
        newDate.layer.masksToBounds = true
    }

}
