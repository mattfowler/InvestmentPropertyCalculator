//
//  BaseCalculatorViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseCalculatorViewController.h"
#import "PropertyInvestmentProtocol.h"

@implementation BaseCalculatorViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize navigationBar;
@synthesize labelView;
@synthesize entryScrollView;

- (PropertyInvestment *) getPropertyInvestment {
    id<PropertyInvestmentProtocol> investmentDelegate = (id<PropertyInvestmentProtocol>) [UIApplication sharedApplication].delegate;
	PropertyInvestment* propertyInvestment = (PropertyInvestment*) investmentDelegate.propertyInvestment;
	return propertyInvestment;
}

-(void) viewDidLoad {
    entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 5);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.entryScrollView convertRect:textField.bounds fromView:textField];
    
    CGRect viewFrame = self.entryScrollView.frame;
    animatedDistance = self.view.frame.size.height - PORTRAIT_KEYBOARD_HEIGHT - navigationBar.frame.size.height + 15;
    viewFrame.size.height -= animatedDistance;
    
    CGFloat textFieldOffset = entryScrollView.contentOffset.y + textFieldRect.origin.y - textFieldRect.size.height/2 - 15;
    [entryScrollView setContentOffset:CGPointMake(entryScrollView.contentOffset.x, textFieldOffset)  animated:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.entryScrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self dismissModalViewControllerAnimated:YES];
    
    CGRect viewFrame = self.entryScrollView.frame;
    viewFrame.size.height += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.entryScrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

@end
