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

@synthesize downpaymentLabel;
@synthesize netOperatingIncomeLabel;
@synthesize capitalizationRateLabel;
@synthesize cashOnCashReturnLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize taxesField;
@synthesize grossRentField;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initTextFields];
    [self createFormatters];

    [self setUpTextFieldsForInvestment:[self getPropertyInvestment]];
    
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
}

- (void) viewDidAppear:(BOOL)animated {
    [self refreshDownpayment];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateDownpaymentLabel];
    [self updateNetOperatingIncome];
}

- (void) refreshDownpayment {
    Mortgage *mortgage = self.getPropertyInvestment.mortgage;
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", mortgage.downpaymentPercent]];
    NSString * downpaymentString = [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:-[mortgage getDownpaymentAmount]]];
    [downpaymentLabel setText:downpaymentString];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
