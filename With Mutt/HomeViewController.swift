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
    @IBOutlet weak var businessTypesHeight: NSLayoutConstraint!
    @IBOutlet weak var businessTypesWidth: NSLayoutConstraint!
    
    var currentSelectedBusinessType: BusinessType = .restaurant ///eventually save this in Defaults
    var businessTypesViewShouldShow = false
    lazy var menu = MenuTableViewController()
    
    @IBAction func menuTapped(_ sender: UIButton) {
    }
    
    @IBAction func selectBusinessType(_ sender: UITapGestureRecognizer) {
        businessTypesViewShouldShow.toggle()
        animateBusinessTypes()
    }
    
    @IBAction func searchBarTapped(_ sender: UITapGestureRecognizer) {
        if businessTypesViewShouldShow {
            businessTypesViewShouldShow = false
            animateBusinessTypes()
            return
        }
        print("present search screen here")
    }
    
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
        
        searchView.layer.cornerRadius = 5
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        businessTypeSelect.layer.cornerRadius = 5
        businessTypeSelect.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        businessTypesContainerView.layer.borderColor = UIColor.lightGray.cgColor
        businessTypesContainerView.layer.borderWidth = 1
    }
    
    func addDogBackgroundImage() {
        view.layer.contents = #imageLiteral(resourceName: "DogBackground").cgImage
        
        //        let layer = CALayer()
        //        let backgroundImage = UIImage(named: "DogBackground")?.cgImage
        //        layer.frame = dogBackground.bounds
        //        layer.contents = backgroundImage
        //        dogBackground.layer.addSublayer(layer)
    }
    
    func setUpTapGesture() {
        let hideContainerTap = UITapGestureRecognizer(target: self, action: #selector(hideBusinessTypeSelection(_:)))
        view.addGestureRecognizer(hideContainerTap)
        self.navigationController?.view.addGestureRecognizer(hideContainerTap)
        hideContainerTap.delegate = self
    }
    
    @objc func hideBusinessTypeSelection(_ sender: UITapGestureRecognizer) {
        businessTypesViewShouldShow = false
        animateBusinessTypes()
    }
    
    func animateBusinessTypes() {
        let shownWidth: CGFloat = 211
        let shownHeight: CGFloat = 232
        if businessTypesViewShouldShow && self.businessTypesWidth.constant == 0.0 && self.businessTypesHeight.constant == 0.0 {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25, options: [.curveEaseIn], animations: {
                self.businessTypesWidth.constant += shownWidth
                self.businessTypesHeight.constant += shownHeight
                self.dogBackground.layoutIfNeeded()
            }, completion: nil)
        } else if !businessTypesViewShouldShow && self.businessTypesWidth.constant != 0.0 && self.businessTypesHeight.constant != 0.0 {
            UIView.animate(withDuration: 0.25) {
                self.businessTypesWidth.constant -= shownWidth
                self.businessTypesHeight.constant -= shownHeight
                self.dogBackground.layoutIfNeeded()

            }
        }
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

