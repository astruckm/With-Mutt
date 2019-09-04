//
//  HomeViewController.swift
//  With Mutt
//
//  Created by ASM on 6/12/19.
//  Copyright © 2019 ASM. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, CurrentBusinessTypeDelegate {
    @IBOutlet weak var dogBackground: UIView!
    @IBOutlet weak var businessSearchStackView: UIStackView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var businessTypeIcon: UIImageView!
    @IBOutlet weak var businessTypesContainerView: UIView!
    @IBOutlet weak var businessTypeSelect: UIView!
    @IBOutlet weak var businessTypesHeight: NSLayoutConstraint!
    @IBOutlet weak var businessTypesWidth: NSLayoutConstraint!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let businessTypesContainerViewShownWidth: CGFloat =
        UIScreen.main.bounds.width * CGFloat(211.0/414.0)
    let businessTypesContainerViewShownHeight: CGFloat = UIScreen.main.bounds.height * CGFloat(232.0/896.0)
    let menuWidthConstant: CGFloat = UIScreen.main.bounds.width * 0.6
    var currentSelectedBusinessType: BusinessType = .restaurant ///eventually save this in Defaults
    var businessTypesViewShouldShow = false
    var menuShouldDisplay = false
    
    @IBAction func menuTapped(_ sender: UIButton) {
        menuShouldDisplay.toggle()
        animateMenuDisplay()
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
        if !menuShouldDisplay {
            let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchVC")
            UIView.animate(withDuration: 0.5, animations: {
                //Move search stack view up
            }) { [unowned self] (bool) in
                self.present(searchVC, animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addChildVCs()
        setUpTapGesture()
        
        appDelegate?.locationService.locationManager.requestWhenInUseAuthorization()
    }
    
    private func addChildVCs() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let businessTypeVC = storyboard.instantiateViewController(withIdentifier: "businessSelection") as! BusinessSelectionViewController
        businessTypeVC.businessTypeDelegate = self
        let menuVC = storyboard.instantiateViewController(withIdentifier: "menuTableVC")
        addChild(businessTypeVC)
        addChild(menuVC)
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
        if businessTypesViewShouldShow && self.businessTypesWidth.constant == 0.0 && self.businessTypesHeight.constant == 0.0 {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25, options: [.curveEaseOut], animations: {
                self.businessTypesWidth.constant += self.businessTypesContainerViewShownWidth
                self.businessTypesHeight.constant += self.businessTypesContainerViewShownHeight
                self.dogBackground.layoutIfNeeded()
            }, completion: nil)
        } else if !businessTypesViewShouldShow && self.businessTypesWidth.constant != 0.0 && self.businessTypesHeight.constant != 0.0 {
            UIView.animate(withDuration: 0.2) {
                self.businessTypesWidth.constant -= self.businessTypesContainerViewShownWidth
                self.businessTypesHeight.constant -= self.businessTypesContainerViewShownHeight
                self.dogBackground.layoutIfNeeded()

            }
        }
    }
    
    func animateMenuDisplay() {
        if menuShouldDisplay {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25, options: [.curveEaseOut], animations: {
                self.menuWidth.constant += self.menuWidthConstant
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.25) {
                self.menuWidth.constant -= self.menuWidthConstant
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func segueToSearchVC() {
        let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "searchVC") as! SearchViewController
        present(searchVC, animated: false, completion: nil)
    }
    
}

extension HomeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard !isTouchWithinMenu(touch) else { return false }
        
        //where menu is up and touch is within background view
        if menuShouldDisplay && touch.location(in: dogBackground).y > 0.0 {
            menuShouldDisplay = false
            animateMenuDisplay()
            return true
        }
        
        //where touch is outside bounds of businessTypesContainerView
        let touchLocationBT = touch.location(in: businessTypesContainerView)
        if touchLocationBT.x < 0.0 || touchLocationBT.y < 0.0 || touchLocationBT.x > businessTypesContainerView.frame.width || touchLocationBT.y > businessTypesContainerView.frame.height {
            return true
        }
        
        //where touch is within search view and no menus/popups are up
        if !menuShouldDisplay && !businessTypesViewShouldShow && isTouchWithinSearchView(touch) {
            segueToSearchVC()
            return true
        }
        
        return false
    }
    
    private func isTouchWithinMenu(_ touch: UITouch) -> Bool {
        let touchLocation = touch.location(in: view)
        return menuShouldDisplay && touchLocation.x <= menuContainerView.frame.width
    }
    
    private func isTouchWithinSearchView(_ touch: UITouch) -> Bool {
        let touchLocationSV = touch.location(in: searchView)
        return touchLocationSV.x >= 0.0 && touchLocationSV.y >= 0.0 && touchLocationSV.x <= searchView.frame.width && touchLocationSV.y <= searchView.frame.height
    }
}

