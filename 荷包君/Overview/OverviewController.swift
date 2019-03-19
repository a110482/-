//
//  OverviewController.swift
//  荷包君
//
//  Created by elijah tam on 2019/2/8.
//  Copyright © 2019 elijah tam. All rights reserved.
//

import Foundation
import UIKit


class OverviewController: UIViewController{
    @IBOutlet weak var testLable: UILabel!
    
    
    func test(){
        AlterCenter.singleton.push_alert(message: NSLocalizedString("test message", comment: ""))
    }
}
// LiveCycle
extension OverviewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        test()
    }
}


// TableView
extension OverviewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
