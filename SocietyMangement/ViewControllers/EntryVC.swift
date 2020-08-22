//
//  EntryVC.swift
//  SocietyGuard
//
//  Created by MacMini on 08/07/1941 Saka.
//  Copyright © 1941 Innovius. All rights reserved.
//

import UIKit


class entrycell: UITableViewCell
{
    
    
    
}
class EntryVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = AppColor.appcolor
        self.navigationController?.navigationBar.barTintColor = AppColor.appcolor
        self.navigationController?.navigationBar.barStyle = UIBarStyle(rawValue: 1)!
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "Forma 1"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setTitle("Entry Detail", for: .normal)
      //  btn2.titleLabel?.font =  UIFont(name: Font_Popins_Medium, size: 20)
        btn2.frame = CGRect(x: -10, y: 0, width: 150, height: 30)
        let item2 = UIBarButtonItem(customView: btn2)
        self.navigationItem.setLeftBarButtonItems([item1,item2], animated: true)
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

   
}

extension EntryVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: entrycell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! entrycell
        
        return cell
    }
    
    
}
