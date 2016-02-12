//
//  Item.swift
//  CH-Realm
//
//  Created by Hijazi on 13/2/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

import UIKit
import Realm

class Item: RLMObject {
  
  dynamic var no_id = 0
  dynamic var name = ""
  dynamic var datePurchased = NSDate()
  dynamic var price = 0
  
}
