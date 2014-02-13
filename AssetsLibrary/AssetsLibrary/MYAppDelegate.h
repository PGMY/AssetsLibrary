//
//  MYAppDelegate.h
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/10.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYRootViewController;
@interface MYAppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window_;
    MYRootViewController *myRootViewController_;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MYRootViewController *myRootViewController;

@end
