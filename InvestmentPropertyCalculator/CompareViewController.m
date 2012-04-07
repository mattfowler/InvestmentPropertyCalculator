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

@synthesize propertyNames;
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadProperties
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsPath = [paths objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:nil];
    propertyNames = [[NSArray alloc] initWithArray:files];
    properties = [[NSMutableArray alloc] init];
    
    for (NSString* fileName in files) {
        NSString *dataPath = [documentsPath stringByAppendingPathComponent:fileName];
        NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        PropertyInvestment* property = [[unarchiver decodeObjectForKey:@"property"] retain];
        [properties addObject:property];
        [unarchiver finishDecoding];
        [unarchiver release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadProperties];

    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height + 5);
    propertyPicker.hidden = NO;
    [self.view addSubview:scrollView];
}

-(void) viewDidAppear:(BOOL)animated {
    [self loadProperties];
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
    return [propertyNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [propertyNames objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    PropertyInvestment* propertyInvestment = [properties objectAtIndex:row];

    if (component == 0) {
        [firstPropertyNameLabel setText:[propertyNames objectAtIndex:row]];
        [self setLabel:firstPropertyNetOperatingIncome withDollarValue:propertyInvestment.getNetOperatingIncome];
        [self setLabel:firstPropertyExpenses withDollarValue:propertyInvestment.expenses.getYearlyExpenses];
        [self setLabel:firstPropertyCapRate withPercentValue:propertyInvestment.getCapitalizationRate];
        [self setLabel:firstPropertyCashReturn withPercentValue:propertyInvestment.getCashOnCashReturn];
    } else {
        [secondPropertyNameLabel setText:[propertyNames objectAtIndex:row]];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
