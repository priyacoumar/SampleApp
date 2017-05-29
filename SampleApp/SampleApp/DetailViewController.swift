//
//  DetailViewController.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/23/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var ClickMe: UIButton!
    @IBOutlet weak var pickerInfo: UIPickerView!

    var listDataModel : AccessTokenModel! // = ["AAA", "BBBB", "CCC"]
    
    var AccessTokenModelDatafromService : AccessTokenModel!
    
    var listData = [String]()


    func configureView() {
        
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.timestamp!.description
                
            }
        }
        
        let onSuccess = {(_ responseObj: AccessTokenModel) -> Void in
           print("Success")
            self.detailDescriptionLabel.text = responseObj.access_token
            self.AccessTokenModelDatafromService = responseObj
            self.setDataForPicker(accessTokenModelData: self.AccessTokenModelDatafromService)
           
        }
        let onFailure = {(statusError: ErrorModel) -> Void in
            print("Failure")
        }
        
    //HelperClass.CallWebservice_noInput(onSuccess: onSuccess, onFailure: onFailure)
        HelperClass.CallWebservice(txt: "CallWebservice",onSuccess: onSuccess, onFailure: onFailure )
       // SimpleNetwork.makeGetCall()
    
        
    }
    
    
    @IBAction func clickMefn()
    {
    
        let alert = UIAlertController(title: detailDescriptionLabel.text, message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        pickerInfo.dataSource = self
        pickerInfo.delegate = self
      
        self.configureView()
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listData[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // ClickMe.value(forKey: type[row])
        detailDescriptionLabel.text = listData[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func setDataForPicker(accessTokenModelData: AccessTokenModel){
        
        listData.removeAll()
        listDataModel = accessTokenModelData
        
        let tokenInfo: NSDictionary = listDataModel.accessTokenDict
        
        for (k, v) in tokenInfo {
            listData.append("\(k) \(v)")
        }
       pickerInfo.reloadAllComponents()
        
    }

}

