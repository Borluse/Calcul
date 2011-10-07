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
    double populationNum;
    
    NSInteger integerPart, demicalPart;
    
    UIPickerView * picker;
    NSArray *pickerArray;
    
    UITextField *resultat;
    UITextField *soitEntre;
    IBOutlet UITextField *resultatCorrige;
    
    IBOutlet UITextField *niveauConf;
    IBOutlet UITextField *pourcentageObserve;
    IBOutlet UITextField *effectif;
    IBOutlet UITextField *population;
    
    IBOutlet UIBarButtonItem *clearButton;
}
@property (nonatomic, retain) IBOutlet UITextField *resultat;
@property (nonatomic, retain) IBOutlet UITextField *soitEntre;


- (IBAction)clearBtnClicked : (id) sender;

@end