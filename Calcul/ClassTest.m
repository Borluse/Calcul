//
//  ClassTest.m
//  Calcul
//
//  Created by Fan ZHAO on 11-4-6.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "ClassTest.h"


@implementation ClassTest
@synthesize titleOfTest;
@synthesize meaningOfTest;
@synthesize iconOfTest;

-(id) initWithTitle:(NSString *)title andMeaning:(NSString *)meaning andIcon:(UIImage *) icon{
    if ((self == [super init])){
        titleOfTest = title;
        meaningOfTest = meaning;
        iconOfTest = icon;
    }
    return self;
}



@end
