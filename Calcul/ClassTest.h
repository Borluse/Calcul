//
//  ClassTest.h
//  Calcul
//
//  Created by Fan ZHAO on 11-4-6.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClassTest : NSObject {
    NSString * titleOfTest;
    NSString * meaningOfTest;
    UIImage * iconOfTest;
}

@property (retain) NSString * titleOfTest;
@property (retain) NSString * meaningOfTest;
@property (retain) UIImage * iconOfTest;

-(id) initWithTitle:(NSString *)title andMeaning:(NSString *)meaning andIcon:(UIImage *) icon;


@end
