//
//  CoreData.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

import UIKit
import CoreData

class CoreData {
    static let sharedInstance = CoreData()
    private init (){}
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let fetchRequest = NSFetchRequest<NewEntity>(entityName: "NewEntity")
    
    func saveDataOf(news:[News]){
        self.continer?.performBackgroundTask{ [weak self] (context) in
            
            self?.deleteObjectsFromCoreData(context: context)
            self?.saveDataToCoreData(news: news, context: context)
        }
    }
    
    
    private func deleteObjectsFromCoreData(context: NSManagedObjectContext){
        
        do{
            let objects = try context.fetch(fetchRequest)
            _ = objects.map({context.delete($0)})
            try context.save()
        
        }
        catch{
            print("deleting error\(error)")
        }
    }
    private func saveDataToCoreData(news:[News], context: NSManagedObjectContext){
        context.perform {

            
            //            print("are we on the main queue?   \(String(describing: Thread.isMainThread))")
       
            
            for new in news {
                let newsEntity = NewEntity(context: context)
                newsEntity.titles = new.titles
                newsEntity.date = new.date
                newsEntity.name = new.name
                newsEntity.image = new.Image
                newsEntity.overView = new.overView
                newsEntity.details = new.details
                
            }
            
            do {
                try context.save()
            } catch {
                fatalError("error\(error)")
            }
        }
    }
}
