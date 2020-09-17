//
//  Extention.swift
//  instagramDemo
//
//  Created by Yuan-Che Chang on 2020/9/2.
//  Copyright © 2020 Yuan-Che Chang. All rights reserved.
//

import UIKit




extension UIView{
    
    public var width:CGFloat{
        return frame.size.width
    }
    
    
       public var height:CGFloat{
        return frame.size.height
       }
    
       public var top:CGFloat{
        return frame.origin.y
       }
    
       public var bottom:CGFloat{
           return frame.origin.y + frame.size.height
       }
    
       public var left:CGFloat{
           return frame.origin.y
       }
    
    public var right:CGFloat{
        return frame.origin.y + frame.size.width
    }
}


extension String{
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
