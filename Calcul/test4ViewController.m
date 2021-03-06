//
//  test4ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test4ViewController.h"
#import "normsinv.h"

@implementation test4ViewController

@synthesize clearBtn;


- (void) calcul{

    double norme = normInv(PROP(prob));
    
    if (ABS(moyA-moyB)/sqrt((ecartA * ecartA)/effectA + (ecartB * ecartB)/effectB)>ABS(norme)){
        [resultLabel setText:NSLocalizedString(@"SIGNIFICATIF", nil)];
    }else{
        [resultLabel setText:NSLocalizedString(@"NONSIGNIFICATIF", nil)];
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
    [self setClearBtn:nil];
    [seuilText release];
    seuilText = nil;
    [moyTextA release];
    moyTextA = nil;
    [moyTextB release];
    moyTextB = nil;
    [ecartTypeTextA release];
    ecartTypeTextA = nil;
    [ecartTypeTextB release];
    ecartTypeTextB = nil;
    [effectifTextA release];
    effectifTextA = nil;
    [effectifTextB release];
    effectifTextB = nil;
    [test4Titre release];
    test4Titre = nil;
    [test4Ele1Titre release];
    test4Ele1Titre = nil;
    [test4Ele2Titre release];
    test4Ele2Titre = nil;
    [test4Ele3Titre release];
    test4Ele3Titre = nil;
    [test4Ele4Titre release];
    test4Ele4Titre = nil;
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
    [clearBtn release];
    [seuilText release];
    [moyTextA release];
    [moyTextB release];
    [ecartTypeTextA release];
    [ecartTypeTextB release];
    [effectifTextA release];
    [effectifTextA release];
    [effectifTextB release];
    [test4Titre release];
    [test4Ele1Titre release];
    [test4Ele2Titre release];
    [test4Ele3Titre release];
    [test4Ele4Titre release];
    [super dealloc];
}
- (IBAction)clearBtnClicked:(id)sender {
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
    
    switch (tag) {
        case 0:
            pickerArray = [[NSArray arrayWithObjects:@"80",@"85",@"90",@"95",@"99",nil]retain];
            int idx;
            idx = [pickerArray indexOfObject:[NSString stringWithFormat:@"%2.0f", prob]];
            
            [picker selectRow:idx inComponent:0 animated:YES];
            picker.tag = 100;
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
    [self calcul];
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr;
    switch (pickerView.tag) {
        case 101:
            returnStr = [NSString stringWithFormat:@"%d%%",row+1];
            break;
        default:
            returnStr = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%"];
            break;
    }
	
	return returnStr;
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
    switch (pickerView.tag) {
        case 100:
            NSLog(@"Seuil");
            seuilText.text = [NSString stringWithFormat:@"%@%%",[pickerArray objectAtIndex:row]];
            prob = [seuilText.text intValue];
            [self calcul];            
            break;
        default:
            break;
    }
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
    
    NSArray * allTextField = [self.view subviews];
    for (NSObject * ui in allTextField) {
        if ([ui class] == [UITextField class]){
            UITextField * at = (UITextField *) ui;
            at.text = [at.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
        }
    }  
	//for (UITouch *touch in touches){
		if ([moyTextA isFirstResponder]) [moyTextA resignFirstResponder];
  		if ([moyTextB isFirstResponder]) [moyTextB resignFirstResponder];
        if ([ecartTypeTextA isFirstResponder]) [ecartTypeTextA resignFirstResponder];
        if ([ecartTypeTextB isFirstResponder]) [ecartTypeTextB resignFirstResponder];
        if ([effectifTextA isFirstResponder]) [effectifTextA resignFirstResponder];
        if ([effectifTextB isFirstResponder]) [effectifTextB resignFirstResponder];        
        if (![moyTextA.text isEqualToString:@""]) moyA = [moyTextA.text floatValue];
        if (![moyTextB.text isEqualToString:@""]) moyB = [moyTextB.text floatValue];
        if (![ecartTypeTextA.text isEqualToString:@""]) ecartA = [ecartTypeTextA.text floatValue];
        if (![ecartTypeTextB.text isEqualToString:@""]) ecartB = [ecartTypeTextB.text floatValue];
        if (![effectifTextA.text isEqualToString:@""]) effectA = [effectifTextA.text floatValue];
        if (![effectifTextB.text isEqualToString:@""]) effectB = [effectifTextB.text floatValue];
        [moyTextA setText:[NSString stringWithFormat:@"%2.1f",moyA]];
        [moyTextB setText:[NSString stringWithFormat:@"%2.1f",moyB]];
        [ecartTypeTextA setText:[NSString stringWithFormat:@"%2.1f", ecartA]];
        [ecartTypeTextB setText:[NSString stringWithFormat:@"%2.1f", ecartB]]; 
        [effectifTextA setText:[NSString stringWithFormat:@"%2.0f", effectA]];
        [effectifTextB setText:[NSString stringWithFormat:@"%2.0f", effectB]];
        [self calcul];
	//}
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
    [seuilText setText:@"95%"];
    [moyTextA setText:@"5.1"];
    [moyTextB setText:@"5.1"];    
    [ecartTypeTextA setText:@"1.0"];
    [ecartTypeTextB setText:@"1.0"];    
    [effectifTextA setText:@"150"];
    [effectifTextB setText:@"150"];    
    [resultLabel setText:@""];
    [self initText];
}


- (void) initText{
    prob = 95;
    moyA = 5.1;
    moyB = 5.1;
    ecartA = 1.0;
    ecartB = 1.0;
    effectA = 150;
    effectB = 150;
    [self calcul];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [clearBtn setTarget:self];
    [clearBtn setAction:@selector(clearBtnClicked)];
    [moyTextA setKeyboardType:UIKeyboardTypeDecimalPad];
    [moyTextB setKeyboardType:UIKeyboardTypeDecimalPad];
    [ecartTypeTextA setKeyboardType:UIKeyboardTypeDecimalPad];
    [ecartTypeTextB setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectifTextA setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectifTextB setKeyboardType:UIKeyboardTypeDecimalPad];
    [self initText];
    
    
    /* localized*/
    
    [test4Titre setText:NSLocalizedString(@"TEST4_TITRE",nil)];
    [test4Ele1Titre setText:NSLocalizedString(@"TEST4_ELEMENT1",nil)];
    [test4Ele2Titre setText:NSLocalizedString(@"TEST4_ELEMENT2",nil)];  
    [test4Ele3Titre setText:NSLocalizedString(@"TEST4_ELEMENT3",nil)];    
    [test4Ele4Titre setText:NSLocalizedString(@"TEST4_ELEMENT4",nil)];    
    
    
    
    // Do any additional setup after loading the view from its nib.
}


@end
