//
//  MasterViewController.swift
//  CH-Realm
//
//  Created by Hijazi on 10/2/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

import UIKit
import Realm

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil


  var items: RLMResults {
    get {
      let sortProperties = [RLMSortDescriptor(property: "name", ascending:true)]
      return Item.allObjects().sortedResultsUsingDescriptors(sortProperties)
    }
  }
  let realm = RLMRealm.defaultRealm()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Stuff"
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }

  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func insertNewObject(sender: AnyObject) {
    let alert = UIAlertController.init(title: "What it is?", message: "", preferredStyle: .Alert)
    
    let action1 = UIAlertAction.init(title: "Cancel", style: .Cancel) { (UIAlertAction) -> Void in
      
    }
    
    alert.addTextFieldWithConfigurationHandler { (UITextField) -> Void in
      
    }
    
    alert.addAction(action1)
    
    let action2 = UIAlertAction.init(title: "OK", style: .Default) { (UIAlertAction) -> Void in
      
      let tf_name = alert.textFields?.first as UITextField!
      print("hi \(tf_name.text)")
      let realm = RLMRealm.defaultRealm()
      let newItem = Item()
      
      do {
        try realm.transactionWithBlock(){
          realm.addObject(newItem)
          newItem.datePurchased = NSDate()
          newItem.name = tf_name.text!
          newItem.no_id = Int(NSDate.timeIntervalSinceReferenceDate())

        }
        
      } catch {
      }
      
      // REFLECT TO THE UI
      self.tableView.reloadData()

      
    }
    
    alert.addAction(action2)
    
    
    presentViewController(alert, animated: true) { () -> Void in}
    
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
          
          
            let item = items.objectAtIndex(UInt(indexPath.row)) as! Item
          
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.item = item
          
          
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Int(items.count)
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    let index = UInt(indexPath.row)
    let item = items.objectAtIndex(index) as! Item
    
    cell.textLabel!.text = item.name
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      
      // DELETING THE DATABASE
      let index = UInt(indexPath.row)
      let item = items.objectAtIndex(index) as! Item
      let realm = RLMRealm.defaultRealm()
      
      do {
        try realm.transactionWithBlock(){
          realm.deleteObject(item)
          
        }
      } catch{}
      
      // REFLECT TO THE UI
      UIView.animateWithDuration(0.5, animations: { () -> Void in
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }, completion: { (Bool) -> Void in
          tableView.reloadData()
      })
    
    } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }


}

