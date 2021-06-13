//
//  ViewController.swift
//  TreeTableView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - IBOutlet
    @IBOutlet weak var TreeTable: UITableView!
    
    //MARK: - Variables
    var section_data_array = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TreeTable.register(UINib(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeader")
        for i in 0...3 {
            var tempDict:[String: Any] = ["title": "Role \(i+1)", "open": false]
            let temp_array = NSMutableArray()
            for _ in 0...1 {
                let cell_dict:[String: Any] = ["tile": "Objective 1", "openCell": false]
                temp_array.add(cell_dict)
            }
            
            tempDict.updateValue(temp_array, forKey: "section_content")
            section_data_array.add(tempDict)
        }
        print(section_data_array)
    }

    // MARK: - UITableVIew Delegate Methods
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.TreeTable.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        header.SectionTitle.text = (section_data_array.object(at: section) as? Dictionary ?? [:])["title"] as? String ?? ""
        header.SectionTitle.tag = section
        let tapOnSection = UITapGestureRecognizer(target: self, action: #selector(showCell))
        header.SectionTitle.addGestureRecognizer(tapOnSection)
        
        let temp_dict = NSMutableDictionary(dictionary: section_data_array.object(at: section) as? Dictionary ?? [:])
        if temp_dict.object(forKey: "open") as? Bool ?? false {
            header.SelectionView.isHidden = false
        }
        else {
            header.SelectionView.isHidden = true
        }
        return header
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return section_data_array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section_data_array.object(at: section) as? Dictionary ?? [:])["open"] as? Bool ?? false {
            return 2
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        var treeCell: TableViewCell!
        treeCell = tableView.dequeueReusableCell(withIdentifier: "TreeCell") as?  TableViewCell
        if treeCell == nil
        {
            treeCell = TableViewCell.cellFromNibNamed()
        }
        
        treeCell.TitleLbl.tag = (100*indexPath.section)+indexPath.row
        let tapOnCell = UITapGestureRecognizer(target: self, action: #selector(showSubContent))
        treeCell.TitleLbl.addGestureRecognizer(tapOnCell)
        let section_dict = NSMutableDictionary(dictionary: section_data_array.object(at: indexPath.section) as? Dictionary ?? [:])
        let cell_array = NSMutableArray(array: section_dict.object(forKey: "section_content") as? Array ?? [])
        let cell_dict = NSMutableDictionary(dictionary: cell_array[indexPath.row] as? Dictionary ?? [:])
        treeCell.SubLblOne.text = "Key result 1"
        treeCell.SubLblTwo.text = "Key result 1"
        if cell_dict["openCell"] as? Bool ?? false {
            treeCell.SubStack.isHidden = false
            treeCell.SubViewOne.isHidden = false
            treeCell.SubViewTwo.isHidden = false
        }
        else {
            treeCell.SubStack.isHidden = true
            treeCell.SubViewOne.isHidden = true
            treeCell.SubViewTwo.isHidden = true
        }
        
        return treeCell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UIActions
    @objc func showCell(sender: UITapGestureRecognizer)
     {
        print(section_data_array.object(at: sender.view?.tag ?? 0))
        let temp_dict = NSMutableDictionary(dictionary: section_data_array.object(at: sender.view?.tag ?? 0) as? Dictionary ?? [:])
        if temp_dict.object(forKey: "open") as? Bool ?? false {
            temp_dict.setValue(false, forKey: "open")
        }
        else {
            temp_dict.setValue(true, forKey: "open")
        }
        section_data_array.replaceObject(at: sender.view?.tag ?? 0, with: temp_dict)
        
        TreeTable.reloadSections(NSIndexSet(index: sender.view?.tag ?? 0) as IndexSet, with: .automatic)
     }
    
    @objc func showSubContent(sender: UITapGestureRecognizer)
     {
        let section = (sender.view?.tag ?? 0) / 100
        let row = (sender.view?.tag ?? 0) % 100
        print(section_data_array.object(at: section))
        let section_dict = NSMutableDictionary(dictionary: section_data_array.object(at: section) as? Dictionary ?? [:])
        let cell_array = NSMutableArray(array: (section_dict.object(forKey: "section_content") as? Array ?? []))
        let cell_dict = NSMutableDictionary(dictionary: (section_dict.object(forKey: "section_content") as? Array ?? [])[row] as? Dictionary ?? [:])
        if cell_dict["openCell"] as? Bool ?? false {
            cell_dict.setValue(false, forKey: "openCell")
        }
        else {
            cell_dict.setValue(true, forKey: "openCell")
        }
        cell_array.replaceObject(at: row, with: cell_dict)
        section_dict.setValue(cell_array, forKey: "section_content")
        
        section_data_array.replaceObject(at: section, with: section_dict)
        
        TreeTable.reloadRows(at: [IndexPath.init(row: row, section: section)], with: .automatic)
     }
}

