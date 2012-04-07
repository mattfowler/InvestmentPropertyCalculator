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

- (void)viewDidLoad
{
    [super viewDidLoad];
    projectionsTableViewController = [[ProjectionsTableViewController alloc] init];
    projectionsTableView.delegate = projectionsTableViewController;
    projectionsTableView.dataSource = projectionsTableViewController;
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
