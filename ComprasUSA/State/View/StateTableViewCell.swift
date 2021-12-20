//
//  StateTableViewCell.swift
//  ComprasUSA
//
//  Created by Fullbar 3 on 19/12/21.
//

import UIKit


class StateTableViewCell : UITableViewCell {

    @IBOutlet weak var stateNameLabel: UILabel!
    
    @IBOutlet weak var iofNameLabel: UILabel!
    
    func initiazeCell(with state: State) {
        stateNameLabel.text = state.name
        iofNameLabel.text = state.tax
    }
    
    
}
