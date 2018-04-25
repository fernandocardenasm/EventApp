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
    
    enum BackgroundImages: String {
        case road = "road"
    }
    
    var initialFrameCollectionView: CGRect?
    
    var initialCenterYPosCollectionView: CGFloat?
    
    var imageViewBackground: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        assignbackground()
        
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.isScrollEnabled = false
        
        homeOptions = SeedData.homeOptions
        
        setNavigationBar()
        
        //Store initial fram of the view frame
        initialFrameCollectionView = view.frame
        
        setAdjustPosCollectionView()
        
        initialCenterYPosCollectionView = collectionView?.center.y
        
        collectionView?.isUserInteractionEnabled = true
        updateAlphaCollectionView()
        
        addPanGesture(view: view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        collectionView?.frame = initialFrameCollectionView!
        
        coordinator.animate(alongsideTransition: { (_) in

            if UIDevice.current.orientation.isLandscape {
                
                self.setAdjustPosCollectionView()
                self.imageViewBackground?.contentMode = .scaleAspectFill
                
            }
            if UIDevice.current.orientation.isPortrait {

                self.collectionView?.frame = self.initialFrameCollectionView!
                self.setAdjustPosCollectionView()
                self.imageViewBackground?.contentMode = .scaleToFill

                
            }
            
            self.updateAlphaCollectionView()
            
        self.imageViewBackground?.center = self.view.center
        
            
        }, completion: nil)
    }
    
    func assignbackground(){
        
        if let backgroundImage = UIImage(named: BackgroundImages.road.rawValue) {
            
            let background = backgroundImage
            
            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  .scaleToFill
            //        imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            
            imageViewBackground = imageView
            
            view.addSubview(imageViewBackground!)
            view.sendSubview(toBack: imageViewBackground!)
            
        }
        else{
            view.backgroundColor = .gray
        }
        
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    fileprivate func translatePosCollectionView(sender: UIPanGestureRecognizer) {
        
        let optionsCollectionView = collectionView!
        let translation = sender.translation(in: view!)
        
        optionsCollectionView.center = CGPoint(x: optionsCollectionView.center.x, y: optionsCollectionView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func updatePosCollectionView(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view!)
        
        if (self.collectionView?.frame.minY)! + (self.collectionView?.visibleCells.last?.frame.maxY)! < self.view.frame.height {
            
            if translation.y > 0 {
                translatePosCollectionView(sender:sender)
            }
            
        }
        else if (self.collectionView?.frame.minY)! + (self.collectionView?.visibleCells[3].frame.maxY)! > self.view.frame.height {
            
            if translation.y < 0 {
                translatePosCollectionView(sender:sender)
            }
            
        }
        else {
            translatePosCollectionView(sender:sender)
        }
    }
    
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        
        
        switch sender.state {
        case .began, .changed:
            
            UIView.animate(withDuration: 0.3) {
                
                self.updatePosCollectionView(sender: sender)
                self.updateAlphaCollectionView()
                
            }
            
            break
        case .ended:
            break
        default:
            break
        }
        
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
    
    func updateAlphaCollectionView() {
        let alphaValue = (collectionView?.frame.minY)! / view.frame.height
        collectionView?.backgroundColor? = UIColor.rgbWithAlpha(100, green: 100, blue: 100, alpha: 1 - alphaValue)
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

