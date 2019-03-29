//
//  SecondViewController.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 23.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var postownerarray = [String]()
    var postcommentarray = [String]()
    var posttitlearray = [String]()
    var postuuidarray = [String]()
    var postimagearray = [PFFile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        getdata()
    }
    @objc func getdata()
    {
        let query = PFQuery(className: "posts")
        query.addDescendingOrder("createdAt") // tarihe göre sıralamak için
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.postuuidarray.removeAll(keepingCapacity: true)
                self.postimagearray.removeAll(keepingCapacity: true)
                self.postownerarray.removeAll(keepingCapacity: true)
                self.posttitlearray.removeAll(keepingCapacity: true)
                self.postcommentarray.removeAll(keepingCapacity: true)
                // ---
                for object in objects!
                {
                    self.postownerarray.append(object.object(forKey: "postowner") as! String)
                    self.postcommentarray.append(object.object(forKey: "postcomment") as! String)
                    self.posttitlearray.append(object.object(forKey: "posttitle") as! String)
                    self.postimagearray.append(object.object(forKey: "postimage") as! PFFile)
                    self.postuuidarray.append(object.object(forKey: "postuuid") as! String)
                }
                self.tableview.reloadData()
            }
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.getdata), name: NSNotification.Name(rawValue : "newPost"), object: nil) // yeni upload etmek için 
    }
    @IBAction func logoutbutton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        let girisVC = self.storyboard?.instantiateViewController(withIdentifier: "girisVC") as! girisVC
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = girisVC
        delegate.rememberlogin()
    }
    @IBAction func addbutton(_ sender: Any) {
        performSegue(withIdentifier: "createpost", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postownerarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!feedcell
        cell.postowner.text = postownerarray[indexPath.row]
        cell.commenttext.text = postcommentarray[indexPath.row]
        cell.titletext.text = posttitlearray[indexPath.row]
        cell.postuuidlabel.text = postuuidarray[indexPath.row]
        
        postimagearray[indexPath.row].getDataInBackground { (data, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                cell.postedimage.image = UIImage(data: data!) // image almak için yapıldı 
            }
        }
        
        return cell
    }
    @IBAction func go(_ sender: Any) {
        performSegue(withIdentifier: "cell", sender: nil)
    }
}

