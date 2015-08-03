//
//  BoxAppModel.swift
//  MagicBox
//
//  Created by jianwei on 15/8/3.
//  Copyright (c) 2015年 Jianwei. All rights reserved.
//

import Foundation
class BoxAppModel{
    var name: String!
    var description: String!
    var type: Int!
    var certNum: String!
    var isHot: Bool!
    var isNew: Bool!
    var isHeart: Bool!
    var position: Int!
    var item: String!
    var link: String!
    var image:String? {
        var path = NSBundle.mainBundle().pathForResource(item, ofType: "png")
        return path
    }
    
    init( dic: NSDictionary! ){
        name = dic.objectForKey("Name") as! String
        description = dic.objectForKey("Description") as! String
        type = dic.objectForKey("Type") as! Int
        certNum = dic.objectForKey("CertNum") as! String
        isHot = dic.objectForKey("IsHot") as! Bool
        isNew = dic.objectForKey("IsNew") as! Bool
        isHeart = dic.objectForKey("IsHeart") as! Bool
        position = dic.objectForKey("Position") as! Int
        item = dic.objectForKey("AppItem") as! String
        link = dic.objectForKey("Link") as! String
    }
    
    
}