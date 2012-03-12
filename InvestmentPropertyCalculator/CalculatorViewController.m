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
@synthesize afterTaxCashFlowLabel;

@synthesize salesPriceField;
@synthesize downpaymentField;
@synthesize taxBracketField;
@synthesize grossRentField;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initTextFields];
    
    [self updateEditableFieldsFromModel];    
    [self updateViewLabelsFromModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(textFieldValueDidChange)
                                          name:UITextFieldTextDidChangeNotification 
                                          object:nil];
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
    [salesPriceField setText:[NSString stringWithFormat:@"%d", investment.mortgage.salesPrice]];
    [downpaymentField setText:[NSString stringWithFormat:@"%1.2f", investment.mortgage.downpaymentPercent]];
    [grossRentField setText:[NSString stringWithFormat:@"%d", investment.grossIncome]];
    [taxBracketField setText:[NSString stringWithFormat:@"%1.2f", investment.taxBracket]];
}

-(void) updateViewLabelsFromModel {
    [netOperatingIncomeLabel setText:[self stringFromDollarsAndCents:self.getPropertyInvestment.getNetOperatingIncome]];
    [capitalizationRateLabel setText:[self stringFromPercent:self.getPropertyInvestment.getCapitalizationRate]];
    [cashOnCashReturnLabel setText:[self stringFromPercent:self.getPropertyInvestment.getCashOnCashReturn]];
    [afterTaxCashFlowLabel setText:[self stringFromDollarsAndCents:self.getPropertyInvestment.getAfterTaxCashFlow]];
    [self setDownpaymentLabelWithDownpaymentAmount:self.getPropertyInvestment.mortgage.getDownpaymentAmount];
}

-(void) updateModelFromView {
    self.getPropertyInvestment.grossIncome = [grossRentField.text intValue];
    self.getPropertyInvestment.taxBracket = [taxBracketField.text doubleValue];
    Mortgage *mortgage = self.getPropertyInvestment.mortgage;
    [mortgage setDownpaymentPercent:[[downpaymentField text] doubleValue]];
    [mortgage setSalesPrice:[[salesPriceField text] doubleValue]];
}

-(void) setDownpaymentLabelWithDownpaymentAmount:(double)amount {
    NSString * downpaymentString = [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:-amount]];
    [downpaymentLabel setText:downpaymentString];
}

-(NSString*) stringFromPercent:(double)percent {
    return [percentFormatter stringFromNumber:[NSNumber numberWithDouble:percent]];
}

-(NSString*) stringFromDollarsAndCents:(double)dollarsAndCents {
    return [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:dollarsAndCents]];
}

-(void)touchBackground:(id)sender{
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
