//
//  test5ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test5ViewController : UIViewController{
    
    
    IBOutlet UITextField *niveauConfText;
    IBOutlet UITextField *pourAText;
    IBOutlet UITextField *pourBText;
    IBOutlet UITextField *effectAText;
    IBOutlet UITextField *effectBText;
    
    IBOutlet UILabel *resultChi2Label;

    IBOutlet UILabel *resultNorLabel;

    IBOutlet UITextField *chi2Text;    
    IBOutlet UITextField *loiNormalText;

    IBOutlet UIBarButtonItem *clearBtn;

    UIPickerView * picker;
    NSArray * pickerArray;
    
    double prob;
    double pourA, pourB, effetA, effetB;
}

@end
