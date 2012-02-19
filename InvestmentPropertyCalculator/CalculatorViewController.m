//
//  FirstViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Mortgage.h"

@implementation CalculatorViewController

@synthesize downpaymentLabel;
@synthesize netOperatingIncomeLabel;
@synthesize capitalizationRateLabel;
@synthesize cashOnCashReturnLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize grossRentField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    [downpaymentField setDelegate:self];
    [salesPriceField setDelegate:self];
    
    int salesPrice = [[salesPriceField text] intValue];
    double downpaymentPercent = [[downpaymentField text] doubleValue];

    mortgage = [[Mortgage alloc] initWithSalesPrice:salesPrice downpayment:downpaymentPercent interestRate:4.25 years:30];
    
    [self updateDownpaymentLabel];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateDownpaymentLabel];
}

- (void) updateDownpaymentLabel {
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setSalesPrice:[[salesPriceField text] doubleValue]];
    NSString * downpaymentString = [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:[mortgage getDownpaymentAmount]]];
    [downpaymentLabel setText:downpaymentString];
}

- (void) updateNetOperatingIncome {
    double grossIncome = [[grossRentField text] doubleValue];
    int netIncome = grossIncome - [mortgage getMonthlyPayment] * 12;
    [netOperatingIncomeLabel setText:[dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:netIncome]]];
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
