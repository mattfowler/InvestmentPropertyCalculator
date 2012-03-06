//
//  CompareView.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompareViewController.h"

@implementation CompareViewController 

@synthesize properties;
@synthesize propertyPicker;
@synthesize showPropertyPicker;
@synthesize scrollView;
@synthesize doneToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    properties=  [[NSArray alloc] initWithObjects:@"15 leyden",@"32 bond", @"455 main", nil];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height + 5);
    propertyPicker.hidden = NO;
    [self.view addSubview:scrollView];
}

-(void) viewDidAppear:(BOOL)animated {
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
    [UIView setAnimationDuration:.5];

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
    [UIView setAnimationDuration:.5];
    
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
    return [properties count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [properties objectAtIndex:row];
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
