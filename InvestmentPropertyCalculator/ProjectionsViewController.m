//
//  ProjectionsViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectionsViewController.h"
#import "ProjectionsTableViewController.h"

@implementation ProjectionsViewController

@synthesize projectionsTableView;
@synthesize rentIncreaseField;
@synthesize propertyAppreciationField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    projectionsTableViewController = [[ProjectionsTableViewController alloc] init];
    projectionsTableView.delegate = projectionsTableViewController;
    projectionsTableView.dataSource = projectionsTableViewController;
    
    [rentIncreaseField setDelegate:self];
    [propertyAppreciationField setDelegate:self];
    rentIncreaseField.keyboardType = UIKeyboardTypeDecimalPad;
    propertyAppreciationField.keyboardType = UIKeyboardTypeDecimalPad;
    [self updateProjectionsTable];
}

-(void)touchBackground:(id)sender {
    [rentIncreaseField resignFirstResponder];
    [propertyAppreciationField resignFirstResponder];
}

- (void) updateProjectionsTable {
    double rentIncrease = [rentIncreaseField.text doubleValue] / 100;
    double propertyAppreciation = [propertyAppreciationField.text doubleValue] / 100;
    [projectionsTableViewController updateTableWithRentIncrease:rentIncrease andAppreciationRate:propertyAppreciation];
    [projectionsTableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateProjectionsTable];
}

- (void) viewDidAppear:(BOOL)animated {
    [projectionsTableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [projectionsTableView release];
    [projectionsTableViewController release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
