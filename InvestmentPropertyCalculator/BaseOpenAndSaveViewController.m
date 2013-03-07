//
//  BaseToolbarController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseOpenAndSaveViewController.h"
#import "OpenPropertyViewController.h"
#import "PropertyInvestment.h"
#import "PropertyInvestmentProtocol.h"

@implementation BaseOpenAndSaveViewController

@synthesize navigationBar;
@synthesize keyboardToolbar;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

- (void) viewDidLoad {
    self.navigationBar.topItem.title = @"Unsaved Property";
    fileManager = [[PropertyFileManager alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
}

- (IBAction)openButtonClicked:(id)sender {
    OpenPropertyViewController* openPropertyViewController = [[OpenPropertyViewController alloc] initWithNibName:@"OpenPropertyViewController" bundle:nil];
    openPropertyViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:openPropertyViewController animated:YES completion:nil];
}

- (void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *propertyName = alertTextField.text;
        PropertyInvestment *propertyInvestment = self.getPropertyInvestment;
        propertyInvestment.propertyName = propertyName;
        [fileManager saveProperty:propertyInvestment];
    }
}


@end
