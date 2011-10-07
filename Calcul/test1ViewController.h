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
    double pourcentageAttenduNum;
    double effectifNum;
    
    NSInteger integerPart, demicalPart;
    
    UIPickerView * picker;
    NSArray *pickerArray;
    
    UITextField *resultat;
    IBOutlet UITextField *resultatCorrige;

    IBOutlet UITextField *niveauConf;
    IBOutlet UITextField *intervalleConf;
    IBOutlet UITextField *pourcentageAttendu;
    IBOutlet UITextField *effectif;

    IBOutlet UIBarButtonItem *clearButton;
}
@property (nonatomic, retain) IBOutlet UITextField *resultat;

@end
