//
//  HomeViewController.swift
//  With Mutt
//
//  Created by ASM on 6/12/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var dogBackground: UIView!
    @IBOutlet weak var businessSearchStackView: UIStackView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var businessTypeIcon: UIImageView!
    @IBOutlet weak var businessTypesContainerView: UIView!
    @IBOutlet weak var businessTypeSelect: UIView!
    
    var currentSelectedBusinessType: BusinessType = .restaurant ///eventually save this in Defaults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addChildVC()
        setUpTapGesture()
    }
    
    func addChildVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let businessTypeVC = storyboard.instantiateViewController(withIdentifier: "businessSelection") as! BusinessSelectionViewController
        addChild(businessTypeVC)
    }
    
    func setupUI() {
        addDogBackgroundImage()
        dogBackground.bringSubviewToFront(businessSearchStackView)
        dogBackground.bringSubviewToFront(businessTypesContainerView)
        
        searchView.layer.cornerRadius = 10
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        businessTypeSelect.layer.cornerRadius = 10
        businessTypeSelect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func addDogBackgroundImage() {
        let layer = CALayer()
        let backgroundImage = UIImage(named: "adorable-animal-animal-photography-1954515")?.cgImage
        layer.frame = dogBackground.bounds
        layer.contents = backgroundImage
        dogBackground.layer.addSublayer(layer)
    }
    
    func setUpTapGesture() {
        let hideContainerTap = UITapGestureRecognizer(target: self, action: #selector(hideBusinessTypeSelection(_:)))
        view.addGestureRecognizer(hideContainerTap)
        self.navigationController?.view.addGestureRecognizer(hideContainerTap)
        hideContainerTap.delegate = self
    }
    
    @objc func hideBusinessTypeSelection(_ sender: UITapGestureRecognizer) {
        businessTypesContainerView.isHidden = true
    }
    
    @IBAction func selectBusinessType(_ sender: UITapGestureRecognizer) {
        businessTypesContainerView.isHidden.toggle()
    }
    
    @IBAction func searchBarTapped(_ sender: UITapGestureRecognizer) {
        if !businessTypesContainerView.isHidden {
            businessTypesContainerView.isHidden = true
            return
        }
        print("present search screen here")
    }
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: businessTypesContainerView)
        if touchLocation.x < 0.0 || touchLocation.y < 0.0 || touchLocation.x > businessTypesContainerView.frame.width || touchLocation.y > businessTypesContainerView.frame.height {
            return true
        }
        return false
    }
    
}

