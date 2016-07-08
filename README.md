# PopCircleMenu
Pinterest like pop circle Menu

<img src="https://github.com/luiyezheng/PopCircleMenu/blob/master/README/adptive.gif" width="280" display="inline" margin-right="50px">
<img src="https://github.com/luiyezheng/PopCircleMenu/blob/master/README/pop.gif" width="280" display="inline">

##Features
* Adaptive direction
* You can add a text above buttons
* Customize the appearance 
* Written in Swift

##Install
```Ruby
use_frameworks!
pod ‘PopCircleMenu’, :git => 'https://github.com/luiyezheng/PopCircleMenu.git'
```

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
###Customization
```Swift
```


