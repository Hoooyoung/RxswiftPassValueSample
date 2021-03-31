//
//  CacheManage.swift
//  ClassTest
//
//  Created by Stefan on 2021/3/31.
//

import UIKit
import WCDBSwift

class CacheManage: NSObject {
    static let manager = CacheManage()
    var dataBase: Database
    let tableName = "SampleModelTable"
    
    override init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("hysample.db")
        
        dataBase = Database(withFileURL: path!)
        
        do {
            try dataBase.create(table: tableName, of: VGModel.self)
        } catch {
            print("建表失败")
        }
    }
    
    func insertModelToTable(models: VGModel) {
        do {
            try dataBase.insert(objects: models, intoTable: tableName)
        } catch {
            print("添加失败")
        }
    }
    
    func updateModelToTable(model: VGModel) {
        do {
            try dataBase.update(table: tableName, on: VGModel.Properties.isFinished, with: model, where: VGModel.Properties.title == model.title)
        } catch {
            print("更新失败")
        }
    }
    
    func deleteModelToTable(model: VGModel) {
        do {
            try dataBase.delete(fromTable: tableName, where: VGModel.Properties.title == model.title)
        } catch  {
            print("删除失败")
        }
    }
    func fetachModelFromTable() -> [VGModel] {
        var objecte = [VGModel]()
        do {
            try objecte = dataBase.getObjects(fromTable: tableName)
        } catch {
            print("查找数据失败")
        }
        return objecte
    }
}
