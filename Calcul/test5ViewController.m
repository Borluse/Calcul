//
//  test5ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test5ViewController.h"
#import "normsinv.h"

@implementation test5ViewController



-(double) _gamma : (double) data{
    if(data == 0.0) return 0;
    
    static double p0 = 1.000000000190015;
    
    double p[6] = {76.18009172947146, 
                   -86.50532032941677,
                   24.01409824083091,
                   -1.231739572450155,
                   1.208650973866179e-3,
                    -5.395239384953e-6};
    
    double y = data;
    double x = data;
    double tmp = x+5.5;
    tmp -= (x+0.5) * log(tmp);
    
    double summer = p0;
    
    for (int j=0; j<6; j++){
        summer += (p[j] / ++y);
    }
    double a1 = SQRT2PI * summer / x;
    
    double a = log(SQRT2PI * summer / x);
    double b = 0-tmp+a;
    double c = exp(b);
    
    return exp(0-tmp + log(SQRT2PI * summer / x));
    
}



-(double) _incompleteGamma : (double) a andB: (double) x{
    double summer = 0.0;
    int n ,i;
    double divisor;
    for (n =0; n<=32; ++n){
        divisor = a;
        for (i = 1; i<=n; ++i){
            divisor *= (a+i);
        }
        
        summer += (pow(x, n) / divisor);
    }
    return pow(x, a) * exp(0-x) * summer;

}   



-(double) CHIDIST: (double) value andDegree:(double) degree{
    double a =[self _incompleteGamma:degree/2 andB:value/2];
    double b = [self _gamma:degree/2];
    return 1 - (a / b);
}



- (double)chiinv: (double) prob andDegree: (double) degree{  
    double xLo = 100;
    double xHi = 0;
    double x = 1;
    double xNew = 1;
    double dx = 1;
    int i = 0;
    double result;

    
    while ((ABS(dx) > PRECISION) && (i++ < MAX_ITERATIONS)){
        result = [self CHIDIST:x andDegree:degree];
        double err = result - prob;
        if (err == 0){
            dx = 0;
        }else if (err < 0.0){
            xLo = x;
        } else{
            xHi = x;
        }
        
        if (result != 0.0) {
            dx = err / result;
            xNew = x - dx;
        }
        
        if ((xNew < xLo) || (xNew > xHi) || (result == 0.0)){
            xNew = (xLo + xHi) /2;
            dx = xNew - x;
        }
//        
        x = xNew;
        
    }
    if (i == MAX_ITERATIONS){
        return 0.0;
    }

    return round(x);

}



- (void) calcul{
    double p = (1.0-prob/100)/2;
    double n = normInv(p);
    double results = ABS(pourA - pourB)/sqrt(pourA * (1-pourA)/effetA +
                                             pourB * (1-pourB)/effetB);
    if (results > ABS(n)){
        resultNorLabel.text = NSLocalizedString(@"SIGNIFICATIF", nil);
    }else{
        resultNorLabel.text = NSLocalizedString(@"NONSIGNIFICATIF", nil);
    }
    
    double pourAS = pourA / 100;
    double pourBS = pourB / 100;
    
    double c =pourAS - pourBS;
    
    double a =ABS(c);
    double b = pow(((pourAS*(1-pourAS)/(effetA-1))+(pourBS*(1-pourBS)/(effetB-1))),0.5);
    
    double resultNormal = ABS(pourA/100-pourB/100)/pow(((pourA/100*(1-pourA/100)/(effetA-1))+(pourB/100*(1-pourB/100)/(effetB-1))),0.5);
    
//    double resultChi2 = pow((ABS((pourAS*effetA)-((effetA)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB)))-0.5),2)/((effetA)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB))+pow((ABS((pourBS*effetB)-((effetB)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB)))-0.5),2)/((effetB)*((pourAS*effetA)+(pourBS*effetB))/(effetA+effetB))+pow((ABS(((1-pourAS)*effetA)-((effetA)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB)))-0.5),2)/((effetA)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB))+pow((ABS(((1-pourBS)*effetB)-((effetB)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB)))-0.5),2)/((effetB)*(((1-pourAS)*effetA)+((1-pourBS)*effetB))/(effetA+effetB));
    
    
  
    
    [loiNormalText setText:[NSString stringWithFormat:@"%3.2f", resultNormal]];
 
//    if (prob/100 == 0.95) p = 3.841458821;
//    else if (prob/100 == 0.99) p = 6.6348966;
//    else p = [self chiinv:1.0-prob/100 andDegree:1];
//    if ( p < resultChi2) {
//        [resultChi2Label setText: SIGNIF];
//    }
//    else{
//        [resultChi2Label setText: NON_SIGNIF];
//    }
    
    if (normInv(1-(1-prob/100)/2 )< resultNormal) {
        [resultNorLabel setText:SIGNIF];
    }
    else{
        [resultNorLabel setText:NON_SIGNIF];
    }
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
    [resultNorLabel release];
    resultNorLabel = nil;
    [clearBtn release];
    clearBtn = nil;
    [resultNorLabel release];
    resultNorLabel = nil;
    [loiNormalText release];
    loiNormalText = nil;
    [test5Titre release];
    test5Titre = nil;
    [test5Ele1Titre release];
    test5Ele1Titre = nil;
    [test5Ele2Titre release];
    test5Ele2Titre = nil;
    [test5Ele3Titre release];
    test5Ele3Titre = nil;
    [AvecTitre release];
    AvecTitre = nil;
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
    [resultNorLabel release];
    [clearBtn release];
    [resultNorLabel release];
    [loiNormalText release];
    [test5Titre release];
    [test5Ele1Titre release];
    [test5Ele2Titre release];
    [test5Ele3Titre release];
    [AvecTitre release];
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
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"MOLETTEVALIDER", nil), nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet setTag:0];
    [actionSheet showFromTabBar:self.view];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, 320, 0)];
    
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.showsSelectionIndicator = YES;
    
    picker.delegate = self;
    picker.dataSource = self;
    
    pickerArray = [[NSArray arrayWithObjects:@"80",@"85",@"90",@"95",@"99",nil]retain];
    picker.tag = 100;
    int idx;
    idx = [pickerArray indexOfObject:[NSString stringWithFormat:@"%2.0f", prob]];
    
    [picker selectRow:idx inComponent:0 animated:YES];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 400)];
    
    [actionSheet addSubview:picker];
    [picker release];
    
}

#pragma mark - delegate for actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self calcul];
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
        case 0:;
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
	//for (UITouch *touch in touches){
		if ([pourAText isFirstResponder]) [pourAText resignFirstResponder];
  		if ([pourBText isFirstResponder]) [pourBText resignFirstResponder];
        if ([effectAText isFirstResponder]) [effectAText resignFirstResponder];
        if ([effectBText isFirstResponder]) [effectBText resignFirstResponder];
       
        if (![pourAText.text isEqualToString:@""]) pourA = [pourAText.text floatValue];
        if (![pourBText.text isEqualToString:@""]) pourB = [pourBText.text floatValue];
        if (![effectAText.text isEqualToString:@""]) effetA = [effectAText.text floatValue];
        if (![effectBText.text isEqualToString:@""]) effetB = [effectBText.text floatValue];
        
        [pourAText setText:[NSString stringWithFormat:@"%2.1f", pourA]];
        [pourBText setText:[NSString stringWithFormat:@"%2.1f", pourB]];
        [effectAText setText:[NSString stringWithFormat:@"%2.0f", effetA]];
        [effectBText setText:[NSString stringWithFormat:@"%2.0f", effetB]];        
        [self calcul];
	//	}
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [clearBtn setTarget:self];
    [clearBtn setAction:@selector(clearBtnClicked)];
    [pourAText setKeyboardType:UIKeyboardTypeDecimalPad];
    [pourBText setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectAText setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectBText setKeyboardType:UIKeyboardTypeDecimalPad];
    [self initText];
    
    // Do any additional setup after loading the view from its nib.
    /* localized*/
    
    [test5Titre setText:NSLocalizedString(@"TEST5_TITRE",nil)];
    [test5Ele1Titre setText:NSLocalizedString(@"TEST5_ELEMENT1",nil)];
    [test5Ele2Titre setText:NSLocalizedString(@"TEST5_ELEMENT2",nil)];  
    [test5Ele3Titre setText:NSLocalizedString(@"TEST5_ELEMENT3",nil)];    
    [AvecTitre setText:NSLocalizedString(@"AVECLOINORMAL",nil)];    
}
@end
