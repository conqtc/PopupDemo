//
//  MenuTableViewController.swift
//  PopupDemo
//
//  Created by Alex Truong on 4/13/17.
//  Copyright © 2017 Alex Truong. All rights reserved.
//

import UIKit

protocol MenuTableDelegate: class {
    func menuTable(sender: UIViewController, didSelectWithObject object: AnyObject?)
}

class MenuTableViewController: UITableViewController {
    
    let colors = [
        UIColor.gray,
        UIColor.brown,
        UIColor.magenta,
        UIColor.orange,
        UIColor.purple,
        UIColor.blue,
        UIColor.green,
        UIColor.yellow,
        UIColor.cyan,
        UIColor(red:0.67, green:0.91, blue:0.86, alpha:1.00),
        UIColor(red:0.72, green:0.86, blue:0.95, alpha:1.00),
        UIColor(red:0.97, green:0.76, blue:0.73, alpha:1.00),
        UIColor(red:0.96, green:0.82, blue:0.68, alpha:1.00),
        UIColor(red:0.98, green:0.92, blue:0.65, alpha:1.00),
        ]

    var delegate: MenuTableDelegate?
    
    var sectionView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorCell")

        sectionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        sectionView.clipsToBounds = true
        sectionView.image = UIImage(named: "Banner")
        sectionView.contentMode = .scaleAspectFill
        
        tableView.bounces = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.menuTable(sender: self, didSelectWithObject: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "c"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath)
        
        // Configure the cell...
        if let cell = cell as? ColorTableViewCell {
            cell.iconView.backgroundColor = colors[indexPath.row]
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true)
    }
    
}
