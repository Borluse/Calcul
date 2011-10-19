//
//  test3ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-5-18.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test3ViewController.h"
#import "normsinv.h"

@implementation test3ViewController
@synthesize seuil;
@synthesize moyenne;
@synthesize ecartType;
@synthesize effectif;
@synthesize intervalle;
@synthesize soit;
@synthesize clearButton;




- (void) calcul{
    double norme = normInv(PROP(prob));
    norme = norme * norme;
    
    double results = sqrt(norme*(ecarttype*ecarttype)/(effect));
    [intervalle setText:[NSString stringWithFormat:@"%2.3f", results]];
    [soit setText:[NSString stringWithFormat:@"%2.1f -- %2.1f", (moyen - results), (moyen + results)]];
     
    double resultsCo;

    if(((effect/populationNum)>0.1)&&(effect<populationNum)) {
        resultsCo = results*sqrt((populationNum - effect)/(populationNum - 1));
        [resultatCorrige setText:[NSString stringWithFormat:@"%2.3f", resultsCo]];
    }else{
        [resultatCorrige setText:@""];
    }

}

#pragma mark - inits;
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
    [seuil release];
    [moyenne release];

    [ecartType release];
    [effectif release];
    [intervalle release];
    [soit release];
    [seuil release];
    [moyenne release];
    [ecartType release];
    [effectif release];
    [intervalle release];
    [soit release];
    [clearButton release];
    [population release];
    [resultatCorrige release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"validé", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet setTag:0];
    [actionSheet showFromTabBar:self.view];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 80, 100, 0)];
    
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
            seuil.text = [NSString stringWithFormat:@"%@%%", [pickerArray objectAtIndex:row]];
            prob = [seuil.text intValue];
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
            return NO;
            break;
        default:
            return YES;
            break;
    }
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//for (UITouch *touch in touches){
    if ([moyenne isFirstResponder]) [moyenne resignFirstResponder];
    if ([ecartType isFirstResponder]) [ecartType resignFirstResponder];
    if ([effectif isFirstResponder]) [effectif resignFirstResponder];
    if ([population isFirstResponder]) [population resignFirstResponder];
    if (![moyenne.text isEqualToString:@""]) moyen = [moyenne.text floatValue];
    if (![ecartType.text isEqualToString:@""]) ecarttype = [ecartType.text floatValue];
    if (![effectif.text isEqualToString:@""]) effect = [effectif.text floatValue];
    if (![population.text isEqualToString:@""]) populationNum = [population.text doubleValue];
    [moyenne setText:[NSString stringWithFormat:@"%2.1f", moyen]];
    [ecartType setText:[NSString stringWithFormat:@"%2.1f", ecarttype]];
    [effectif setText:[NSString stringWithFormat:@"%2.0f", effect]];
    [population setText:[NSString stringWithFormat:@"%2.0f", populationNum]];
    [self calcul];
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
- (IBAction)clearBtnClicked:(id)sender{
    [seuil setText:@"95%"];
    [moyenne setText:@"5.1"];
    [ecartType setText:@"1.0"];
    [effectif setText:@"150"];
    [population setText:@"20000"];

    [resultatCorrige setText:@""];
    [intervalle setText:@""];
    [soit setText:@""];
    [self initText];
}

#pragma mark - View lifecycle

- (void) initText{
    prob = 95;
    moyen = 5.1;
    ecarttype = 1.0;
    effect = 150;
    populationNum = 20000;
    [self calcul];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [moyenne setKeyboardType:UIKeyboardTypeDecimalPad];
    [ecartType setKeyboardType:UIKeyboardTypeDecimalPad];
    [effectif setKeyboardType:UIKeyboardTypeDecimalPad];
    [self initText];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [self setSeuil:nil];
    [self setMoyenne:nil];
    [self setEcartType:nil];
    [self setEffectif:nil];
    [self setIntervalle:nil];
    [self setSoit:nil];
    [self setClearButton:nil];
    [population release];
    population = nil;
    [resultatCorrige release];
    resultatCorrige = nil;
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
