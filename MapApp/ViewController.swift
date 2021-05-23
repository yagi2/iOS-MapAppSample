//
//  ViewController.swift
//  MapApp
//
//  Created by Itsuki Aoyagi on 2021/05/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inputText.delegate = self
    }
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var displayMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        // 入力された文字を取り出す
        if let searchKey = textField.text {
            let geocoder = CLGeocoder()

            //入力された文字から位置情報を取得
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                // 位置情報が存在する場合は取り出す
                if let unwrapPlacemarks = placemarks {
                    // 1件目の情報を取り出す
                    if let firstPlacemark = unwrapPlacemarks.first {
                        // 位置情報を取り出す
                        if let location = firstPlacemark.location {
                            // 位置情報から緯度経度を取り出す
                            let targetCoordinate = location.coordinate
                            
                            // マップにピンを置いていく
                            let pin = MKPointAnnotation()
                            pin.coordinate = targetCoordinate
                            pin.title = searchKey
                            
                            self.displayMap.addAnnotation(pin
                            )
                            
                            // 緯度経度を中心に500mの範囲を表示
                            self.displayMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
            
        }
        return true
    }
    
    @IBAction func changeMapTypeButton(_ sender: Any) {
        // MapTypeをトグル 標準 -> 航空写真 -> 航空写真+標準
        // 3D Flyover -> 3D Flyover+標準 -> 交通機関
        if displayMap.mapType == .standard {
            displayMap.mapType = .satellite
        } else if displayMap.mapType == .satellite {
            displayMap.mapType = .hybrid
        } else if displayMap.mapType == .hybrid {
            displayMap.mapType = .satelliteFlyover
        } else if displayMap.mapType == .satelliteFlyover {
            displayMap.mapType = .hybridFlyover
        } else if displayMap.mapType == .hybridFlyover {
            displayMap.mapType = .mutedStandard
        } else {
            displayMap.mapType = .standard
        }
    }
}

