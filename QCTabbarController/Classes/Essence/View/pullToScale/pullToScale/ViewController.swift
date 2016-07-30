//
//  ViewController.swift
//  pullToScale
//
//  Created by 程庆春 on 16/5/7.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headViewHeight: NSLayoutConstraint!
    
    private weak var navigationBarImage: UIImage? = nil
    
    let originOffsetY = -1 * (Constant.headerViewHeight + Constant.selectedViewHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationBarImage = UIImage.imageWithColor(UIColor(white: 0.8, alpha: 0.0))
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.contentInset = UIEdgeInsets(top: Constant.headerViewHeight + Constant.selectedViewHeight, left: 0, bottom: 0, right: 0)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
         /**
         *  set the navigationBar
         */
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)

        self.navigationController?.navigationBar.shadowImage = UIImage()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCellWithIdentifier(CellID.cellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellID.cellID)
        }
        
        cell?.textLabel?.text = "第 \(indexPath.row + 1) 行数据"
        
        return cell!
    }
}

extension ViewController {
    
    // when scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let currentOffsetY = scrollView.contentOffset.y
        
        let delta = currentOffsetY - originOffsetY
        
        self.headViewHeight.constant = Constant.headerViewHeight - delta
        
        if Constant.headerViewHeight + delta < Constant.headerViewMinHeight {
            self.headViewHeight.constant = Constant.headerViewMinHeight
        }
        
//        var ratio = delta / Constant.headerViewHeight - Constant.headerViewMinHeight
//        if ratio >= 1.0 {
//            ratio = 0.99
//        }
        
//        self.navigationBarImage = UIImage.imageWithColor(UIColor(white: 1.0, alpha: ratio))
//        let image: UIImage = UIImage.imageWithColor(UIColor(white: 0.8, alpha: ratio))
//        self.navigationController?.navigationBar.setBackgroundImage(image, forBarMetrics: .Default)
        
    }
}

struct Constant {
    static let headerViewHeight:CGFloat = 200.0;
    static let selectedViewHeight: CGFloat = 44.0;
    static let headerViewMinHeight: CGFloat = 64.0;
}

struct CellID {
    static let cellID: String = "cell"
}
