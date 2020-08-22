//
//  ProfessionPopUP.swift
//  SocietyMangement
//
//  Created by MacMini on 29/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

protocol addedOther {
    func addOtherProfession(str:String)
}


class ProfessionPopUP: UIViewController {
    
     var delegate : addedOther?
    var yesAct:(()->())?
    var noAct:(()->())?
    
    
    var professionary = [Profession]()
    var newprofessionary = [Profession]()

    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var txtprofession: UITextField!
    
    
    @IBAction func AddAction(_ sender: Any) {
        if(txtprofession.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter profession")
        self.present(alert, animated: true, completion: nil)
        }
        else
        {
        //yesAct?()
            self.delegate?.addOtherProfession(str: txtprofession.text!)
          removeAnimate()
        }

    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        noAct?()
        removeAnimate()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
       // self.txtprofession.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)

        // ApiCallGetProfession()
        showAnimate()
        // Do any additional setup after loading the view.
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        self.professionary.removeAll()
        if textfield.text?.count != 0 {
            for dicData in self.newprofessionary {
                let isMachingWorker : NSString = (dicData.name) as NSString
                let range = isMachingWorker.lowercased.range(of: textfield.text!, options: NSString.CompareOptions.caseInsensitive, range: nil,   locale: nil)
                if range != nil {
                    professionary.append(dicData)
                    tblview.isHidden = false
                    
                }else
                {
                    
                    tblview.isHidden = true

                }
            }
        } else {
            self.newprofessionary = self.professionary
            tblview.isHidden = false

        }
        self.tblview.reloadData()
    }

    
    func showAnimate()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           });
       }
       
       func removeAnimate()
       {
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
           }, completion:{(finished : Bool)  in
               if (finished)
               {
                   self.dismiss(animated:true, completion: nil)
                   
               }
           });
       }
       
    
    
    
    // MARK: - get Professsion
    
    func ApiCallGetProfession()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "professional") { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                       {
                    
                           self.professionary = resp.data
                        self.newprofessionary = resp.data
                        self.tblview.reloadData()
                           //self.pickerview.reloadAllComponents()
                     
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
         
        
    }
    
    
}

extension ProfessionPopUP: UITableViewDelegate , UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return professionary.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = professionary[indexPath.row].name
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        txtprofession.text = professionary[indexPath.row].name
        
        tblview.isHidden = true
        
    }
  
}

