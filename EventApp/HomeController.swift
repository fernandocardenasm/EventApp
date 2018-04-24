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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = .gray
        
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
        homeOptions = SeedData.homeOptions
        
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
        return CGSize(width: (view.frame.width), height: (view.frame.width/6))
    }
    

}

