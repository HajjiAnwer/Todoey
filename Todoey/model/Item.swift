//
//  modelData.swift
//  Todoey
//
//  Created by Mehdi on 15/01/2020.
//  Copyright © 2020 Mehdi. All rights reserved.
//

import Foundation
class Item : Encodable{
    var title : String = ""
    var done : Bool = false
}
