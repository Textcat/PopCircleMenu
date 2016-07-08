//
//  CircleMenu1.swift
//  PopCircleMenu
//
//  Created by 刘业臻 on 16/7/8.
//  Copyright © 2016年 luiyezheng. All rights reserved.
//


import UIKit

// MARK: helpers

@warn_unused_result
func Init<Type>(value: Type, @noescape block: (object: Type) -> Void) -> Type {
    block(object: value)
    return value
}

// MARK: Protocol

/**
 *  CircleMenuDelegate
 */
@objc public protocol CircleMenuDelegate {

    /**
     Tells the delegate the circle menu is about to draw a button for a particular index.

     - parameter circleMenu: The circle menu object informing the delegate of this impending event.
     - parameter button:     A circle menu button object that circle menu is going to use when drawing the row. Don't change button.tag
     - parameter atIndex:    An button index.
     */
    optional func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int)

    /**
     Tells the delegate that a specified index is about to be selected.

     - parameter circleMenu: A circle menu object informing the delegate about the impending selection.
     - parameter button:     A selected circle menu button. Don't change button.tag
     - parameter atIndex:    Selected button index
     */
    optional func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int)

    /**
     Tells the delegate that the specified index is now selected.

     - parameter circleMenu: A circle menu object informing the delegate about the new index selection.
     - parameter button:     A selected circle menu button. Don't change button.tag
     - parameter atIndex:    Selected button index
     */
    optional func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int)
}

// MARK: CircleMenu

/// A Button object with pop ups buttons
public class CircleMenu: UIButton {

    // MARK: properties

    /// Buttons count
    public var buttonsCount: Int = 3
    /// Circle animation duration
    public var duration: Double  = 2
    /// Distance between center button and buttons
    public var distance: Float   = 100
    /// Delay between show buttons
    public var showDelay: Double = 0.0
    /// Highlighted border Color
    public var highlightedBorderColor: UIColor = UIColor.color(255, green: 22, blue: 93, alpha: 1.0)
    /// Normal border Color
    public var normalBorderColor: UIColor = UIColor.whiteColor()

    /// The object that acts as the delegate of the circle menu.
    @IBOutlet weak public var delegate: AnyObject? //CircleMenuDelegate?

    var buttons: [CircleMenuButton]?

    // MARK: life cycle

    /**
     Initializes and returns a circle menu object.

     - parameter frame:        A rectangle specifying the initial location and size of the circle menu in its superview’s coordinates.
     - parameter normalIcon:   The image to use for the specified normal state.
     - parameter selectedIcon: The image to use for the specified selected state.
     - parameter buttonsCount: The number of buttons.
     - parameter duration:     The duration, in seconds, of the animation.
     - parameter distance:     Distance between center button and sub buttons.

     - returns: A newly created circle menu.
     */
    public init(frame: CGRect, buttonsCount: Int = 3, duration: Double = 2,
                distance: Float = 100) {
        super.init(frame: frame)

        self.buttonsCount = buttonsCount
        self.duration     = duration
        self.distance     = distance

        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = true
        layer.borderColor = highlightedBorderColor.colorWithAlphaComponent(0.5).CGColor

        setImage(UIImage(), forState: .Normal)
        setImage(UIImage(), forState: .Selected)
    }

    // MARK: methods

    /**
     Hide button

     - parameter duration:  The duration, in seconds, of the animation.
     - parameter hideDelay: The time to delay, in seconds.
     */
    public func hideButtons(duration: Double, hideDelay: Double = 0) {
        if buttons == nil {
            return
        }

        buttonsAnimationIsShow(isShow: false, duration: duration, hideDelay: hideDelay)

        tapBounceAnimation()
        tapRotatedAnimation(0.3, isSelected: false)
    }

    /**
     Check is sub buttons showed
     */
    public func buttonsIsShown() -> Bool {
        guard let buttons = self.buttons else {
            return false
        }

        for button in buttons {
            if button.alpha == 0 {
                return false
            }
        }
        return true
    }

    // MARK: create

    private func createButtons() -> [CircleMenuButton] {
        var buttons = [CircleMenuButton]()

        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {

            let angle: Float = (Float(index) * step) / 2.5
            let distance = Float(self.bounds.size.height/2.0)
            let size = CGSize(width: self.bounds.width, height: self.bounds.height)
            let button = Init(CircleMenuButton(size: size, circleMenu: self, distance:distance, angle: angle, index: index)) {
                $0.tag = index
                $0.addTarget(self, action: #selector(CircleMenu.buttonHandler(_:)), forControlEvents: UIControlEvents.TouchDragExit)
                $0.alpha = 0
            }
            buttons.append(button)
        }
        return buttons
    }

    // MARK: configure

    // MARK: actions

    func onTap() {
        if buttonsIsShown() == false {
            buttons = createButtons()
        }
        let isShow = !buttonsIsShown()

        let duration  = isShow ? self.duration : min(0.2, self.duration)
        buttonsAnimationIsShow(isShow: isShow, duration: duration)

        tapBounceAnimation()
        tapRotatedAnimation(Float(duration), isSelected: isShow)
    }

    internal func buttonHandler(sender: UIButton) {
        guard case let sender as CircleMenuButton = sender else {
            return
        }

        delegate?.circleMenu?(self, buttonWillSelected: sender, atIndex: sender.tag)


        if let container = sender.container { // rotation animation
            container.superview?.bringSubviewToFront(container)
        }

        if let _ = buttons {
            hideCenterButton(duration: min(duration, 0.2))

            buttonsAnimationIsShow(isShow: false, duration: min(duration, 0.2), hideDelay: 0.0)
        }

        let dispatchTime: dispatch_time_t = dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(min(duration, 0.2) * Double(NSEC_PER_SEC)))

        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.delegate?.circleMenu?(self, buttonDidSelected: sender, atIndex: sender.tag)
        })
    }

    // MARK: animations
    private func buttonsAnimationIsShow(isShow isShow: Bool, duration: Double, hideDelay: Double = 0) {
        guard let buttons = self.buttons else {
            return
        }

        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            let button = buttons[index]
            let angle: Float = Float(index) * step
            if isShow == true {
                delegate?.circleMenu?(self, willDisplay: button, atIndex: index)

                button.rotatedZ(angle: angle, animated: false, delay: Double(index) * showDelay, distance: distance)
                button.showAnimation(distance: distance, duration: duration, delay: Double(index) * showDelay)
            } else {
                button.hideAnimation(
                    distance: Float(self.bounds.size.height / 2.0),
                    duration: duration, delay: hideDelay)
            }
        }
        if isShow == false { // hide buttons and remove

            self.buttons = nil
        }
    }

    private func tapBounceAnimation() {
        self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5,
                                   options: UIViewAnimationOptions.CurveLinear,
                                   animations: { () -> Void in
                                    self.transform = CGAffineTransformMakeScale(1, 1)
            },
                                   completion: nil)
    }

    private func tapRotatedAnimation(duration: Float, isSelected: Bool) {

        selected = isSelected
        self.alpha = 1.0
    }

    internal func hideCenterButton(duration duration: Double, delay: Double = 0) {
        UIView.animateWithDuration( NSTimeInterval(duration), delay: NSTimeInterval(delay),
                                    options: UIViewAnimationOptions.CurveEaseOut,
                                    animations: { () -> Void in
                                        self.transform = CGAffineTransformMakeScale(0.001, 0.001)
            }, completion: nil)
    }
}
