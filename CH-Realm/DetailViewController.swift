//
//  DetailViewController.swift
//  CH-Realm
//
//  Created by Hijazi on 10/2/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

import UIKit
import Realm

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  var item : Item!

  var detailItem: AnyObject? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.item {

      detailDescriptionLabel.text = self.item.name

    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
    
    let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "edit")
    self.navigationItem.rightBarButtonItem = editButton
    
  }
  
  func edit (){
    let alert = UIAlertController.init(title: "Change the name?", message: "", preferredStyle: .Alert)
    
    let action1 = UIAlertAction.init(title: "Cancel", style: .Cancel) { (UIAlertAction) -> Void in
      
    }
    
    alert.addTextFieldWithConfigurationHandler { (tf_name: UITextField!) -> Void in
      
      tf_name.text = self.item.name
    }
    
    alert.addAction(action1)
    
    let action2 = UIAlertAction.init(title: "OK", style: .Default) { (UIAlertAction) -> Void in
      
      let tf_name = alert.textFields?.first as UITextField!
      print("hi \(tf_name.text)")
      
      //update
      
      let realm = RLMRealm.defaultRealm()
      do {
        try realm.transactionWithBlock(){
          self.item.name = tf_name.text!
        }
      } catch {}
      
      // REFLECT TO THE UI
      self.detailDescriptionLabel.text = self.item.name
      
      
    }
    
    alert.addAction(action2)
    
    
    presentViewController(alert, animated: true) { () -> Void in}
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

