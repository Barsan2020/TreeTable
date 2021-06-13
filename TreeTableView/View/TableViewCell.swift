//
//  TableViewCell.swift
//  TreeTableView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var TopStack: UIStackView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var SubStack: UIStackView!
    @IBOutlet weak var SubViewOne: UIView!
    @IBOutlet weak var SubLblOne: UILabel!
    @IBOutlet weak var SubViewTwo: UIView!
    @IBOutlet weak var SubLblTwo: UILabel!
    @IBOutlet weak var SubViewThree: UIView!
    @IBOutlet weak var SubLblThree: UILabel!
    @IBOutlet weak var CellSelectionViewOne: UIView!
    @IBOutlet weak var CellSelectionViewTwo: UIView!
    @IBOutlet weak var CellSelectionViewThree: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CellSelectionViewOne.layer.cornerRadius = CellSelectionViewOne.frame.width/2
        CellSelectionViewTwo.layer.cornerRadius = CellSelectionViewTwo.frame.width/2
        CellSelectionViewThree.layer.cornerRadius = CellSelectionViewThree.frame.width/2
    }
    
    class func cellFromNibNamed() -> TableViewCell {
        let bundle = Bundle.main
        let nib = UINib(nibName: "TableViewCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! TableViewCell
        return view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
