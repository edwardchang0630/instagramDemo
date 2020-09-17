//
//  ViewController.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/8/29.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//
//import FirebaseAuth
import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     handleNotAuthenticated()
       
        //每次開app都會先sign out the user
//        do{
//            try Auth.auth().signOut()
//        }catch{
//            print("fail to sign out")
//        }
    }
    
    
    
    private func handleNotAuthenticated(){
       //check auth status
        if Auth.auth().currentUser == nil{
            //show Login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: true)
        }
    }
}

