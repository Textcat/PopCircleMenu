//
//  ViewController.swift
//  PopCircleMenu
//
//  Created by 刘业臻 on 16/7/8.
//  Copyright © 2016年 luiyezheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var popMenuView: PopCirCleMenuView!

    let items: [(icon: String, color: UIColor, text: String)] = [
        ("icon_home", UIColor(red:0.19, green:0.57, blue:1, alpha:1), "home"),
        ("icon_search", UIColor(red:0.22, green:0.74, blue:0, alpha:1), "search"),
        ("notifications-btn", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1), "bell"),
        ("settings-btn", UIColor(red:0.51, green:0.15, blue:1, alpha:1), "setting"),
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1), "nearby"),
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        popMenuView.circleButton?.delegate = self
        //Buttons count
        popMenuView.circleButton?.buttonsCount = 4

        //Distance between buttons and the red circle
        popMenuView.circleButton?.distance = 105

        //Delay between show buttons
        popMenuView.circleButton?.showDelay = 0.03

        //Animation Duration
        popMenuView.circleButton?.duration = 0.8

        guard let button = popMenuView.circleButton else {return}
        button.layer.cornerRadius = button.bounds.size.width / 2.0

    }



    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        //set color
        button.backgroundColor = UIColor.lightGrayColor()
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
        button.layer.borderWidth = 5.0
        button.layer.borderColor = UIColor.whiteColor().CGColor

        // set highlited image
        let highlightedImage  = UIImage(imageLiteral: items[atIndex].icon).imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(highlightedImage, forState: .Highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)

        //set text
        guard let textLabel = button.textLabel else {return}
        textLabel.text = items[atIndex].text

    }

    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }

    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }

}
