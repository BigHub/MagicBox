//
//  ViewController.swift
//  MagicBox
//
//  Created by jianwei on 15/7/27.
//  Copyright (c) 2015年 Jianwei. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        //测试沙盒
//        testSandBoxOperation()
//        
//        //测试文件写入
//        testSandBoxFileWriteOperation()
//        
//        //测试文件读出
//        testSandBoxFileReadOperation()
        
        loadAllViewController()
        
    }
    
    func loadAllViewController(){
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        var boxPlazaVC = UIStoryboard(name: "BoxPlaza", bundle: nil).instantiateInitialViewController() as! UINavigationController
        var myBoxVC = UIStoryboard(name: "MyBox", bundle: nil).instantiateInitialViewController() as! UINavigationController
        var boxInfoVC = UIStoryboard(name: "BoxInfo", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        //设置根试图控制器在tab bar选项卡上的图标，这里的图标有未选中时和选中时的图标
        boxPlazaVC.tabBarItem.image = UIImage(named: "add_member_highlighted")
        boxPlazaVC.tabBarItem.selectedImage = UIImage(named: "header_del_bn_highlighted")
        //设置显示在tab bar选项卡上的文字
        boxPlazaVC.tabBarItem.title = String("盒子广场")
        
        myBoxVC.tabBarItem.image = UIImage(named: "add_member_highlighted")
        myBoxVC.tabBarItem.selectedImage = UIImage(named: "header_del_bn_highlighted")
        myBoxVC.tabBarItem.title = String("我的盒子")
        
        boxInfoVC.tabBarItem.image = UIImage(named: "header_del_bn_highlighted")
        boxInfoVC.tabBarItem.image = UIImage(named: "add_member_highlighted")
        boxInfoVC.tabBarItem.title = String("关于老码")
        
        //创建一个控制器数组
        var tabBarVCs = [myBoxVC,boxPlazaVC,boxInfoVC]
        
        //给当前的tab bar选项卡增加控制器项目
        self.setViewControllers(tabBarVCs, animated: true)
        
        //选项卡启动时默认选择第一个 这里设置启动时选择第二个
        self.selectedIndex = 1
        
    }
    
    
    //MARK: - 测试文件写入
    func testSandBoxFileWriteOperation(){
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! Array<String>
        var documentPath:String? = paths[0]
        if let docPath = documentPath {
            var filePath = docPath.stringByAppendingPathComponent("MagicBox.txt")
            var contents:NSArray = ["Hello Jobs!", "Hello we!", "Hello Swift!", "Hello OldCoder!"]
            var bRet = contents.writeToFile(filePath, atomically: true)
            if bRet == true {
                NSLog("文件写入成功!")
            }else{
                NSLog("文件写入失败!")
            }
        }else{
            NSLog("当前Document目录不存在!")
        }
    }
    //MARK: - 测试文件读出
    func testSandBoxFileReadOperation(){
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)as! Array<String>
        var documentPath:String? = paths[0]
        var readPath = documentPath!.stringByAppendingPathComponent("MagicBox.txt")
        var fileContent = NSArray(contentsOfFile: readPath)
        NSLog("文件的内容是:%@.",fileContent!)
    }
    
    //MARK: - 测试沙盒的函数
    func testSandBoxOperation(){
        //打印程序的home目录
        var homePath:String = NSHomeDirectory()
        NSLog("MagicBox的home路径是：%@.", homePath)
        
        //MagicBox的安装目录
        NSLog("MagicBox安装程序所在目录：\(NSBundle.mainBundle().bundlePath)")
        
        //打印程序的Document目录
        var paths:Array = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true) as! Array<String>
        var documentPath = paths[0]
        NSLog("MagicBox的Document路径是: %@",documentPath)
        
        //打印程序的Library目录
        paths = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true) as! Array<String>
        var libraryDirectory:String = paths[0]
        NSLog("MagicBox的Library路径是 %@.", libraryDirectory)
        
        //打印程序的Tmp目录
        var tmpDirectory = NSTemporaryDirectory()
        NSLog("MagicBox的Library路径是： %@.", tmpDirectory)
        
        //答应程序的Caches目录
        paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as! Array<String>
        var cachesDirectory = paths[0]
        NSLog("MagicBox的Caches目录是: %@.", cachesDirectory)
        
    }


}

