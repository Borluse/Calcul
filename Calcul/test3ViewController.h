//
//  test1ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "normsinv.h"
@interface test3ViewController : UIViewController<UIPickerViewDelegate>{
    double prob;
    double pourcentage;
    double effect;
    
    double moyen;
    double ecarttype;
    double populationNum;
    
    NSInteger integerPart, demicalPart;
    
    UIPickerView * picker;
    NSArray *pickerArray;
    
    UITextField *seuil;
    UITextField *moyenne;
    UITextField *ecartType;
    UITextField *effectif;
    UITextField *intervalle;
    UITextField *soit;
    
    IBOutlet UITextField *resultatCorrige;
    IBOutlet UITextField *population;
    
    
    UIBarButtonItem *clearButton;
}
@property (nonatomic, retain) IBOutlet UITextField *seuil;

@property (nonatomic, retain) IBOutlet UITextField *moyenne;
@property (nonatomic, retain) IBOutlet UITextField *ecartType;
@property (nonatomic, retain) IBOutlet UITextField *effectif;
@property (nonatomic, retain) IBOutlet UITextField *intervalle;
@property (nonatomic, retain) IBOutlet UITextField *soit;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *clearButton;

- (IBAction)clearBtnClicked:(id)sender;

@end
