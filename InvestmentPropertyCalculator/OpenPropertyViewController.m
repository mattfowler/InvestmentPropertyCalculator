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
}

-(IBAction)doneWithView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [properties count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }    
    cell.textLabel.text = [propertyNames objectAtIndex:indexPath.row];
    return cell;
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
