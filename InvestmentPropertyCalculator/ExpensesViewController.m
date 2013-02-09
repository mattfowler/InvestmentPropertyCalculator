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
#import "DollarValueForInterval.h"
@implementation ExpensesViewController

@synthesize taxesField;
@synthesize taxesIntervalField;
@synthesize insuranceField;
@synthesize insuranceIntervalField;
@synthesize maintanenceField;
@synthesize maintanenceIntervalField;
@synthesize utilitiesField;
@synthesize utilitiesIntervalField;
@synthesize vacancyField;
@synthesize otherField;
@synthesize otherIntervalField;

@synthesize vacancyLabel;

@synthesize monthlyExpensesLabel;
@synthesize yearlyExpensesLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    super.entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 75);
    [self initTextFields];
    [self initPeriodFields];
    [self updateEditableFieldsFromModel];
    [self updateLabelsFromModel];
    [self initYearMonthToggles];
}

-(void) viewDidAppear:(BOOL)animated {
    [self updateEditableFieldsFromModel];
    [self updateLabelsFromModel];
}

-(void) initPeriodFields {
    [taxesIntervalField addTarget:self
                         action:@selector(changedTaxesPeriod:)
               forControlEvents:UIControlEventValueChanged];
    [insuranceIntervalField addTarget:self
                             action:@selector(changedInsurancePeriod:)
                   forControlEvents:UIControlEventValueChanged];
    [maintanenceIntervalField addTarget:self
                               action:@selector(changedMaintanencePeriod:)
                     forControlEvents:UIControlEventValueChanged];
    [utilitiesIntervalField addTarget:self
                             action:@selector(changedUtilitiesPeriod:)
                   forControlEvents:UIControlEventValueChanged];
    [otherIntervalField addTarget:self
                         action:@selector(changedOtherPeriod:)
               forControlEvents:UIControlEventValueChanged];
}

- (void) changedTaxesPeriod:(id) sender {
    PropertyExpenses* expenses = self.getPropertyInvestment.expenses;
    [self setExpenseForModel:^(DollarValueForInterval* value) {[expenses setTaxes:value];} fromUIField:taxesField withTimePeriod:taxesIntervalField.selectedSegmentIndex];
    [self updateLabelsFromModel];
}

- (void) changedInsurancePeriod:(id) sender {
    PropertyExpenses* expenses = self.getPropertyInvestment.expenses;
    [self setExpenseForModel:^(DollarValueForInterval* value) {[expenses setInsurance:value];} fromUIField:insuranceField withTimePeriod:insuranceIntervalField.selectedSegmentIndex];
    [self updateLabelsFromModel];
}

- (void) changedMaintanencePeriod:(id) sender {
    PropertyExpenses* expenses = self.getPropertyInvestment.expenses;
    [self setExpenseForModel:^(DollarValueForInterval* value) {[expenses setMaintenance:value];} fromUIField:maintanenceField withTimePeriod:maintanenceIntervalField.selectedSegmentIndex];
    [self updateLabelsFromModel];
}

- (void) changedUtilitiesPeriod:(id) sender {
    PropertyExpenses* expenses = self.getPropertyInvestment.expenses;
    [self setExpenseForModel:^(DollarValueForInterval* value) {[expenses setUtilities:value];} fromUIField:utilitiesField withTimePeriod:utilitiesIntervalField.selectedSegmentIndex];
    [self updateLabelsFromModel];
}

- (void) changedOtherPeriod:(id) sender {
    PropertyExpenses* expenses = self.getPropertyInvestment.expenses;
    [self setExpenseForModel:^(DollarValueForInterval* value) {[expenses setOtherExpenses:value];} fromUIField:otherField withTimePeriod:otherIntervalField.selectedSegmentIndex];
    [self updateLabelsFromModel];
}

-(void) setExpenseForModel:(void (^)(DollarValueForInterval*)) modelFieldSetter fromUIField:(UITextField*) textField withTimePeriod:(TimeInterval) interval {
    modelFieldSetter([DollarValueForInterval createValue:[[textField text] doubleValue] forTimeInterval:interval]);
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

-(void) initYearMonthToggles {
    [super setYearMonthToggleFrame:taxesIntervalField forCorrespondingTextField:taxesField];
    [super setYearMonthToggleFrame:insuranceIntervalField forCorrespondingTextField:insuranceField];
    [super setYearMonthToggleFrame:maintanenceIntervalField forCorrespondingTextField:maintanenceField];
    [super setYearMonthToggleFrame:utilitiesIntervalField forCorrespondingTextField:utilitiesField];
    [super setYearMonthToggleFrame:otherIntervalField forCorrespondingTextField:otherField];
}

-(void) updateEditableFieldsFromModel {
    PropertyInvestment *investment = [self getPropertyInvestment];
    PropertyExpenses *expenses = investment.expenses;
    NSString *decimalFormat = @"%1.2f";
    [taxesField setText:[NSString stringWithFormat:decimalFormat, expenses.taxes.getValue]];
    [insuranceField setText:[NSString stringWithFormat:decimalFormat, expenses.insurance.getValue]];
    [maintanenceField setText:[NSString stringWithFormat:decimalFormat, expenses.maintenance.getValue]];
    [utilitiesField setText:[NSString stringWithFormat:decimalFormat, expenses.utilities.getValue]];
    [vacancyField setText:[NSString stringWithFormat:decimalFormat, expenses.vacancyRate]];
    [otherField setText:[NSString stringWithFormat:decimalFormat, expenses.otherExpenses.getValue]];
}

-(void) updateLabelsFromModel {
    [super labelViewDidChange];
    PropertyInvestment * investment = self.getPropertyInvestment;
    PropertyExpenses * expenses = investment.expenses;

    [monthlyExpensesLabel setText:[expenses.getMonthlyExpenses getCurrencyString]];
    [yearlyExpensesLabel setText:[expenses.getYearlyExpenses getCurrencyString]];
    [vacancyLabel setText:[self stringFromDollarsAndCents:(-1*investment.getVacancyLoss)]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateModelFromTextFields];
    [self updateLabelsFromModel];
}

- (void) updateModelFromTextFields {
    PropertyExpenses * expenses = [self getPropertyInvestment].expenses;
    [expenses setTaxes:[DollarValueForInterval createValue:[taxesField.text doubleValue] forTimeInterval:taxesIntervalField.selectedSegmentIndex]];
    [expenses setInsurance:[DollarValueForInterval createValue:[insuranceField.text doubleValue] forTimeInterval:insuranceIntervalField.selectedSegmentIndex]];
    [expenses setMaintenance:[DollarValueForInterval createValue:[maintanenceField.text doubleValue] forTimeInterval:maintanenceIntervalField.selectedSegmentIndex]];
    [expenses setUtilities:[DollarValueForInterval createValue:[utilitiesField.text doubleValue] forTimeInterval:utilitiesIntervalField.selectedSegmentIndex]];
    [expenses setVacancyRate:[[vacancyField text] doubleValue]];
    [expenses setOtherExpenses:[DollarValueForInterval createValue:[otherField.text doubleValue] forTimeInterval:otherIntervalField.selectedSegmentIndex]];
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
