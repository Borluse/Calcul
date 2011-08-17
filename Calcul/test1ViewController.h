//
//  test1ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test1ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    double niveauConfNum;
    double intervalleConfNum;
    double taillePopNum;
    
    NSInteger integerPart, demicalPart;
    
    UIPickerView * picker;
    NSArray *pickerArray;
    
    UITextField *resultat;

    IBOutlet UITextField *niveauConf;
    IBOutlet UITextField *intervalleConf;
    IBOutlet UITextField *taillePop;
    IBOutlet UIBarButtonItem *clearButton;
}
@property (nonatomic, retain) IBOutlet UITextField *resultat;

@end
