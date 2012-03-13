//
//  ExpensesViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesViewController.h"
#import "PropertyExpenses.h"
#import "PropertyInvestment.h"

@implementation ExpensesViewController

@synthesize taxesField;
@synthesize insuranceField;
@synthesize maintanenceField;
@synthesize utilitiesField;
@synthesize vacancyField;
@synthesize otherField;

@synthesize netOperatingIncomeLabel;
@synthesize monthlyExpensesLabel;
@synthesize yearlyExpensesLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    super.entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 75);
    [self initTextFields];
    [self updateEditableFieldsFromModel];
    [self updateLabelsFromModel];
}

-(void) initTextFields {
    [taxesField setDelegate:self];
    [insuranceField setDelegate:self];
    [maintanenceField setDelegate:self];
    [utilitiesField setDelegate:self];
    [vacancyField setDelegate:self];
    [otherField setDelegate:self];
    taxesField.keyboardType = UIKeyboardTypeDecimalPad;
    insuranceField.keyboardType = UIKeyboardTypeDecimalPad;
    maintanenceField.keyboardType = UIKeyboardTypeDecimalPad;
    utilitiesField.keyboardType = UIKeyboardTypeDecimalPad;
    vacancyField.keyboardType = UIKeyboardTypeDecimalPad;
    otherField.keyboardType = UIKeyboardTypeDecimalPad;
}

-(void) updateEditableFieldsFromModel {
    PropertyInvestment *investment = [self getPropertyInvestment];
    PropertyExpenses *expenses = investment.expenses;
    
    [taxesField setText:[NSString stringWithFormat:@"%d" , expenses.taxes]];
    [insuranceField setText:[NSString stringWithFormat:@"%d" , expenses.insurance]];
    [maintanenceField setText:[NSString stringWithFormat:@"%d" , expenses.maintainence]];
    [utilitiesField setText:[NSString stringWithFormat:@"%d" , expenses.utilities]];
    [vacancyField setText:[NSString stringWithFormat:@"%d" , expenses.vacancyRate]];
    [otherField setText:[NSString stringWithFormat:@"%d" , expenses.otherExpenses]];
}

-(void) updateLabelsFromModel {
    PropertyInvestment * investment = self.getPropertyInvestment;
    PropertyExpenses * expenses = investment.expenses;

    [netOperatingIncomeLabel setText:[self stringFromDollarsAndCents:investment.getNetOperatingIncome]];
    [monthlyExpensesLabel setText:[self stringFromDollarsAndCents:expenses.getMonthlyExpenses]];
    [yearlyExpensesLabel setText:[self stringFromDollarsAndCents:expenses.getYearlyExpenses]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateModelFromTextFields];
    [self updateLabelsFromModel];
}

- (void) updateModelFromTextFields {
    PropertyExpenses * expenses = [self getPropertyInvestment].expenses;
    [expenses setTaxes:[[taxesField text] doubleValue]];
    [expenses setInsurance:[[insuranceField text] doubleValue]];
    [expenses setMaintainence:[[maintanenceField text] doubleValue]];
    [expenses setUtilities:[[utilitiesField text] doubleValue]];
    [expenses setVacancyRate:[[vacancyField text] doubleValue]];
    [expenses setOtherExpenses:[[otherField text] doubleValue]];
}


-(void)touchBackground:(id)sender{
    [taxesField resignFirstResponder];
    [insuranceField resignFirstResponder];
    [maintanenceField resignFirstResponder];
    [utilitiesField resignFirstResponder];
    [vacancyField resignFirstResponder];
    [otherField resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
