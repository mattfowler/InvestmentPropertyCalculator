//
//  FirstViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Mortgage.h"
#import "PropertyInvestmentProtocol.h"
#import "PropertyInvestment.h"

@implementation CalculatorViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize navigationBar;

@synthesize downpaymentLabel;
@synthesize netOperatingIncomeLabel;
@synthesize capitalizationRateLabel;
@synthesize cashOnCashReturnLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize taxesField;
@synthesize grossRentField;

@synthesize labelView;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    salesPriceField.keyboardType = UIKeyboardTypeDecimalPad;
    downpaymentField.keyboardType = UIKeyboardTypeDecimalPad;
    grossRentField.keyboardType = UIKeyboardTypeDecimalPad;
    taxesField.keyboardType = UIKeyboardTypeDecimalPad;
    
    dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    percentFormatter = [[[NSNumberFormatter alloc] init] retain];
    [percentFormatter setNumberStyle: NSNumberFormatterPercentStyle];
    
    [downpaymentField setDelegate:self];
    [salesPriceField setDelegate:self];
    [taxesField setDelegate:self];
    [grossRentField setDelegate:self];

    [self.view addSubview:labelView];

    PropertyInvestment *propertyInvestment = [self getPropertyInvestment];
    [salesPriceField setText:[NSString stringWithFormat:@"%d", [propertyInvestment mortgage].salesPrice]];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", [propertyInvestment mortgage].downpaymentPercent]];
    [grossRentField setText:[NSString stringWithFormat:@"%d", [propertyInvestment grossIncome]]];

    
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction) - textFieldRect.size.height  - 20;
    }
    else {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction) -  textFieldRect.size.height;
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    CGRect labelViewFrame = self.labelView.frame;
    labelViewFrame.origin.y = animatedDistance;
    
    [self.view setFrame:viewFrame];
    [self.labelView setFrame:labelViewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
	[self dismissModalViewControllerAnimated:YES];
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    CGRect labelViewFrame = self.labelView.frame;
    labelViewFrame.origin.y -= animatedDistance - navigationBar.frame.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    [self.labelView setFrame:labelViewFrame];
    
    [UIView commitAnimations];
}

- (void) updateDownpaymentLabel {
    Mortgage *mortgage = self.getPropertyInvestment.mortgage;
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setSalesPrice:[[salesPriceField text] doubleValue]];
    NSString * downpaymentString = [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:-[mortgage getDownpaymentAmount]]];
    [downpaymentLabel setText:downpaymentString];
}

- (void) updateNetOperatingIncome {
    self.getPropertyInvestment.grossIncome = [grossRentField.text intValue]; 
    int netIncome = self.getPropertyInvestment.getNetOperatingIncome;
    [netOperatingIncomeLabel setText:[dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:netIncome]]];
    [capitalizationRateLabel setText:[percentFormatter stringFromNumber:[NSNumber numberWithDouble:self.getPropertyInvestment.getCapitalizationRate]]];
    [cashOnCashReturnLabel setText:[percentFormatter stringFromNumber:[NSNumber numberWithDouble:self.getPropertyInvestment.getCashOnCashReturn]]];
}

-(void)touchBackground:(id)sender{
    [salesPriceField resignFirstResponder];
    [downpaymentField resignFirstResponder];
    [grossRentField resignFirstResponder];
    [taxesField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
