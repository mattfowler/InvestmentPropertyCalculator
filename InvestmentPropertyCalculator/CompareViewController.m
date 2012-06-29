//
//  CompareView.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"
#import "PropertyInvestment.h"

@implementation CompareViewController 

@synthesize properties;
@synthesize propertyPicker;
@synthesize showPropertyPicker;
@synthesize scrollView;
@synthesize doneToolbar;

@synthesize firstPropertyNameLabel;
@synthesize firstPropertyNetOperatingIncome;
@synthesize firstPropertyCashReturn;
@synthesize firstPropertyCapRate;
@synthesize firstPropertyExpenses;

@synthesize secondPropertyNameLabel;
@synthesize secondPropertyNetOperatingIncome;
@synthesize secondPropertyCashReturn;
@synthesize secondPropertyCapRate;
@synthesize secondPropertyExpenses;

- (void)viewDidLoad {
    [super viewDidLoad];
    properties = [fileManager loadProperties];

    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height + 5);
    propertyPicker.hidden = NO;
    [self.view addSubview:scrollView];
}

-(void) viewDidAppear:(BOOL)animated {
    properties = [fileManager loadProperties];
    [propertyPicker reloadAllComponents];
}

-(IBAction) chooseProperty:(id)sender {
    CGRect pickerFrame = propertyPicker.frame;
    pickerFrame.origin.y -= propertyPicker.frame.size.height;
    CGRect scrollViewFrame = scrollView.frame;
    scrollViewFrame.size.height -= propertyPicker.frame.size.height;
    CGRect toolbarFrame = doneToolbar.frame;
    toolbarFrame.origin.y -= propertyPicker.frame.size.height + toolbarFrame.size.height;
    [self.view bringSubviewToFront:doneToolbar];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.3];

    [scrollView setFrame:scrollViewFrame];
    [propertyPicker setFrame:pickerFrame];
    [doneToolbar setFrame:toolbarFrame];
    [UIView commitAnimations];
}

-(IBAction)doneWithPropertyPicker:(id)sender {
    CGRect pickerFrame = propertyPicker.frame;
    pickerFrame.origin.y += propertyPicker.frame.size.height;
    CGRect scrollViewFrame = scrollView.frame;
    scrollViewFrame.size.height += propertyPicker.frame.size.height;
    CGRect toolbarFrame = doneToolbar.frame;
    toolbarFrame.origin.y += propertyPicker.frame.size.height + toolbarFrame.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.3];
    
    [scrollView setFrame:scrollViewFrame];
    [propertyPicker setFrame:pickerFrame];
    [doneToolbar setFrame:toolbarFrame];
    [UIView commitAnimations];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [properties count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    PropertyInvestment *propertyInvestment = [properties objectAtIndex:row];
    return propertyInvestment.propertyName;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    PropertyInvestment* propertyInvestment = [properties objectAtIndex:row];

    if (component == 0) {
        [firstPropertyNameLabel setText:propertyInvestment.propertyName];
        [self setLabel:firstPropertyNetOperatingIncome withDollarValue:propertyInvestment.getNetOperatingIncome];
        [self setLabel:firstPropertyExpenses withDollarValue:propertyInvestment.expenses.getYearlyExpenses];
        [self setLabel:firstPropertyCapRate withPercentValue:propertyInvestment.getCapitalizationRate];
        [self setLabel:firstPropertyCashReturn withPercentValue:propertyInvestment.getCashOnCashReturn];
    } else {
        [secondPropertyNameLabel setText:propertyInvestment.propertyName];
        [self setLabel:secondPropertyNetOperatingIncome withDollarValue:propertyInvestment.getNetOperatingIncome];
        [self setLabel:secondPropertyExpenses withDollarValue:propertyInvestment.expenses.getYearlyExpenses];
        [self setLabel:secondPropertyCapRate withPercentValue:propertyInvestment.getCapitalizationRate];
        [self setLabel:secondPropertyCashReturn withPercentValue:propertyInvestment.getCashOnCashReturn];
    }
}

-(void) setLabel:(UILabel*) label withDollarValue:(int) value {
    NSNumberFormatter* dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [label setText:[dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:value]]];
}

-(void) setLabel:(UILabel*) label withPercentValue:(double)value {
    NSNumberFormatter* percentFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [percentFormatter setNumberStyle: NSNumberFormatterPercentStyle];
    [label setText:[percentFormatter stringFromNumber:[NSNumber numberWithDouble:value]]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
