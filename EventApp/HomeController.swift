//
//  ViewController.swift
//  EventApp
//
//  Created by Fernando on 24.04.18.
//  Copyright © 2018 Fernando. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var homeOptions: [HomeOption]?
    
    enum BarButtonItems: String {
        case brief = "brief"
        case info = "info"
        case person = "person"
        case search = "search"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = .gray
        
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
        homeOptions = SeedData.homeOptions
        
        setNavigationBar()
        
    }
    
    func setNavigationBar() {
        let nav = navigationController?.navigationBar
        
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
        setBarButtonItemsLeft()
        setBarButtonItemsRigh()
        
    }
    
    func setBarButtonItemsLeft() {
        if let imageInfo = UIImage(named: BarButtonItems.info.rawValue), let imageBrief = UIImage(named: BarButtonItems.brief.rawValue) {
            
            navigationItem.leftBarButtonItems = [
                UIBarButtonItem(image: imageInfo, style: .plain, target: self, action: nil),
                UIBarButtonItem(image: imageBrief, style: .plain, target: self, action: nil)
            ]
        }
    }
    
    func setBarButtonItemsRigh() {
        if let imagePerson = UIImage(named: BarButtonItems.person.rawValue), let imageSearch = UIImage(named: BarButtonItems.search.rawValue) {
            
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: imagePerson, style: .plain, target: self, action: nil),
                UIBarButtonItem(image: imageSearch, style: .plain, target: self, action: nil)
            ]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = homeOptions?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        
        cell.homeOption = homeOptions?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width), height: 65)
    }
    

}

