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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        addDogBackgroundImage()
        dogBackground.bringSubviewToFront(businessSearchStackView)
    }
    
    func addDogBackgroundImage() {
        let layer = CALayer()
        let backgroundImage = UIImage(named: "adorable-animal-animal-photography-1954515")?.cgImage
        layer.frame = dogBackground.bounds
        layer.contents = backgroundImage
        dogBackground.layer.addSublayer(layer)
    }
    
    @IBAction func selectBusinessType(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "businessSelection")
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    


}

