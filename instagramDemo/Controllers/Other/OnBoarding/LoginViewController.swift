//
//  LoginViewController.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/8/29.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//
import SafariServices
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    struct Constants {
        //這邊設定好，下面可以直接呼叫
        static let cornerRadius : CGFloat = 8.0
    }
    private let userNameEmailField:UITextField = {
        let field =  UITextField()
        // 尚未輸入時的預設顯示提示文字
        field.placeholder = "Username or Email..."
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
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termButton:UIButton = {
       let button = UIButton()
        button.setTitle("Term of Service", for: .normal)
       // .secondaryLabel在dark mode顏色會自動適應
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton:UIButton = {
        let button = UIButton()
         button.setTitle("Privacy Policy", for: .normal)
        // .secondaryLabel在dark mode顏色會自動適應
         button.setTitleColor(.secondaryLabel, for: .normal)
         return button
    }()
    
    private let createAccountButton:UIButton = {
        let button = UIButton()
        //.label會根據light or dark mode更改顏色
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create a new account", for: .normal)
        return button
    }()
    
    
    private let headerView:UIView = {
        let header = UIView()
        //修剪邊界（連陰影一起修）
        header.clipsToBounds = true
        let backgroundImageVIew = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageVIew)
        return header
    }()
    
    //viewDidLoad 的定義，是它會在 Controller 的視圖被載入記憶體後 被呼叫。簡單來說，即是第一個載入的方法。
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //設置按鈕的點擊事件：button.addTarget(Any?, action: Selector, for: UIControlEvents)
//1、touchDown：單點觸摸按下事件，點觸屏幕
//2、touchDownRepeat：多點觸摸按下事件，點觸計數大於1，按下第2、3或第4根手指的時候
//3、touchDragInside：觸摸在控件內拖動時
//4、touchDragOutside：觸摸在控件外拖動時
//5、touchDragEnter：觸摸從控件之外拖動到內部時
//6、touchDragExit：觸摸從控件內部拖動到外部時
//7、touchUpInside：在控件之內觸摸並擡起事件
//8、touchUpOutside：在控件之外觸摸擡起事件
//9、touchCancel：觸摸取消事件，即一次觸摸因為放上太多手指而被取消，或者電話打斷
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        //添加到視圖中
        addSubviews()
        
        view.backgroundColor = .systemBackground
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frameas
        //y設0.0會超出安全範圍，設成view.safeAreaInsets.top上面會有一個安全範圍
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height/3.0)
        
        userNameEmailField.frame = CGRect(x: 25, y: headerView.bottom+40, width: view.width-50, height: 52.0)
        
        passwordField.frame = CGRect(x: 25, y: userNameEmailField.bottom+10, width: view.width-50, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom+10, width: view.width-50, height: 52.0)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom+10, width: view.width-50, height: 52.0)
        
        termButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50.0)
        privacyButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height: 50.0)
        
        
        configureHeaderView()
        
    }
    
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first  else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //add instagram logo
        let logoImageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: headerView.width/3.0-30, y: view.safeAreaInsets.top, width: headerView.width/2.0, height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubviews(){
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    
    
    @objc private func didTapLoginButton(){
        //隱藏鍵盤
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        guard let usernameEmail = userNameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty,password.count>8 else{
            return
        }
        //login functionality
        var username:String?
        var email:String?
        //此處是判斷是用名稱或是email登入
        if usernameEmail.contains("@"),usernameEmail.contains("."){
            //email
            email = usernameEmail
        }else{
            //username
            username = usernameEmail
        }
        
        
        AuthManager.shared.loginUser(username:
        username, email: email, password: password) { success in
            //有用到ui要拉到主執行緒
            DispatchQueue.main.async {
                if success {
                                //user logged in
                    self.dismiss(animated: true, completion: nil)
                    print("1234567890")
                            }else{
                                //error occured
                                //顯示警示窗
                                let alert = UIAlertController(title: "Log In Error", message: "Wrong Information", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert,animated: true)
                                
                            }
            }
            
        }
    }
    
    @objc private func didTapTermButton(){
        
        guard let url = URL(string: "https://help.instagram.com/478745558852511/?helpref=hc_fnav") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    
    @objc private func didTapCreateAccountButton(){
        //要設一個連接過去註冊的nav controller
        let vc = RegistrationViewController()
        vc.title = "Create an account"
        
        
        present(UINavigationController(rootViewController: vc) ,animated: true)
    }
    
    
    
    
    
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLoginButton()
        }
        return true
    }
}
