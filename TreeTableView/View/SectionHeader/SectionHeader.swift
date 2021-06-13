//
//  SectionHeader.swift
//  TreeTableView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {
    //MARK: - IBOutlet
    @IBOutlet weak var SectionTitle: UILabel!
    @IBOutlet weak var SelectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SelectionView.layer.cornerRadius = SelectionView.frame.width/2
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
