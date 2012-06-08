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
@synthesize propertyNames;
@synthesize navItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self dismissModalViewControllerAnimated:YES];
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [propertyTableView setEditing:editing animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString*)getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    return [paths objectAtIndex:0];
}

- (void)loadProperties
{
    NSString *documentsPath = [self getDocumentPath];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:nil];
    propertyNames = [[NSMutableArray alloc] initWithArray:files];
    properties = [[NSMutableArray alloc] init];
    
    for (NSString *fileName in files) {
        NSString *dataPath = [documentsPath stringByAppendingPathComponent:fileName];
        NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        PropertyInvestment* property = [unarchiver decodeObjectForKey:@"property"];
        [properties addObject:property];
        [unarchiver finishDecoding];
        [unarchiver release];
    }
}

- (void)deleteProperty:(NSString*) propertyName {
    NSString *documentsPath = [self getDocumentPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[documentsPath stringByAppendingPathComponent:propertyName] error:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [propertyNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }    
    cell.textLabel.text = [propertyNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    cell.detailTextLabel.text = [self getPropertyDetailString:[properties objectAtIndex:indexPath.row]];
    return cell;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [propertyTableView beginUpdates];
    [propertyTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self deleteProperty:[propertyNames objectAtIndex:indexPath.row]];
    [propertyNames removeObjectAtIndex:indexPath.row];
    [properties removeObjectAtIndex:indexPath.row];
    [propertyTableView endUpdates];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    PropertyInvestment* selectedProperty = [properties objectAtIndex:indexPath.row];
    [self setPropertyInvestment:selectedProperty];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) setPropertyInvestment:(PropertyInvestment*) propertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
    investmentDelegate.propertyInvestment = propertyInvestment;
}

@end
