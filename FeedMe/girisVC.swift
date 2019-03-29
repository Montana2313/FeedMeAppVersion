//
//  girisVC.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 24.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class girisVC: UIViewController {

    @IBOutlet weak var usernametxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardreco = UITapGestureRecognizer(target: self, action: #selector(girisVC.hidekeyboard))
        self.view.addGestureRecognizer(keyboardreco)
        // Do any additional setup after loading the view.
    }
    @IBAction func kayitolbutton(_ sender: Any) {
        performSegue(withIdentifier: "tocreate", sender: nil)
    }
    @IBAction func goinbutton(_ sender: Any) {
        if usernametxt.text != "" && passwordtxt.text != ""
        {
            PFUser.logInWithUsername(inBackground: usernametxt.text!, password: passwordtxt.text!, block: { (User, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: "Kullanıcı Adınız veya Şifreniz Yanlış", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    UserDefaults.standard.set(self.usernametxt.text, forKey: "user")
                    UserDefaults.standard.synchronize()
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                }
            })
           
        }
        else
        {
            let alert = UIAlertController(title: "Hata", message: "Boş Alan Bırakmayınız", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func hidekeyboard()
    {
        self.view.endEditing(true)
        
    }
    
}
