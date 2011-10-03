//
//  test1ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test1ViewController.h"
#import "normsinv.h"
@implementation test1ViewController
@synthesize resultat;

#pragma mark - calculs



- (void) calcule{
    double p = (1-niveauConfNum/100)/2;
    double n = normInv(p);
//    double n = [self normInv];
    n = n*n;
    double results = n*(0.5*(1-0.5))/(intervalleConfNum/100*intervalleConfNum/100);
    if (results < 30) results = 30;
    [resultat setText:[NSString stringWithFormat:@"%2.0f", results]];
  //  [soitEntre setText:[NSString stringWithFormat:@"%2.1f%% -- %2.1f%%", (pourcentage/100 - results)*100, (pourcentage/100 + results)*100]];
    
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
    [intervalleConf release];
    [taillePop release];
    [resultat release];
    [clearButton release];
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
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet setTag:0];
    [actionSheet showFromTabBar:self.view];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, 100, 0)];
    
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.showsSelectionIndicator = YES;
    
    picker.delegate = self;
    picker.dataSource = self;
    
    pickerArray = [[NSArray arrayWithObjects:@"80",@"85",@"90",@"95",@"99",nil]retain];
    picker.tag = 100;
    [picker selectRow:3 inComponent:0 animated:YES];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 400)];

    [actionSheet addSubview:picker];
    [picker release];
    
}

#pragma mark - delegate for actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//	NSString *returnStr;
//    switch (pickerView.tag) {
//        case 101:
//            if (component == 0){
//                returnStr = [NSString stringWithFormat:@"%d", row];
//            }
//            else{
//                returnStr = [NSString stringWithFormat:@"%d", row];
//            }
//            break;
//        default:
//            returnStr = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
//            break;
//    }
    
	return [NSString stringWithFormat:@"%@%%",[pickerArray objectAtIndex:row]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//	switch (pickerView.tag) {
//        case 101:
//            if (component == 0)
//                return 101;
//            else return 10;
//            break;
//        default:
//            return [pickerArray count];
//            break;
//    }
    return [pickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
//    if (pickerView.tag == 101){
//        return 2;
//    }
//    else return 1;
    return 1;
}

#pragma mark - delegates for uipickerview
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    switch (pickerView.tag) {
//        case 100:
//            NSLog(@"niveau de conf");
//            niveauConf.text = [pickerArray objectAtIndex:row];
//            prob = [niveauConf.text intValue];
//            [self calcule];
//            break;
//        case 101:
//            NSLog(@"intervalle de conf");
//            if (component == 0){
//                integerPart = row;
//                
//            }
//            else {
//                demicalPart = row;
//            }
//            intervalleConf.text = [NSString stringWithFormat:@"%d.%d%%", integerPart, demicalPart];
//            pourcentage = [[NSString stringWithFormat:@"%d.%d", integerPart, demicalPart] floatValue];
//            [self calcule];
//            break;
//        default:
//            break;
//    }
    niveauConf.text = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
    niveauConfNum = [[pickerArray objectAtIndex:row] intValue];
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
//            [self createPickerWithId:1];
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
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
    NSLog(@"shouldReturn");
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = nil;
    
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
	for (UITouch *touch in touches){
		if ([taillePop isFirstResponder]){
            [taillePop resignFirstResponder];
            if (![taillePop.text isEqualToString:@""]){
                taillePopNum = [taillePop.text intValue];
            }
            [taillePop setText:[NSString stringWithFormat:@"%d",taillePopNum]];
        }
        if ([intervalleConf isFirstResponder]){
            [intervalleConf resignFirstResponder];
            if (![intervalleConf.text isEqualToString:@"" ]){
                intervalleConfNum = [intervalleConf.text floatValue];
            }
            [intervalleConf setText:[NSString stringWithFormat:@"%2.1f%%", intervalleConfNum]];
        }
	}
    
   [self calcule];
    
}
#pragma mark - uibarbuttonitem actions
- (IBAction)clearBtnClicked : (id) sender{
    [niveauConf setText:@"95%"];
    [intervalleConf setText:@"5.0%"];
    [taillePop setText:@"15000"];
    [resultat setText:@""];

    [self initTexts];
    
}


#pragma mark - View lifecycle


- (void) initTexts{
    niveauConfNum = 95;
    intervalleConfNum = 5;
    taillePopNum = 15000;
    [self calcule];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [clearButton setTarget:self];
    [clearButton setAction:@selector(clearBtnClicked)];
    [intervalleConf setKeyboardType:UIKeyboardTypeDecimalPad];
    [taillePop setKeyboardType:UIKeyboardTypeDecimalPad];
    
    [self initTexts];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [niveauConf release];
    niveauConf = nil;
    [intervalleConf release];
    intervalleConf = nil;
    [taillePop release];
    taillePop = nil;
    [resultat release];
    resultat = nil;
    [clearButton release];
    clearButton = nil;
    [self setResultat:nil];
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
