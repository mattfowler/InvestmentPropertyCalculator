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

- (void)viewDidLoad
{
    [super viewDidLoad];
    projectionsTableViewController = [[ProjectionsTableViewController alloc] init];
    projectionsTableView.delegate = projectionsTableViewController;
    projectionsTableView.dataSource = projectionsTableViewController;
    
    [rentIncreaseField setDelegate:self];
    rentIncreaseField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
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
