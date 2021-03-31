//
//  LocalDataCell.swift
//  ClassTest
//
//  Created by Stefan on 2021/3/30.
//

import UIKit

class LocalDataCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateWithModel(model: VGModel) {
        self.textLabel?.text = model.title
        self.accessoryType = model.isFinished ? .checkmark: .none
    }
}
