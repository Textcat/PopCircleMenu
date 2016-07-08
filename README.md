# PopCircleMenu
Pinterest like pop circle Menu

<img src="https://github.com/luiyezheng/PopCircleMenu/blob/master/README/adptive.gif" width="280" display="inline" margin-right="50px">
<img src="https://github.com/luiyezheng/PopCircleMenu/blob/master/README/pop.gif" width="280" display="inline">

##Features
* Adaptive direction
* You can add a text above buttons
* Customize the appearance 
* Written in Swift

##Usage

###Setup
```Swift
popMenuView.circleButton?.delegate = self
//Buttons count
popMenuView.circleButton?.buttonsCount = 4
        
//Distance between buttons and the red circle
popMenuView.circleButton?.distance = 105
        
//Delay between show buttons
popMenuView.circleButton?.showDelay = 0.03
        
//Animation Duration
popMenuView.circleButton?.duration = 0.8
```

###Delegate methods
```Swift
     func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button!!!!! will selected: \(atIndex)")
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        print("button!!!!! did selected: \(atIndex)")
    }
```

###Customization
Take a look at `Example` for more information.


##Install
###Cocoapods
```Ruby
use_frameworks!
pod ‘PopCircleMenu’, :git => 'https://github.com/luiyezheng/PopCircleMenu.git'
```

##Plan
- [ ] Dynamic center button
- [ ] [Frisbee Pop Style](https://www.pinterest.com/pin/43136108910485890/)

##Acknowledgement
Inspired by [circle-menu](https://github.com/fdzsergio/SFFocusViewLayout) and Pinterst

Based on [circle-menu](https://github.com/fdzsergio/SFFocusViewLayout)

##Author
Luiyezheng ,luiyezheng@foxmail.com



