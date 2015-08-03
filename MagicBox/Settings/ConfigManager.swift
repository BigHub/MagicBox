//
//  ConfigManager.swift
//  MagicBox
//
//  Created by jianwei on 15/8/3.
//  Copyright (c) 2015年 Jianwei. All rights reserved.
//

import Foundation
public class ConfigManager{
    //生成Configmanager的单例形式
    public class var sharedInstance:ConfigManager{
        struct Static {
            static var instance:ConfigManager?
            static var token:dispatch_once_t = 0
        }
        //实现GCD调用，保证了多线程环境下的安全操作
        dispatch_once(&Static.token){
            Static.instance = ConfigManager()
        }
        return Static.instance!
    }
    
    //在初始化函数中初始化两个本地数组
    init(){
        initBoxAppsDB()
        initMyBoxAppsDB()
    }
    
    //两个数组，一个存放显示在盒子广场的app数据，一个存放显示在我的盒子里的列表数据
    var boxAppsDB:[BoxAppModel] = []
    var myAppsDB:[BoxAppModel] = []
    
    //该函数从本地Setting.plist文件读数据，放到boxAppsDB里面
    func initBoxAppsDB(){
        boxAppsDB.removeAll(keepCapacity:false)
        //获取当前应用根目录下的Setting.plist文件，此处注意NSBundle.mainBundle()的使用，它返回当前安装的app下的跟目录，比如MagicBox.app包下面的根目录
        var settingPath = NSBundle.mainBundle().pathForResource("Setting", ofType: "plist")
        NSLog("~~~~~~~~~~~~setting.plist path:\(settingPath)")
        if settingPath != nil{
            //NSMutableDictionary支持属性文件初始化， 很方便
            var dictResult = NSDictionary(contentsOfFile: settingPath!)
            //获取以app为键的子项目
            var apps:NSArray? = dictResult?.objectForKey("Apps")?.objectForKey("CurrentList") as? NSArray
            if apps != nil{
                for item in apps!{
                    boxAppsDB.append( BoxAppModel(dic: item as! NSDictionary))
                }
            }
        }
    }
    //为了简单，我们认为盒子广场的内容和我的盒子的内容完全一致
    func initMyBoxAppsDB(){
        myAppsDB = boxAppsDB
    }
    
    //返回当前盒子广场有多少个数据,这个将在BoxPlazaViewController中使用
    func getBoxAppAmount()->Int{
        return boxAppsDB.count
    }
    
    //返回指定序号的盒子app的model数据（后面会解释）
    func getBoxAppByIndex(#index: Int) -> BoxAppModel?{
        return boxAppsDB[index]
    }
    
    //返回当前我的盒子有多少个数据，这个将在MyBoxViewController中使用
    func getMyBoxAppAmount()->Int{
        return myAppsDB.count
    }
    
    //返回指定序号的盒子app的model数据（后面会解释）
    func getMyBoxAppByIndex(#index: Int) -> BoxAppModel?{
        return myAppsDB[index]
    }
    
    //如果服务器的配置文件更新，则需要刷新本地的Setting.plist内容，便于更新内容
    func refreshConfigurePlist()->Bool{
        var confPath = NSBundle.mainBundle().pathForResource("Setting", ofType: "plist")
        if confPath == nil{
            NSLog("配置文件Setting.plist的路径为空!")
            return false
        }
        
        var dictionary:NSMutableDictionary! = NSMutableDictionary(contentsOfFile: confPath!) as NSMutableDictionary!
        NSLog("配置文件是: %@", dictionary)
        return true
    }
    
    //解析json数据，放到Setting.plist文件中，目前用Configure.geojson模拟
    public func parserJsonData(path:String)->String{
        //获取当前应用跟目录下的Configure.geojson文件，此处注意NSBundle.mainBundle()的使用，它返回当前安装的app下的根目录，比如MagicBox.app包下的根目录
        var pathFull = NSBundle.mainBundle().pathForResource("Configure", ofType: "geojson")
        var contents = NSString(contentsOfFile: pathFull!, encoding: NSUTF8StringEncoding, error: nil)
        
        var jsonData: NSData = contents?.dataUsingEncoding(NSUTF8StringEncoding) as NSData!
        
        //这个函数很关键,GCJSONKit为NSData扩展了一个名为objectFromJSONData方法实现JSON的解析，并且把解析的内容以NSDictionary的方式返回
        var resultDict:NSDictionary? = jsonData.objectFromJSONData() as? NSDictionary
        //取得setting.plist的路径
        var settingPlist: String? = NSBundle.mainBundle().pathForResource("Setting", ofType: "plist")!
        if settingPlist != nil{
            //写入文件中，注意NSDictionary有一个writeToFile的方法，非常方便
            var ret: Bool = resultDict!.writeToFile(settingPlist!, atomically: true)
            if ret {
                NSLog("JSON数据写入成功，路径为:\(settingPlist)")
            }else{
                NSLog("JSON数据写入Setting.plist失败!")
            }
        }
        
        //用于测试，无意义
        return NSHomeDirectory()
    }
    
}