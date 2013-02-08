//
//  OpenPropertyViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenPropertyViewController.h"
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"

@interface OpenPropertyViewController ()

@end

@implementation OpenPropertyViewController 

@synthesize propertyTableView;
@synthesize properties;
@synthesize navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fileManager = [[PropertyFileManager alloc] init];
        [self loadProperties];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadProperties];
    [self.navItem setLeftBarButtonItem:self.editButtonItem];
}

-(IBAction)doneWithView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [propertyTableView setEditing:editing animated:YES];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadProperties {
    properties = [fileManager loadProperties];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [properties count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }    
    PropertyInvestment *propertyInvestment = [properties objectAtIndex:indexPath.row];
    cell.textLabel.text = propertyInvestment.propertyName;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    cell.detailTextLabel.text = [self getPropertyDetailString:propertyInvestment];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [propertyTableView beginUpdates];
    [propertyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    PropertyInvestment *propertyInvestment = [properties objectAtIndex:indexPath.row];
    [fileManager deleteProperty:propertyInvestment.propertyName];
    properties = [fileManager loadProperties];
    [propertyTableView endUpdates];
}

-(NSString*) getPropertyDetailString:(PropertyInvestment*) property {
    double cashReturn = [property getCashOnCashReturn];
    double capRate = [property getCapitalizationRate];
    int nooi = [property getNetOperatingIncome];
    NSString *capRateString = [@" Cap Rate: " stringByAppendingString:[NSString stringWithFormat:@"%1.2f", capRate*100]];
    NSString *cashReturnString = [@" Cash Return: " stringByAppendingString:[NSString stringWithFormat:@"%1.2f", cashReturn*100]];
    NSString *nooiString = [@"NOOI: " stringByAppendingString:[NSString stringWithFormat:@"%d", nooi]];
    return [nooiString stringByAppendingString:[cashReturnString stringByAppendingString:capRateString]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    PropertyInvestment* selectedProperty = [properties objectAtIndex:indexPath.row];
    [self setPropertyInvestment:selectedProperty];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setPropertyInvestment:(PropertyInvestment*) propertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
    investmentDelegate.propertyInvestment = propertyInvestment;
}

@end
