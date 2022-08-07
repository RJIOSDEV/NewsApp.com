//
//  NewsDetailViewModel.swift
//  worknews
//
//  Created by Rajan Desai on 07/08/22.
//

import Foundation
class NewsDetailViewModel {
    
    
    let newDetails: NewEntity?
  
    
    let title: String?
    let name: String?
    let date: String?
    let overView: String?
    let image: String?
    let details: String?
    
    
    init(newDetails: NewEntity?) {
        self.newDetails = newDetails
        
        self.title = newDetails?.titles
        self.name = newDetails?.name
        self.overView = newDetails?.overView
        self.date = NewsDetailViewModel.convertDataFormat(newDetails?.date)
    //    self.date = newDetails?.date
        self.image = newDetails?.image
        self.details = newDetails?.details
    }
    
    private static func convertDataFormat(_ date: String?) -> String {
        var dateOutput = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS'Z'"
        if let dateInput = date {
            if let newDate = dateFormatter.date(from: dateInput) {
                dateFormatter.dateFormat = "dd-MM-yyyy , hh:mm a"
                dateOutput = dateFormatter.string(from: newDate)
            }
        }
        return dateOutput
    }
}
