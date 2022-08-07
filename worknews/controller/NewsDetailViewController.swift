//
//  NewsDetailViewController.swift
//  worknews
//
//  Created by Rajan Desai on 07/08/22.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var newDate: UILabel!
    
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newOverView: UILabel!
    @IBOutlet weak var newName: UILabel!
    @IBOutlet weak var newImage: UIImageView!
  
    var viewModel: NewsDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        updateUI()
        // Do any additional setup after loading the view.
    }
    private func updateUI(){
        self.newTitle.text = viewModel.title
        self.newDate.text = viewModel.date
        self.newOverView.text = viewModel.details
        self.newImage.setImageFromPath(viewModel.image)
        self.newName.text = viewModel.name
    viewsAttributes()
    
    }
    
    private func viewsAttributes() {
    
    }

    

}
extension UIImageView {
    func setImageFromPath(_ path: String?){
        image = nil
        DispatchQueue.global(qos: .background).async {
            var image: UIImage?
            guard let imagePath = path else {return}
            if let imageURL = URL(string: imagePath) {
                if let imageData = NSData(contentsOf: imageURL) {
                    image = UIImage(data: imageData as Data)
                
                }else{
                    image = UIImage(named: "non image available")
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
