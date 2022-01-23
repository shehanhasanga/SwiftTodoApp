//
//  Item.swift
//  Todoey
//
//  Created by shehan karunarathna on 2022-01-23.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct Item :Codable{
    var title:String
    var done:Bool = false
}
