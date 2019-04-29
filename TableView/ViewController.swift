//
//  ViewController.swift
//  TableView
//
//  Created by Arun Negi on 25/04/2019.
//  Copyright © 2019 arun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageTableView: UITableView!
    var savedIndex:IndexPath = IndexPath(row: 0, section: 0)
    let rows = ["1","2","3","4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imageTableView.dataSource = self
        imageTableView.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension ViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows.count * 1000
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let actualRow = row % rows.count
        return rows[actualRow]
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count * 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.imageTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageTableViewCell
            let actualRow = indexPath.row % rows.count
            cell.cellImageView.image = UIImage(named: rows[actualRow])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TextTableViewCell
        let actualRow = indexPath.row % rows.count
        cell.selectionStyle = .none
        cell.labelText.text = rows[actualRow]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView{
            return 60
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topVisibleIndexPath:IndexPath = self.tableView.indexPathsForVisibleRows![0]
        let actualRow = indexPath.row % rows.count
        if topVisibleIndexPath == indexPath ||  tableView == self.imageTableView {
            print(rows[actualRow])
        }else{
            imageTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//         let topVisibleIndexPath:IndexPath = self.tableView.indexPathsForVisibleRows![0]
//        if savedIndex == topVisibleIndexPath{
//            self.imageTableView.scrollToRow(at: topVisibleIndexPath, at: .top, animated: true)
//        }
    }
   
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let topVisibleIndexPath:IndexPath = self.tableView.indexPathsForVisibleRows![0]
        tableView.scrollToRow(at: topVisibleIndexPath, at: .top, animated: true)
        imageTableView.scrollToRow(at: topVisibleIndexPath, at: .top, animated: true)

    }
    
    
}


