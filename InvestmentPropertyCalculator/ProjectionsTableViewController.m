//
//  ProjectionsTableViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectionsTableViewController.h"
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"

@interface ProjectionsTableViewController () {
    @private
    double yearlyRentIncrease;
}


@end

@implementation ProjectionsTableViewController

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

static const int MAX_PROJECTION_YEARS = 40;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(void) updateTableWithRentIncrease:(double) rentIncreasePercent {
    yearlyRentIncrease = rentIncreasePercent;
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MAX_PROJECTION_YEARS;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [@"Year " stringByAppendingString:[NSString stringWithFormat:@"%d", section + 1]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }    
    int year = indexPath.section;

    ProjectionType projectionType = indexPath.row;
    PropertyInvestment * investment = [self getPropertyInvestment];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];

    switch (projectionType) {
        case GrossIncome:
            cell.textLabel.text = [@"Gross Income: " stringByAppendingString:[DollarValueForInterval getStringDollarValueFromDouble:[investment.grossIncome getValueAfterYears:year withInflationRate:yearlyRentIncrease andTimeInterval:Year]]];
            break;
        case NetIncome:
            cell.textLabel.text = [@"Net Income: " stringByAppendingString:[DollarValueForInterval getStringDollarValueFromDouble:(double)[investment getNetOperatingIncomeForYear:year withAppreciationRate:.02]]];
            break;
        case PrincipalPaid:
            cell.textLabel.text = [@"Principal Paid: " stringByAppendingString:[DollarValueForInterval getStringDollarValueFromDouble:[investment.mortgage getPrincipalPaidInYear:year]]];
            break;
        case PropertyAppreciation:
            cell.textLabel.text = @"Appreciation: ";
            break;
        case YearlyAddtionToNetWorth:
            cell.textLabel.text = @"Addition to Net: ";
            break;
        case TotalAdditionToNetWorth:
            cell.textLabel.text = @"Total Addition to Net: ";
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    return cell;
}

#pragma mark - Table view delegate

//TODO: maybe the user can click through to a detailed view of the projected data for that year? I'm not sure if I want to do that yet though.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
