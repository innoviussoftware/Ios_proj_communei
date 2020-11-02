//
//  ServiceTypeVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 10/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

protocol ServiceTypeListProtocol {
    func serviceTypeList(name:String, selectNumber:Int)
    
    func serviceTypeList1(name:String, selectNumber:Int)

}

class ServiceTypecell:UITableViewCell
{
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgselectmark: UIImageView!

}

class ServiceTypeVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   

    @IBOutlet weak var tblServiceType: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var txtSearchbar: UITextField!

    
    var data = ["Ac Service", "Business Events", "Carpenter", "Caterers", "Civil Work", "Cleaning Services", "Cleaning Services Office", "Computer/Laptop Repair", "Curtains & Blinds", "Driver", "Electrician", "Elevator Services", "Fabrication Service", "Flourmill Repair", "Gardening", "Geyser", "Glass Works", "Home Appliances", "Interior Designer_Office", "Interior Designers", "Lcd/Led Repair", "Maid Services", "Microwaves/Ovens Repair", "Movers & Packers", "Overseas Visa Services", "Painting", "Party & Event Mgmt", "Passport Services", "Pest Control", "Photographers", "Plumber", "Refrigerator Repair", "Ro Services", "Security Services", "Security Services_Office", "Water Cooler"]

    var filteredData: [String]!

    var selectedindex:Int?
    
    var selectedindex1:Int?

    
    var isfrom = ""
    
    var delegate:ServiceTypeListProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        filteredData = data

        tblServiceType.reloadData()
        
        txtSearchbar.layer.borderColor = UIColor.clear.cgColor
        
        txtSearchbar.borderStyle = .none

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- tableview delegate
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell: ServiceTypecell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! ServiceTypecell
        
        cell.lblname.text = filteredData[indexPath.row]

        if(isfrom == "Single") {
            if(selectedindex == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }else if(isfrom == "Multiple") {
            if(selectedindex1 == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }else{
            if(selectedindex == indexPath.row) {
                cell.imgselectmark.image = UIImage(named: "ic_tick_mark")
            }else {
                cell.imgselectmark.image = UIImage(named: "")
            }
        }
                             
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isfrom == "Single") {
            selectedindex = indexPath.row
        
            tblServiceType.reloadData()
        
            delegate?.serviceTypeList(name: filteredData[indexPath.row], selectNumber: selectedindex!)
        }else if(isfrom == "Multiple") {
            selectedindex1 = indexPath.row
        
            tblServiceType.reloadData()
        
            delegate?.serviceTypeList1(name: filteredData[indexPath.row], selectNumber: selectedindex1!)
        }else {
            selectedindex = indexPath.row
        
            tblServiceType.reloadData()
        
            delegate?.serviceTypeList(name: filteredData[indexPath.row], selectNumber: selectedindex!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK:- searchBar delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tblServiceType.reloadData()

    }


}
