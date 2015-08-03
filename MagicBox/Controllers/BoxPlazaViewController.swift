//
//  BoxPlazaViewController.swift
//  MagicBox
//
//  Created by jianwei on 15/7/28.
//  Copyright (c) 2015年 Jianwei. All rights reserved.
//

import UIKit

class BoxPlazaViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    @IBOutlet var collcetionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConfigManager.sharedInstance.getBoxAppAmount()
    }
    
    //MARK: -
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //我们定制了一个UICollectionViewCell类用来管理我们的Cell
        var cell: BoxPlazaCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("plazaBoxItemPrototype", forIndexPath: indexPath) as! BoxPlazaCollectionViewCell
        var apm: BoxAppModel? = ConfigManager.sharedInstance.getBoxAppByIndex(index: indexPath.item)
        
//        cell.adjustCompatient()
//        cell.adjustAttribute(indexPath, boxItem: apm!)
        
        return cell
    }

}
