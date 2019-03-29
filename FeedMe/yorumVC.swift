//
//  sikayetVC.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 25.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class yorumVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var commenttextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       tableview.delegate = self
        tableview.dataSource = self
    }
    @IBAction func realesebutton(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Comment Cell", for: indexPath)
        return cell
    }
    
    
    
}
