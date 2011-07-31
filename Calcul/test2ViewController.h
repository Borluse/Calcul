//
//  test2ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface test2ViewController : UIViewController {
@private
    double prob;
    double pourcentage;
    double effect;
    
    NSInteger integerPart, demicalPart;
    
    UIPickerView * picker;
    NSArray *pickerArray;
    
    UITextField *resultat;
    UITextField *soitEntre;
    IBOutlet UITextField *niveauConf;
    IBOutlet UITextField *intervalleConf;
    IBOutlet UITextField *taillePop;
    IBOutlet UIBarButtonItem *clearButton;
    
}
@property (nonatomic, retain) IBOutlet UITextField *resultat;
@property (nonatomic, retain) IBOutlet UITextField *soitEntre;


- (IBAction)clearBtnClicked : (id) sender;

@end