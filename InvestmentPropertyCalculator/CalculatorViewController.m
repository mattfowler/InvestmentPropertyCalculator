//
//  FirstViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Mortgage.h"
#import "DollarValueForInterval.h"
#import "PropertyInvestmentProtocol.h"
#import "PropertyInvestment.h"

@implementation CalculatorViewController

@synthesize downpaymentLabel;
@synthesize capitalizationRateLabel;
@synthesize cashOnCashReturnLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize taxBracketField;
@synthesize grossRentField;
@synthesize grossRentIntervalField;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initTextFields];
    [super setYearMonthToggleFrame:grossRentIntervalField forCorrespondingTextField:grossRentField];

    [self updateEditableFieldsFromModel];    
    [self updateViewLabelsFromModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(textFieldValueDidChange)
                                          name:UITextFieldTextDidChangeNotification 
                                          object:nil];
    
    [grossRentIntervalField addTarget:self
	                     action:@selector(changedRentPeriod:)
	           forControlEvents:UIControlEventValueChanged];
}

- (void) changedRentPeriod:(id) sender {
    TimeInterval selectedIndex = [grossRentIntervalField selectedSegmentIndex];
    double grossRent = [grossRentField.text doubleValue];
    DollarValueForInterval* dollarValue = [DollarValueForInterval createValue:grossRent forTimeInterval:selectedIndex];
    [self.getPropertyInvestment setGrossIncome:dollarValue];
    [self updateViewLabelsFromModel];
}

- (void) viewDidAppear:(BOOL)animated {
    [self updateEditableFieldsFromModel];
    [self updateViewLabelsFromModel];
}

-(void) initTextFields {
    [downpaymentField setDelegate:self];
    [salesPriceField setDelegate:self];
    [taxBracketField setDelegate:self];
    [grossRentField setDelegate:self];
    salesPriceField.keyboardType = UIKeyboardTypeDecimalPad;
    downpaymentField.keyboardType = UIKeyboardTypeDecimalPad;
    grossRentField.keyboardType = UIKeyboardTypeDecimalPad;
    taxBracketField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateModelFromView];
    [self updateViewLabelsFromModel];
}

- (void) textFieldValueDidChange {
    [self updateModelFromView];
    [self updateViewLabelsFromModel];
}

-(void) updateEditableFieldsFromModel {
    PropertyInvestment *investment = self.getPropertyInvestment;
    [salesPriceField setText:investment.mortgage.salesPrice.getDecimalString];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", investment.mortgage.downpaymentPercent]];
    [grossRentField setText:[[investment.grossIncome getDollarValueForTimeInterval:grossRentIntervalField.selectedSegmentIndex] getDecimalString]];
    [taxBracketField setText:[NSString stringWithFormat:@"%1.2f", investment.taxBracket]];
}

-(void) updateViewLabelsFromModel {
    [self labelViewDidChange];
    PropertyInvestment *propertyInvestment = self.getPropertyInvestment;
    [capitalizationRateLabel setText:propertyInvestment.getCapitalizationRate.getDisplayString];
    [cashOnCashReturnLabel setText:[self stringFromPercent:propertyInvestment.getCashOnCashReturn]];
    [downpaymentLabel setText:[propertyInvestment.mortgage.getDownpaymentAmount getCurrencyString]];
}

-(void) updateModelFromView {
    self.getPropertyInvestment.grossIncome = [DollarValueForInterval createValue:[grossRentField.text doubleValue] forTimeInterval:grossRentIntervalField.selectedSegmentIndex];
    self.getPropertyInvestment.taxBracket = [taxBracketField.text doubleValue];
    Mortgage *mortgage = self.getPropertyInvestment.mortgage;
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setSalesPrice:[DollarValue createValue:[[salesPriceField text] doubleValue]]];
}

-(void)touchBackground:(id)sender {
    [salesPriceField resignFirstResponder];
    [downpaymentField resignFirstResponder];
    [grossRentField resignFirstResponder];
    [taxBracketField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
