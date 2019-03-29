//
//  createuserVC.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 24.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class createuserVC: UIViewController {

    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var usernametext: UITextField!
    @IBOutlet weak var emailtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardreco = UITapGestureRecognizer(target: self, action: #selector(createuserVC.hidekeyboard))
        self.view.addGestureRecognizer(keyboardreco)
        // Do any additional setup after loading the view.
    }
    @IBAction func createuserbutton(_ sender: Any) {
        
        if emailtext.text != "" && usernametext.text != "" && passwordtext.text != ""
        {
            let user = PFUser()
            user.email = emailtext.text!
            user.username = usernametext.text!
            user.password = passwordtext.text!
            user.signUpInBackground(block: { (Succes, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: "Kullanıcı Adı kullanımda ", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    UserDefaults.standard.set(self.usernametext.text, forKey: "user")
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
