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
    
    var initialFrameCollectionView: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .blue
        
        collectionView?.backgroundColor = .gray
        
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
        homeOptions = SeedData.homeOptions
        
        setNavigationBar()
        
        //Store initial fram of the view frame
        initialFrameCollectionView = view.frame
        
        setAdjustPosCollectionView()
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        collectionView?.frame = initialFrameCollectionView!
        
        coordinator.animate(alongsideTransition: { (_) in

            if UIDevice.current.orientation.isLandscape {
                
                self.setAdjustPosCollectionView()
                
            }
            if UIDevice.current.orientation.isPortrait {
                
                self.collectionView?.frame = self.initialFrameCollectionView!
                self.setAdjustPosCollectionView() 
                
            }
            
        }, completion: nil)
    }
    
    func setAdjustPosCollectionView() {
        collectionView?.center.y = 2 * (collectionView?.center.y)!
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
        return CGSize(width: view.frame.width, height: 60.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    

}

