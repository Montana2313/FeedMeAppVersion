//
//  PostScreen.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 24.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class PostScreen: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var commenttext: UITextView!
    @IBOutlet weak var titletext: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let keyboardreco = UITapGestureRecognizer(target: self, action: #selector(PostScreen.hidekeyboard))
        self.view.addGestureRecognizer(keyboardreco)
        imageview.isUserInteractionEnabled = true
        let gesturerecog = UITapGestureRecognizer(target: self, action:#selector(PostScreen.fotosec))
        imageview.addGestureRecognizer(gesturerecog)
    }
    @IBAction func postbutton(_ sender: Any) {
        let object = PFObject(className: "posts")
        let data = UIImageJPEGRepresentation(imageview.image!, 0.5)
        let pfimage = PFFile(name: "image.jpg", data: data!)
        let uuid = UUID().uuidString
        object["postowner"] = PFUser.current()!.username!
        object["postimage"] = pfimage
        object["posttitle"] = titletext.text
        object["postcomment"] = commenttext.text
        object["postuuid"] = "\(uuid)\(PFUser.current()!.username!)" // her postun bir uuidsi ve adi ile tutulur
        object.saveInBackground { (succes, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Hata", message: "Post işlemi başarısız , lütfen tekrar deneyiniz ", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
               self.commenttext.text = ""
                self.titletext.text = ""
                self.imageview.image = UIImage(named: "dog2.png")
                self.tabBarController?.selectedIndex = 0
                NotificationCenter.default.post(name: NSNotification.Name(rawValue : "newPost"), object: nil)
            }
        }
        
    }
    @objc func fotosec()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    @objc func hidekeyboard()
    {
        self.view.endEditing(true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
