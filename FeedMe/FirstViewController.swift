//
//  FirstViewController.swift
//  FeedMe
//
//  Created by Özgür  Elmaslı on 23.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import MapKit
import Parse


class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    var enlemarray = [String]()
    var boylamarray = [String]()
    var usernamearray = [String]()
    var gelenenlem = ""
    var gelenboylam = ""
    var username = ""
    var enlem = ""
    var usernamearry = [String]()
    
    @IBOutlet weak var mapview: MKMapView!
    var manager = CLLocationManager()
    var secilenenlem = ""
    var secilenboylam = "" // enlem ve boylamı bi şeyde tutmak için
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapview.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest // en iyi yeri göstermesi için
        manager.requestWhenInUseAuthorization()
      
        enlemboylamcek() // enlemboylam çekeceğiz
        
        let gesturerecı = UILongPressGestureRecognizer(target: self, action: #selector(FirstViewController.yerbul(gesturerecognaier:)))
        gesturerecı.minimumPressDuration = 2 // ne kadar basılcanız söyledim
        mapview.addGestureRecognizer(gesturerecı)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // lokasyonlar güncellenince nolacağını yazılır
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        // enlem ve boylamı almak için
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapview.setRegion(region, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.secilenboylam = ""
        self.secilenenlem = ""
        NotificationCenter.default.addObserver(self, selector: #selector(FirstViewController.enlemboylamcek), name: NSNotification.Name(rawValue : "newplaces"), object: nil)
    }
    @objc func enlemboylamcek()
    {
        let query = PFQuery(className: "kayitliyerler")
        query.findObjectsInBackground { (objects, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                self.usernamearray.removeAll(keepingCapacity: false)
                self.enlemarray.removeAll(keepingCapacity: false)
                self.boylamarray.removeAll(keepingCapacity: false)
                for object in objects!
                {
                    self.gelenboylam = "" // genel mantık olarak gelen objeler ilk ekleniyor sonra son obje çekilerek annotaon oluşturuluyor :D 
                    self.gelenenlem = ""
                    self.username = ""
                    self.usernamearray.append(object.object(forKey: "username") as! String)
                    self.enlemarray.append(object.object(forKey: "enlem") as! String)
                    self.boylamarray.append(object.object(forKey: "boylam")as! String)
                    self.gelenenlem = String(self.enlemarray.last!)
                    self.gelenboylam = String(self.boylamarray.last!)
                    self.username = String(self.usernamearray.last!)
                     self.manager.startUpdatingLocation()
                    let location = CLLocationCoordinate2D(latitude: Double(self.gelenenlem)!, longitude: Double(self.gelenboylam)!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.mapview.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.username
                    annotation.subtitle = "Dostlarımıza yardım ediyor :) "
                    self.mapview.addAnnotation(annotation)
                    
                }
            }
            self.mapview.reloadInputViews()
            
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        let reuseID = "pin"
        var pinview = mapview.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if pinview == nil
        {
            pinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinview?.canShowCallout = true // button eklenebilir demek
            let button = UIButton(type: .infoDark)
            pinview?.rightCalloutAccessoryView = button
            
        }
        else
        {
            pinview?.annotation = annotation
        }
        return pinview
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        let query = PFQuery(className: "kayitliyerler")
        query.findObjectsInBackground { (objects, error) in
            if error != nil
            { let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                for object in objects!
                {
                   object.deleteEventually() // geçici olarak böyle kalsın
                }
            }
        }
    }
    
    @objc func yerbul(gesturerecognaier : UIGestureRecognizer) // iğneleme işlemi ve yerini bulma işlemi
    {
        if gesturerecognaier.state == UIGestureRecognizerState.began // koordinatları almak için
        {
             let touches = gesturerecognaier.location(in: mapview)
             let coordinates = self.mapview.convert(touches, toCoordinateFrom: self.mapview)
            let annotation = MKPointAnnotation() // coordinatları belirledik ve bu koordinatlara göre iğneleme yaptık
            annotation.coordinate = coordinates
            annotation.title = PFUser.current()!.username!
            annotation.subtitle = "Dostlarımıza yardım ediyor   :) "
            self.mapview.addAnnotation(annotation)
            self.secilenenlem = String(coordinates.latitude)
            self.secilenboylam = String(coordinates.longitude)
            let object = PFObject(className: "kayitliyerler")
            object["username"] = PFUser.current()!.username!
            object["enlem"] = self.secilenenlem
            object["boylam"] = self.secilenboylam
            object.saveInBackground(block: { (Succes, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Hata", message: "Yükleme Başarısız", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newplaces" ), object: nil) // yeni bir girdi var
                }
            })
            
        }
    }
}

