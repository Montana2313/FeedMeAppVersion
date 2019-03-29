//
//  feedcell.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 24.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse


class feedcell: UITableViewCell {

    @IBOutlet weak var postuuidlabel: UILabel!
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet weak var commenttext: UITextView!
    @IBOutlet weak var postowner: UILabel!
    @IBOutlet weak var postedimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        postuuidlabel.isHidden = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likebutton(_ sender: Any) {
        
        let sikayet = PFObject(className: "sikayetler")
        sikayet["from"] = PFUser.current()!.username!
       sikayet["to"] = postuuidlabel.text
        sikayet.saveInBackground { (Succes, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert , animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: "Teşekkürler", message: "Şikayetiniz bize ulaşmıştır", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
        }
        
        
        
    }
    @IBAction func commentbutton(_ sender: Any) {
        
   
        
        
        
        
        
    }
    
    
    
    
    
    
}
