//
//  DatabaseManager.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/9/1.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager{
    //create a func that AuthManager gonna use
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    //add public api
    //Mark: - Public
    
    
    
    //check if username and email is available
    //-Parameters
    //   -email: String represening email
    //   -username: String represening username
    public func canCreateNewUser(with email:String,username:String,completion:(Bool)->Void){
       completion(true)
    }
    
    //insert new user data to database
    //-Parameters
    //   -email: String represening email
    //   -username: String represening username
    // no pw for security reason
    //   -completion:Async callback for result if daatabase entry succeed
    public func insertNewUser(with email: String,username: String,completion:@escaping(Bool)->Void){
        //這邊使用database, 先在上面宣告
       //create a new child ,key will be email
       
        //firebase的database cannnot have period(child裡不能放dot),so create a func to create safe email make this private(write in Extention.swift)
        database.child(email.safeDatabaseKey()).setValue(["username":username]) { error,_ in
            if error == nil{
            //succeed
            completion(true)
            return
        }else{
            //failed
            completion(false)
            return
        }
    }
}
    
 
}
