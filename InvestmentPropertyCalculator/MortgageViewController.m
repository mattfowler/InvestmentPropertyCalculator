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

@synthesize downpaymentLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize interestRateField;
@synthesize mortgageTermField;

@synthesize mortgagePayment;
@synthesize totalInterestPaid;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTextFields];
    [self updateEditableFieldsFromModel];
}

-(void) viewDidAppear:(BOOL)animated {
    [self updateEditableFieldsFromModel];
    [self updateLabelsFromModel];
}

-(void) updateEditableFieldsFromModel {
    PropertyInvestment *investment = [self getPropertyInvestment];
    Mortgage *mortgage = investment.mortgage;
    
    [salesPriceField setText:[NSString stringWithFormat:@"%d" , mortgage.salesPrice]];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f" , mortgage.downpaymentPercent]];
    [interestRateField setText:[NSString stringWithFormat:@"%1.2f" , mortgage.interestRate]];
    [mortgageTermField setText:[NSString stringWithFormat:@"%d" , mortgage.amoritizationYears]];
}

-(void) updateLabelsFromModel {
    [super labelViewDidChange];
    Mortgage *mortgage = self.getPropertyInvestment.mortgage;
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", mortgage.downpaymentPercent]];
    [downpaymentLabel setText:[mortgage.getDownpaymentAmount getCurrencyString]];
    [mortgagePayment setText:[mortgage.getMonthlyPayment getCurrencyString]];
    [totalInterestPaid setText:[mortgage.getTotalInterestPaid getCurrencyString]];
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateModelFromTextFields];
    [self updateLabelsFromModel];
}

- (void) updateModelFromTextFields {
    Mortgage * mortgage = [self getPropertyInvestment].mortgage;
    [mortgage setSalesPrice:[[salesPriceField text] intValue]];
    [mortgage setInterestRate:[[interestRateField text] doubleValue]];
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setAmoritizationYears:[[mortgageTermField text] intValue]];
}

-(void)touchBackground:(id)sender {
    [salesPriceField resignFirstResponder];
    [downpaymentField resignFirstResponder];
    [mortgageTermField resignFirstResponder];
    [interestRateField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
