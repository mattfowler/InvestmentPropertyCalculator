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
@synthesize entryScrollView;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 5);
        
    [self initTextFields];
    [self createFormatters];
    
    [self.view addSubview:labelView];

    [self setUpTextFieldsForInvestment:[self getPropertyInvestment]];
    
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
}

- (void)setUpTextFieldsForInvestment:(PropertyInvestment *) investment {
    [salesPriceField setText:[NSString stringWithFormat:@"%d", [investment mortgage].salesPrice]];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", [investment mortgage].downpaymentPercent]];
    [grossRentField setText:[NSString stringWithFormat:@"%d", [investment grossIncome]]];
    [taxesField setText:[NSString stringWithFormat:@"%1.2f", investment.expenses.taxes]];
}

-(void) initTextFields {
    [downpaymentField setDelegate:self];
    [salesPriceField setDelegate:self];
    [taxesField setDelegate:self];
    [grossRentField setDelegate:self];
    salesPriceField.keyboardType = UIKeyboardTypeDecimalPad;
    downpaymentField.keyboardType = UIKeyboardTypeDecimalPad;
    grossRentField.keyboardType = UIKeyboardTypeDecimalPad;
    taxesField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void) createFormatters {
    dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    percentFormatter = [[[NSNumberFormatter alloc] init] retain];
    [percentFormatter setNumberStyle: NSNumberFormatterPercentStyle];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.entryScrollView convertRect:textField.bounds fromView:textField];
    
    CGRect viewFrame = self.entryScrollView.frame;
    animatedDistance = self.view.frame.size.height - PORTRAIT_KEYBOARD_HEIGHT - navigationBar.frame.size.height + 15;
    viewFrame.size.height -= animatedDistance;
    
    CGFloat textFieldOffset = entryScrollView.contentOffset.y + textFieldRect.origin.y - textFieldRect.size.height/2 - 15;
    [entryScrollView setContentOffset:CGPointMake(entryScrollView.contentOffset.x, textFieldOffset)  animated:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
    [self.entryScrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
	[self dismissModalViewControllerAnimated:YES];

    CGRect viewFrame = self.entryScrollView.frame;
    viewFrame.size.height += animatedDistance;
   
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.entryScrollView setFrame:viewFrame];
    
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
    self.getPropertyInvestment.expenses.taxes = [taxesField.text intValue];
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
