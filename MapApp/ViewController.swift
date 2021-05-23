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
            print(searchKey)
        }
        
        return true
    }
}

