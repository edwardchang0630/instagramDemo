//
//  RegistrationViewController.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/8/29.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import UIKit

class RegistrationViewController:
UIViewController {
   
    struct Constants {
        static let cornerRadius : CGFloat = 8.0
    }
    
    private let userNameField:UITextField = {
        let field =  UITextField()
        // 尚未輸入時的預設顯示提示文字
        field.placeholder = "Username ..."
        // 鍵盤上的 return 鍵樣式 這邊選擇Next,也可選 Done
        field.returnKeyType = .next
        //textview左邊樣式
        field.leftViewMode = .always
        //將 x 設為 10，輸入之文字將會保持著 10 points 的安全距離。
        field.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 0))
        //加入此行第一個字就不會自動變大寫
        field.autocapitalizationType = .none
        //不會自動幫你訂正輸入的文字
        field.autocorrectionType = .no
        //masksToBounds屬性設置為true，會將超過邊框外的sublayers裁切掉
        field.layer.masksToBounds = true
        //設定圓角
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        return field
        
    }()
    private let emailField:UITextField = {
        let field =  UITextField()
        // 尚未輸入時的預設顯示提示文字
        field.placeholder = "Email Address..."
        // 鍵盤上的 return 鍵樣式 這邊選擇Next,也可選 Done
        field.returnKeyType = .next
        //textview左邊樣式
        field.leftViewMode = .always
        //將 x 設為 10，輸入之文字將會保持著 10 points 的安全距離。
        field.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 0))
        //加入此行第一個字就不會自動變大寫
        field.autocapitalizationType = .none
        //不會自動幫你訂正輸入的文字
        field.autocorrectionType = .no
        //masksToBounds屬性設置為true，會將超過邊框外的sublayers裁切掉
        field.layer.masksToBounds = true
        //設定圓角
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        return field
        
    }()
    private let passwordField:UITextField = {
        let field =  UITextField()
        //安全密碼輸入的設定（＊）
        field.isSecureTextEntry = true
        // 尚未輸入時的預設顯示提示文字
        field.placeholder = "Password"
        // 鍵盤上的 return 鍵樣式
        field.returnKeyType = .continue
        //textview左邊樣式
        field.leftViewMode = .always
        //將 x 設為 10，輸入之文字將會保持著 10 points 的安全距離。
        field.leftView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 0))
        //加入此行第一個字就不會自動變大寫
        field.autocapitalizationType = .none
        //不會自動幫你訂正輸入的文字
        field.autocorrectionType = .no
        //masksToBounds屬性設置為true，會將超過邊框外的sublayers裁切掉
        field.layer.masksToBounds = true
        //設定圓角
        field.layer.cornerRadius = Constants.cornerRadius
        //設定background顏色
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    private let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //addTarget按鈕按下的動作
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        //寫下面三行要去delegate其內容
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        //設定註冊頁面設定註冊頁面背景
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        //用程式把框框加入
        userNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: userNameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+30, width: view.width-40, height: 52)
        
    }
    
    @objc private func didTapRegister(){
        print("didTapRegister")
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8,
            let username = userNameField.text, !username.isEmpty
        else{
                return
        }
        //這邊要帶入AuthManager
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { register in
            DispatchQueue.main.async {
                 if register{
                               //good to go
                    self.dismiss(animated: true, completion:nil)
                               
                           }else{
                               //fail
                           }
            }
           
        }
    }
}


extension RegistrationViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField{
            emailField.becomeFirstResponder()
        }else if textField == emailField{
            passwordField.becomeFirstResponder()
        }else{
           //上面自己寫的func
            didTapRegister()
        }
        return true
    }
}
