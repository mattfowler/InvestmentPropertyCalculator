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
    isCurrentPropertySelectedForFirstColumn = YES;
    isCurrentPropertySelectedForSecondColumn = YES;
    [self.view addSubview:scrollView];
}

-(void) viewDidAppear:(BOOL)animated {
    properties = [fileManager loadProperties];
    [propertyPicker reloadAllComponents];
    if (isCurrentPropertySelectedForFirstColumn) {
        [self updatePropertyLabelsForFirstColumn:[super getPropertyInvestment]];
    }
    if (isCurrentPropertySelectedForSecondColumn) {
        [self updatePropertyLabelsForSecondColumn:[super getPropertyInvestment]];
    }
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
    [showPropertyPicker setHidden:YES];
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
    [showPropertyPicker setHidden:NO];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [properties count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"Current Property";
    }
    PropertyInvestment *propertyInvestment = [properties objectAtIndex:row-1];
    return propertyInvestment.propertyName;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (id)view;
    if (!label) {
        label= [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width - 10, [pickerView rowSizeForComponent:component].height)] autorelease];
        [label setBackgroundColor:[UIColor clearColor]];
        label.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    }
    
    if (row == 0) {
        label.textColor = [UIColor blueColor]; 
        label.text = @"Current Property";
    } else {
        PropertyInvestment *propertyInvestment = [properties objectAtIndex:row-1];
        label.text = propertyInvestment.propertyName;
    }
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    PropertyInvestment* propertyInvestment;
    if (row == 0) {
        propertyInvestment = [super getPropertyInvestment];
        if(component == 0) {
            isCurrentPropertySelectedForFirstColumn = YES;
        } else {
            isCurrentPropertySelectedForSecondColumn = YES;
        }
    }
    else {
        propertyInvestment = [properties objectAtIndex:row-1];
        if(component == 0) {
            isCurrentPropertySelectedForFirstColumn = NO;
        } else {
            isCurrentPropertySelectedForSecondColumn = NO;
        }
    }
    
    if (component == 0) {
        [self updatePropertyLabelsForFirstColumn:propertyInvestment];
    } else {
        [self updatePropertyLabelsForSecondColumn:propertyInvestment];
    }
}

-(void) updatePropertyLabelsForFirstColumn:(PropertyInvestment *) propertyInvestment {
    [firstPropertyNameLabel setText:propertyInvestment.propertyName];
    [self setLabel:firstPropertyNetOperatingIncome withDollarValue:propertyInvestment.getNetOperatingIncome];
    [self setLabel:firstPropertyExpenses withDollarValue:propertyInvestment.expenses.getYearlyExpenses];
    [self setLabel:firstPropertyCapRate withPercentValue:propertyInvestment.getCapitalizationRate];
    [self setLabel:firstPropertyCashReturn withPercentValue:propertyInvestment.getCashOnCashReturn];
}

-(void) updatePropertyLabelsForSecondColumn:(PropertyInvestment *) propertyInvestment {
    [secondPropertyNameLabel setText:propertyInvestment.propertyName];
    [self setLabel:secondPropertyNetOperatingIncome withDollarValue:propertyInvestment.getNetOperatingIncome];
    [self setLabel:secondPropertyExpenses withDollarValue:propertyInvestment.expenses.getYearlyExpenses];
    [self setLabel:secondPropertyCapRate withPercentValue:propertyInvestment.getCapitalizationRate];
    [self setLabel:secondPropertyCashReturn withPercentValue:propertyInvestment.getCashOnCashReturn];
}

-(void) setLabel:(UILabel*) label withDollarValue:(int) value {
    NSNumberFormatter* dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [label setText:[dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:value]]];
}

-(void) setLabel:(UILabel*) label withPercentValue:(double) value {
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
