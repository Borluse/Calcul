//
//  test5ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test5ViewController.h"

@implementation test5ViewController


- (void) calcul{
    double p = (1-prob/100)/2;
    double n = normInv(p);
    double results = abs(pourA - pourB)/sqrt(pourA * (1-pourA)/effetA +
                                             pourB * (1-pourB)/effetB);
    if (results > abs(n)){
        resultNorLabel.text = SIGNIF;
    }else{
        resultNorLabel.text = NON_SIGNIF;
    }
    
//    double powA = pow((abs((effetA*pourA)-((effetA)*((effetA*pourA)+(effetB*pourB))/(effetA+effetB)))-0.5), 2);
//    double divA = ((effetA)*((effetA*pourA)+(effetB*pourB))/(effetA+effetB));
//    double powB = pow((abs((effetB*pourB)-((effetB)*((effetA*pourA)+(effetB*pourB))/(effetA+effetB)))-0.5), 2);
//    double divB = ((effetB)*((effetA*pourA)+(effetB*pourB))/(effetA+effetB));
//    double powC = pow((abs(((1-pourA)*effetA)-((effetA)*(((1-pourA)*effetA)+((1-pourB)*effetB))/(effetA+effetB)))-0.5),2);
//    double divC = ((effetA)*(((1-pourA)*effetA)+((1-pourB)*effetB))/(effetA+effetB));
//    double powD = pow((abs(((1-pourB)*effetB)-((effetB)*(((1-pourA)*effetA)+((1-pourB)*effetB))/(effetA+effetB)))-0.5),2);
//    double divD = ((effetB)*(((1-pourA)*effetA)+((1-pourB)*effetB))/(effetA+effetB));
//    
//    double resultChi2 = powA / divA + powB / divB + powC / divC + powD / divD;
    double pourAS = pourA / 100;
    double pourBS = pourB / 100;
    double resultChi2 = pow((abs((pourAS*effetA)-((effetA)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB)))-0.5),2)/((effetA)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB))+pow((abs((pourBS*effetB)-((effetB)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB)))-0.5),2)/((effetB)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB))+pow((abs(((1-pourAS)*effetA)-((effetA)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB)))-0.5),2)/((effetA)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB))+pow((abs(((1-pourBS)*effetB)-((effetB)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB)))-0.5),2)/((effetB)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB));
    [chi2Text setText:[NSString stringWithFormat:@"%3.2f", resultChi2]];
    double resultNormal = abs(pourBS-pourAS)/pow(((pourAS*(1-pourAS)/(effetA-1))+(pourBS*(1-pourBS)/(effetB-1))),0.5);
    
    [loiNormalText setText:[NSString stringWithFormat:@"%3.2f", resultNormal]];
    
    
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [niveauConfText release];
    niveauConfText = nil;
    [pourAText release];
    pourAText = nil;
    [pourBText release];
    pourBText = nil;
    [effectAText release];
    effectAText = nil;
    [effectBText release];
    effectBText = nil;
    [resultChi2Label release];
    resultChi2Label = nil;
    [resultNorLabel release];
    resultNorLabel = nil;
    [clearBtn release];
    clearBtn = nil;
    [resultNorLabel release];
    resultNorLabel = nil;
    [chi2Text release];
    chi2Text = nil;
    [loiNormalText release];
    loiNormalText = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [niveauConfText release];
    [pourAText release];
    [pourBText release];
    [effectAText release];
    [effectBText release];
    [resultChi2Label release];
    [resultNorLabel release];
    [clearBtn release];
    [resultNorLabel release];
    [chi2Text release];
    [loiNormalText release];
    [super dealloc];
}

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
    return [NSString stringWithFormat:@"%@%%",[pickerArray objectAtIndex:row]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

#pragma mark - delegates for uipickerview
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    niveauConfText.text = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
    prob = [[pickerArray objectAtIndex:row] intValue];
}


#pragma mark - delegates of textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"seuil");
            [self createPickerWithId:0];
            break;
        default:
            return YES;
            break;
    }
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	for (UITouch *touch in touches){
		if ([pourAText isFirstResponder]) [pourAText resignFirstResponder];
  		if ([pourBText isFirstResponder]) [pourBText resignFirstResponder];
        if ([effectAText isFirstResponder]) [effectAText resignFirstResponder];
        if ([effectBText isFirstResponder]) [effectBText resignFirstResponder];
       
        pourA = [pourAText.text floatValue];
        pourB = [pourBText.text floatValue];
        effetA = [effectAText.text floatValue];
        effetB = [effectBText.text floatValue];
        [self calcul];
	}
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

#pragma mark - uibarbuttonitem actions
- (void) clearBtnClicked{
    [niveauConfText setText:@"95%"];
    [pourAText setText:@"5.1"];
    [pourBText setText:@"5.1"];    
    [effectAText setText:@"150"];
    [effectBText setText:@"150"];    
    [resultNorLabel setText:@""];
    [resultChi2Label setText:@""];
    //    [resultLabel setText:@""];
    [self initText];
}


- (void) initText{
    prob = 95;
    pourA = 5.1;
    pourB = 5.1;
    effetA = 150;
    effetB = 150;
    
    [self calcul];
}

@end
