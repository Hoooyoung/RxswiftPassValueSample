//
//  VGModel.swift
//  ClassTest
//
//  Created by Stefan on 2021/3/30.
//

import UIKit
import WCDBSwift

class VGModel: TableCodable {
    var title: String = ""
    var isFinished: Bool = false
    
    init(title: String, isFinished: Bool) {
        self.title = title
        self.isFinished = isFinished
    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = VGModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case title
        case isFinished
    }
}


