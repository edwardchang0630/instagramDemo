//
//  ProfileViewController.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/8/29.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 要把登出齒輪放在此頁右上角
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    
    }
    

    
    private func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),style: .done, target: self, action: #selector(didTapSettingButton))
    }
    
    @objc private func didTapSettingButton(){
        let vc = SettingViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
