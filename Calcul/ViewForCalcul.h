//
//  ViewForCalcul.h
//  Calcul
//
//  Created by Fan ZHAO on 11-4-7.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTest.h"


@interface ViewForCalcul : UITableViewController {
    ClassTest * test;
}

@property (retain) ClassTest * test;
- (id)initWithStyle:(UITableViewStyle)style withTest:(ClassTest *)atest;
@end
