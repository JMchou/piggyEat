//
//  item.swift
//  PiggyEat
//
//  Created by Jiaming Zhou on 2/13/20.
//  Copyright © 2020 Jiaming Zhou. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: Date?
}
