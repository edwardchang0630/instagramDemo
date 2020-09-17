//
//  AuthManager.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/9/2.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import  FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    //add public api
    //Mark: - Public
    public func registerNewUser(username:String,email:String,password:String,completion: @escaping (Bool) -> Void){
        print("registerNewUser")
        /*
         -check if username is available
         -check if email is available
         -create an account
         -insert account to database
         */
        
        //先去firebase的 database建立資料庫
        //開完打開databaseManger建立一func
        /*
        -check if username is available
        -check if email is available
        */

        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
           print(canCreate)
            if canCreate{
                
                /*
                -create an account
                -insert account to database
                */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    print(result,error)
                    guard result != nil else{
                       //firebase cannot ccreate an account
                        completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted{
                            completion(true)
                            return
                        }else{
                            //fail to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }//cannot create account
            else{
                //either username or email does not exist
                completion(false)
            }
        }
    }
    public func loginUser(username:String?,email:String?,password:String,completion :@escaping(Bool) -> Void){
        if let email = email{
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil,error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
        }else if let username = username{
             //username log in
            print(username)
        }
    }
    
    
    ///Attempt to log out firebase user
    //使用firebase sign out 會被丟出例外,用 do catch接
    public func logout(completion:(Bool)->Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
