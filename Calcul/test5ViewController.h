//
//  test5ViewController.h
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PRECISION 8.88E-016
#define MAX_ITERATIONS 256
#define SQRT2PI 2.5066282746310005024157652848110452530069867406099

@interface test5ViewController : UIViewController{
    
    
    IBOutlet UITextField *niveauConfText;
    IBOutlet UITextField *pourAText;
    IBOutlet UITextField *pourBText;
    IBOutlet UITextField *effectAText;
    IBOutlet UITextField *effectBText;
    
//    IBOutlet UILabel *resultChi2Label;

    IBOutlet UILabel *resultNorLabel;

//    IBOutlet UITextField *chi2Text;    
    IBOutlet UITextField *loiNormalText;

    IBOutlet UIBarButtonItem *clearBtn;

    UIPickerView * picker;
    NSArray * pickerArray;
    
    double prob;
    double pourA, pourB, effetA, effetB;
    IBOutlet UILabel *test5Titre;
    IBOutlet UILabel *test5Ele1Titre;
    IBOutlet UILabel *test5Ele2Titre;
    IBOutlet UILabel *test5Ele3Titre;
    IBOutlet UILabel *AvecTitre;
}



@end
