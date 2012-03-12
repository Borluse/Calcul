//
//  test2ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-5-18.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test2ViewController.h"
#import "normsinv.h"

@implementation test2ViewController
@synthesize resultat;
@synthesize soitEntre;

#pragma mark - calculs


- (void) calcule{

    
    double norme = normInv(PROP(prob));
    norme = norme * norme;

    double results = sqrt(norme*(pourcentage/100*(1.0-pourcentage/100))/(effect));
    [resultat setText:[NSString stringWithFormat:@"%2.1f%%", results*100]];
    [soitEntre setText:[NSString stringWithFormat:@"%2.1f%% -- %2.1f%%", (pourcentage/100 - results)*100, (pourcentage/100 + results)*100]];

    double resultsCo;

    if(((effect/populationNum)>0.1)&&(effect<populationNum)) {
        resultsCo = results*sqrt((populationNum - effect)/(populationNum - 1));
        [resultatCorrige setText:[NSString stringWithFormat:@"%2.1f%%", resultsCo*100]];
    }else{
        [resultatCorrige setText:@""];
    }
}

#pragma mark - inits

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [niveauConf release];
    [pourcentageObserve release];
    [effectif release];
    [resultat release];
    [soitEntre release];
    [clearButton release];
    [clearButton release];
    [resultat release];
    [soitEntre release];
    [niveauConf release];
    [pourcentageObserve release];
    [effectif release];
    [clearButton release];
    [clearButton release];
    [population release];
    [resultatCorrige release];
    [test2Titre release];
    [test2Ele1Titre release];
    [test2Ele2Titre release];
    [test2Ele3Titre release];
    [test2Ele4Titre release];
    [test2Result1Titre release];
    [test2Result2Titre release];
    [test2Result3Titre release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - create number pad

-(void) createNumberPad{
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"validé", nil];
    //    
    //    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    //    [actionSheet setTag:0];
    //    [actionSheet showFromTabBar:self.view];
    
    
}



#pragma mark - uipickerview


// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - 84.0 - size.height,
                                   size.width,
                                   size.height);
	return pickerRect;
}


- (void) createPickerWithId:(NSInteger)tag{
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"MOLETTEVALIDER", nil), nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet setTag:0];
    [actionSheet showFromTabBar:self.view];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, 320, 0)];
    
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.showsSelectionIndicator = YES;
    
    picker.delegate = self;
    picker.dataSource = self;
    
    switch (tag) {
        case 0:
            pickerArray = [[NSArray arrayWithObjects:@"80",@"85",@"90",@"95",@"99",nil]retain];
            picker.tag = 100;
            int idx;
            idx = [pickerArray indexOfObject:[NSString stringWithFormat:@"%2.0f", prob]];
            

            [picker selectRow:idx inComponent:0 animated:YES];
            break;
        case 1:
            picker.tag = 101;
            [picker selectRow:5 inComponent:0 animated:YES];
            [picker selectRow:0 inComponent:1 animated:YES];
            break;
        default:
            break;
    }
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 400)];
    //    [actionSheet addSubview:picker];
    [actionSheet addSubview:picker];
    [picker release];
    
}

#pragma mark - delegate for actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self calcule];
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr;
    switch (pickerView.tag) {
        case 101:
            if (component == 0){
                returnStr = [NSString stringWithFormat:@"%d", row];
            }
            else{
                returnStr = [NSString stringWithFormat:@"%d", row];
            }
            break;
        default:
            returnStr = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
            break;
    }
	
	return returnStr;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	switch (pickerView.tag) {
        case 101:
            if (component == 0)
                return 101;
            else return 10;
            break;
        default:
            return [pickerArray count];
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 101){
        return 2;
    }
    else return 1;
}

#pragma mark - delegates for uipickerview
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 100:
            NSLog(@"niveau de conf");
            niveauConf.text = [NSString stringWithFormat:@"%@%%",[pickerArray objectAtIndex:row]];
            prob = [niveauConf.text intValue];
            [self calcule];
            break;
        case 101:
            NSLog(@"intervalle de conf");
            if (component == 0){
                integerPart = row;
                
            }
            else {
                demicalPart = row;
            }
            pourcentageObserve.text = [NSString stringWithFormat:@"%d.%d%%", integerPart, demicalPart];
            pourcentage = [[NSString stringWithFormat:@"%d.%d", integerPart, demicalPart] floatValue];
            [self calcule];
            break;
        default:
            break;
    }
}


#pragma mark - delegates of textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"niveauConf");
            [self createPickerWithId:0];
            break;
        case 1:
            NSLog(@"intervalleConf");
            return YES;
            break;
        case 2:
            NSLog(@"Taille de la population");
            [self createNumberPad];
            return YES;
            break;
        default:
            break;
    }
    return NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
    NSLog(@"shouldReturn");
    [textField resignFirstResponder];
    
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"didbegin");
}

#pragma mark - Display the selectors called
/*
 This function can display the Selector called.
 */
- (BOOL)respondsToSelector:(SEL)aSelector {
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"respondsToSelector:%@", methodName); 
	return [super respondsToSelector:aSelector];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//for (UITouch *touch in touches){
    if ([effectif isFirstResponder]){
        [effectif resignFirstResponder];
    }
    if ([pourcentageObserve isFirstResponder]){
        [pourcentageObserve resignFirstResponder];
    }
    if ([population isFirstResponder]){
        [population resignFirstResponder];
    }
    if (![effectif.text isEqualToString:@""]){
        effectif.text = [effectif.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
        effect = [effectif.text intValue];
    }
    [effectif setText:[NSString stringWithFormat:@"%2.0f", effect]];
    if (![pourcentageObserve.text isEqualToString:@""]){
        pourcentageObserve.text = [pourcentageObserve.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
        pourcentage = [pourcentageObserve.text doubleValue];
    }
    [pourcentageObserve setText:[NSString stringWithFormat:@"%2.1f", pourcentage]];
    if (![population.text isEqualToString:@""]){
        population.text = [population.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
        populationNum = [population.text doubleValue];
    }
    [population setText:[NSString stringWithFormat:@"%2.0f", populationNum]];
    [self calcule];
}
#pragma mark - uibarbuttonitem actions
- (IBAction)clearBtnClicked : (id) sender{
    [niveauConf setText:@"95%"];
    [pourcentageObserve setText:@"50.0"];
    [effectif setText:@"150"];
    [population setText:@"20000"];
    
    [resultat setText:@""];
    [soitEntre setText:@""];
    [resultatCorrige setText:@""];
    [self initTexts];
    
}


#pragma mark - View lifecycle


- (void) initTexts{
    prob = 95;
    pourcentage = 50;
    effect = 150;
    [self calcule];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [pourcentageObserve setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectif setKeyboardType:UIKeyboardTypeDecimalPad];
    
    [self initTexts];

    /* localized*/
    
    [test2Titre setText:NSLocalizedString(@"TEST2_TITRE",nil)];
    [test2Ele1Titre setText:NSLocalizedString(@"TEST2_ELEMENT1",nil)];
    [test2Ele2Titre setText:NSLocalizedString(@"TEST2_ELEMENT2",nil)];  
    [test2Ele3Titre setText:NSLocalizedString(@"TEST2_ELEMENT3",nil)];    
    [test2Ele4Titre setText:NSLocalizedString(@"TEST2_ELEMENT4",nil)];    
    [test2Result1Titre setText:NSLocalizedString(@"TEST2_RESULTAT1",nil)];
    [test2Result2Titre setText:NSLocalizedString(@"TEST2_RESULTAT2",nil)];
    [test2Result3Titre setText:NSLocalizedString(@"TEST2_RESULTAT3",nil)];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [niveauConf release];
    niveauConf = nil;
    [pourcentageObserve release];
    pourcentageObserve = nil;
    [effectif release];
    effectif = nil;
    [resultat release];
    resultat = nil;
    [soitEntre release];
    soitEntre = nil;
    [clearButton release];
    clearButton = nil;
    [self setResultat:nil];
    [self setSoitEntre:nil];
    [niveauConf release];
    niveauConf = nil;
    [pourcentageObserve release];
    pourcentageObserve = nil;
    [effectif release];
    effectif = nil;
    [clearButton release];
    clearButton = nil;
    [clearButton release];
    clearButton = nil;
    [resultatCorrige release];
    resultatCorrige = nil;
    [test2Titre release];
    test2Titre = nil;
    [test2Ele1Titre release];
    test2Ele1Titre = nil;
    [test2Ele2Titre release];
    test2Ele2Titre = nil;
    [test2Ele3Titre release];
    test2Ele3Titre = nil;
    [test2Ele4Titre release];
    test2Ele4Titre = nil;
    [test2Result1Titre release];
    test2Result1Titre = nil;
    [test2Result2Titre release];
    test2Result2Titre = nil;
    [test2Result3Titre release];
    test2Result3Titre = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
