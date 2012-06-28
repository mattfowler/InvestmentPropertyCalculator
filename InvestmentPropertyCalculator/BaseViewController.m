//
//  BaseToolbarController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "OpenPropertyViewController.h"
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"

@implementation BaseViewController

@synthesize navigationBar;
@synthesize keyboardToolbar;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25];
    
    CGRect frame = self.keyboardToolbar.frame;
    frame.origin.y = self.view.frame.size.height - 211;
    self.keyboardToolbar.frame = frame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25];
    
    CGRect frame = self.keyboardToolbar.frame;
    frame.origin.y = self.view.frame.size.height;
    self.keyboardToolbar.frame = frame;
    
    [UIView commitAnimations];
}

- (IBAction)saveButtonClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter A Property Name" message:@"this is covered" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                          otherButtonTitles:@"Save", nil];   
    
    alertTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
    
    [alertTextField setBackgroundColor:[UIColor whiteColor]];
    [alert addSubview:alertTextField];
    [alert show];
    [alert release];
    [alertTextField release];
}

- (IBAction)openButtonClicked:(id)sender {
    OpenPropertyViewController* openPropertyViewController = [[OpenPropertyViewController alloc] initWithNibName:@"OpenPropertyViewController" bundle:nil];
    openPropertyViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:openPropertyViewController animated:YES];
}

- (void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *dataPath = [documentsPath stringByAppendingPathComponent:alertTextField.text];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];          
        [archiver encodeObject:self.getPropertyInvestment forKey:@"property"];
        [archiver finishEncoding];
        [data writeToFile:dataPath atomically:YES];
        [archiver release];
        [data release];
    }
}

@end
