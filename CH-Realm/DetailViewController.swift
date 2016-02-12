//
//  DetailViewController.swift
//  CH-Realm
//
//  Created by Hijazi on 10/2/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

import UIKit
import RealmSwift

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
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

