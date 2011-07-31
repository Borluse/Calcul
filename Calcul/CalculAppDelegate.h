//
//  CalculAppDelegate.h
//  Calcul
//
//  Created by Fan ZHAO on 11-4-6.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuController.h"
#import "test1ViewController.h"
#import "test2ViewController.h"
#import "test3ViewController.h"
#import "test4ViewController.h"
#import "test5ViewController.h"

@interface CalculAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController * tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
