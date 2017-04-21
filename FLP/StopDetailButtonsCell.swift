//
//  StopDetailButtonsCell.swift
//  FLP
//
//  Created by Bob De Kort on 4/18/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import Foundation

class StopDetailButtons: BaseCell {
    
    var buttons: ThreeButtonComponent?
    
    override func setupViews() {
        buttons = ThreeButtonComponent(frame: self.frame)
        addSubview(buttons!)
    }
    
    func addGestures(){
        
    }
}
