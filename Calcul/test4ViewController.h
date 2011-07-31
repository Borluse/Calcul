//
//  test4ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test4ViewController : UIViewController {
    UIBarButtonItem *clearBtn;
    IBOutlet UITextField *seuilText;
    IBOutlet UITextField *moyTextA;
    IBOutlet UITextField *moyTextB;
    IBOutlet UITextField *ecartTypeTextA;
    IBOutlet UITextField *ecartTypeTextB;
    IBOutlet UITextField *effectifTextA;
    IBOutlet UITextField *effectifTextB;

    IBOutlet UILabel *resultLabel;

    UIPickerView * picker;
    NSArray * pickerArray;
    
    double prob;
    double moyA, moyB, ecartA, ecartB, effectA, effectB;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *clearBtn;


- (IBAction)clearBtnClicked:(id)sender;


@end
