//
//  ExpensesViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpensesViewController.h"

@implementation ExpensesViewController

@synthesize taxesField;
@synthesize insuranceField;
@synthesize maintanenceField;
@synthesize utilitiesField;
@synthesize vacancyField;
@synthesize otherField;

- (void)viewDidLoad {
    [super viewDidLoad];
    super.entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 75);
    [self initTextFields];
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
