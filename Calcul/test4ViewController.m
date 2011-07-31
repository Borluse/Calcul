//
//  test4ViewController.m
//  Calcul
//
//  Created by Fan ZHAO on 11-7-25.
//  Copyright 2011年 Personne. All rights reserved.
//

#import "test4ViewController.h"

@implementation test4ViewController

@synthesize clearBtn;

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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
    
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
            [picker selectRow:3 inComponent:0 animated:YES];
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
            returnStr = [[pickerArray objectAtIndex:row] stringByAppendingString:@"%%"];
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
            seuilText.text = [pickerArray objectAtIndex:row];
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
	for (UITouch *touch in touches){
		if ([moyTextA isFirstResponder]) [moyTextA resignFirstResponder];
  		if ([moyTextB isFirstResponder]) [moyTextB resignFirstResponder];
        if ([ecartTypeTextA isFirstResponder]) [ecartTypeTextA resignFirstResponder];
        if ([ecartTypeTextB isFirstResponder]) [ecartTypeTextB resignFirstResponder];
        if ([effectifTextA isFirstResponder]) [effectifTextA resignFirstResponder];
        if ([effectifTextB isFirstResponder]) [effectifTextB resignFirstResponder];        
        moyen = [moyenne.text floatValue];
        ecarttype = [ecartType.text floatValue];
        effect = [effectif.text floatValue];
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
    [seuil setText:@"95%"];
    [moyenne setText:@"5.1"];
    [ecartType setText:@"1.0"];
    [effectif setText:@"150"];
    [intervalle setText:@""];
    [soit setText:@""];
    [self initText];
}


- (void) initText{
    prob = 95;
    moyen = 5.1;
    ecarttype = 1.0;
    effect = 150;
    [self calcul];
}



@end
