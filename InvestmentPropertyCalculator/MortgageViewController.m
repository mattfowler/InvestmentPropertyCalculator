//
//  SecondViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MortgageViewController.h"
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"

@implementation MortgageViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize navigationBar;
@synthesize labelView;
@synthesize entryScrollView;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize interestRateField;
@synthesize mortgageTermField;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    PropertyInvestment *investment = [self getPropertyInvestment];
    Mortgage *mortgage = investment.mortgage;
    double downpayment = mortgage.downpaymentPercent;
    double rate = mortgage.interestRate;
    int salesPrice = mortgage.salesPrice;
    int term = mortgage.amoritizationYears;
    
    [self initTextFields];
    [salesPriceField setText:[NSString stringWithFormat:@"%d" , salesPrice]];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f" , downpayment]];
    [interestRateField setText:[NSString stringWithFormat:@"%1.2f" , rate]];
    [mortgageTermField setText:[NSString stringWithFormat:@"%d" , term]];
    
    entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 5);
}

-(void) viewDidAppear:(BOOL)animated {
    //TODO: Update text fields appropriately!
}

-(void) initTextFields {
    [downpaymentField setDelegate:self];
    [salesPriceField setDelegate:self];
    [interestRateField setDelegate:self];
    [mortgageTermField setDelegate:self];
    salesPriceField.keyboardType = UIKeyboardTypeDecimalPad;
    downpaymentField.keyboardType = UIKeyboardTypeDecimalPad;
    interestRateField.keyboardType = UIKeyboardTypeDecimalPad;
    mortgageTermField.keyboardType = UIKeyboardTypeDecimalPad;
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
	[self dismissModalViewControllerAnimated:YES];
    
    CGRect viewFrame = self.entryScrollView.frame;
    viewFrame.size.height += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.entryScrollView setFrame:viewFrame];
    
    Mortgage * mortgage = [self getPropertyInvestment].mortgage;
    [mortgage setSalesPrice:[[salesPriceField text] intValue]];
    [mortgage setInterestRate:[[interestRateField text] doubleValue]];
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setAmoritizationYears:[[mortgageTermField text] intValue]];
    [UIView commitAnimations];
}

-(void)touchBackground:(id)sender{
    [salesPriceField resignFirstResponder];
    [downpaymentField resignFirstResponder];
    [mortgageTermField resignFirstResponder];
    [interestRateField resignFirstResponder];
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
