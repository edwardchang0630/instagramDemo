//
//  SettingViewController.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/8/29.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import UIKit
struct SettingCellModel{
    let title: String
    let handler:(()->Void)
}
///View Controller to show user setting
class SettingViewController: UIViewController {

    //建立table View
    private let tableView : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        //TableView進行轉向的動作
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }()
    //a collection of a collection of setting model
   //two dimensional array bcuz we r going to have multiple section
    private var data = [[SettingCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        //要去extention delegate&dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    
//set a frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
        
    }
    
    
    private func configureModels(){
        let section = [
           
            SettingCellModel(title: "Log Out"){[weak self] in self?.didTapLogOut()
                
            }
        ]
        data.append(section)
    }
    private func didTapLogOut(){
        //show the action sheet to user,let user confirm they've already logout
       //呼叫AuthManager的logout
        AuthManager.shared.logout { success in
            DispatchQueue.main.async {
                if success{
                    //跳回登入頁面 present log in
                //這個登入頁面在homeviewcontroller寫過一次去複製即可
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC,animated: true) {
                        self.navigationController?.popToRootViewController(animated: true)
                        self.tabBarController?.selectedIndex = 0 
                    }
                
                }else{
                    //error occurred
            }
                
            }
        }
    }
}


extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
//        cell.textLabel?.text = ""
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //handle cell selection
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
}
