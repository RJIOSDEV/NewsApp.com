//
//  NewsListViewModel.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

import Foundation
import UIKit
import CoreData

protocol UpdateTableViewDelegate: NSObjectProtocol {
    func reloadData(sender: NewsListViewModel)
}

class NewsListViewModel : NSObject, NSFetchedResultsControllerDelegate {
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var fetchedResultController: NSFetchedResultsController<NewEntity>?
    
    weak var delegate: UpdateTableViewDelegate?
    
    func retrivedDataFromCoreData(){
        if let context = self.continer?.viewContext{
            let request: NSFetchRequest<NewEntity> = NewEntity.fetchRequest()
            
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(NewEntity.date), ascending: false)]
            
            self.fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil
            )
            
            
            fetchedResultController?.delegate = self
            
            do{
                try self.fetchedResultController?.performFetch()
                
            }catch{
                print("feiled to initialize fetchcontroller\(error)")
            }
            
            
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.delegate?.reloadData(sender: self)
    }
    
    func numberOfRowsInSection (section: Int) -> Int {
        return fetchedResultController?.sections?[section].numberOfObjects ?? 0
    }
    func object (indexPath: IndexPath) -> NewEntity? {
        return fetchedResultController?.object(at: indexPath)
    }
    
}
