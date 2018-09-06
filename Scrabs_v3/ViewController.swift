//
//  ViewController.swift
//  Scrabs_v3
//
//  Created by Kevin Salcedo on 9/5/18.
//  Copyright © 2018 Kevin Salcedo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loading")
        firstLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // On first load, load in the default word list
    func firstLoad() {
        if let fileURL = Bundle.main.path(forResource: "OTCWL2014", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: fileURL)
                let words = data.components(separatedBy: "\n")
            } catch {
                print ("Unable to Read File")
            }
            
        } else {
            print("No File Found")
        }
    }
    
    func storeDict(name: NSString, content: [NSString]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newList = NSEntityDescription.insertNewObject(
            forEntityName: "WordDict", into: context)
        
        // Set the attribute values
        newList.setValue(name, forKey: "name")
        newList.setValue(content, forKey: "content")
        
        // Commit the changes
        do {
            try context.save()
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func retrieveDicts() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"WordDict")
        var fetchedResults:[NSManagedObject]? = nil
        
        // Examples of filtering using predicates
        // let predicate = NSPredicate(format: "age = 35")
        // let predicate = NSPredicate(format: "name CONTAINS[c] 'ake'")
        // request.predicate = predicate
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // If an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return(fetchedResults)!
    }

}

