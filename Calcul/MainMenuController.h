//
//  MainMenuController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-4-6.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTest.h"
#import "ViewForCalcul.h"
#import "test1ViewController.h"

@interface MainMenuController : UITableViewController {
    NSMutableArray * tests;
    test1ViewController * test1;
}

@property (retain) NSMutableArray * tests;
@property (retain) test1ViewController * test1;

@end
