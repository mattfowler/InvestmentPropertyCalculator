    //
//  BaseCalculatorViewController.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseTextInputViewController.h"
#import "PropertyInvestmentProtocol.h"
#import "OpenPropertyViewController.h"

@implementation BaseTextInputViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
static const CGFloat NAVIGATON_BAR_HEIGHT = 25;

@synthesize navigationBar;
@synthesize labelView;
@synthesize entryScrollView;
@synthesize keyboardToolbar;
@synthesize netOperatingIncomeLabel;
@synthesize afterTaxCashFlowLabel;

-(NSString*) stringFromPercent:(double)percent {
    return [percentFormatter stringFromNumber:[NSNumber numberWithDouble:percent]];
}

-(NSString*) stringFromDollarsAndCents:(double)dollarsAndCents {
    return [dollarsAndCentsFormatter stringFromNumber:[NSNumber numberWithDouble:dollarsAndCents]];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 5);

    [self createFormatters];
}

- (void) labelViewDidChange {
    [netOperatingIncomeLabel setText:[self stringFromDollarsAndCents:self.getPropertyInvestment.getNetOperatingIncome]];
    [afterTaxCashFlowLabel setText:[self stringFromDollarsAndCents:self.getPropertyInvestment.getAfterTaxCashFlow]];
}

- (void) createFormatters {
    dollarsAndCentsFormatter = [[[NSNumberFormatter alloc] init] retain];
    [dollarsAndCentsFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    percentFormatter = [[[NSNumberFormatter alloc] init] retain];
    [percentFormatter setNumberStyle: NSNumberFormatterPercentStyle];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //CGRect textFieldRect = [self.entryScrollView convertRect:textField.bounds fromView:textField];
   
    CGRect labelViewFrame = labelView.frame;
    labelViewFrame.origin.y = -labelView.frame.size.height; 
    
    CGRect scrollViewFrame = self.entryScrollView.frame;
    scrollViewFrame.size.height = self.view.frame.size.height - PORTRAIT_KEYBOARD_HEIGHT + 5;
    scrollViewFrame.origin.y = 0;
    
    CGRect navigationBarFrame = navigationBar.frame;
    navigationBarFrame.origin.y = -navigationBarFrame.size.height;

    //TODO: figure out a way to place text fields appropriatley
    //CGFloat textFieldOffset = textFieldRect.origin.y - textFieldRect.size.height/2;
    //entryScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.entryScrollView.frame.size.height + 25);
    //[entryScrollView setContentOffset:CGPointMake(entryScrollView.contentOffset.x,  (textFieldRect.origin.y - 55)) animated:YES];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];

    [labelView setFrame:labelViewFrame];
    [entryScrollView setFrame:scrollViewFrame];
    [navigationBar setFrame:navigationBarFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[self dismissModalViewControllerAnimated:YES];
    
    CGRect navigationBarFrame = navigationBar.frame;
    navigationBarFrame.origin.y = 0;
    
    CGRect labelViewFrame = labelView.frame;
    labelViewFrame.origin.y = self.navigationBar.frame.size.height;
    
    CGRect viewFrame = self.entryScrollView.frame;
    viewFrame.size.height = self.view.frame.size.height - (labelViewFrame.size.height + navigationBar.frame.size.height);
    viewFrame.origin.y = labelViewFrame.origin.y + labelViewFrame.size.height;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [entryScrollView setFrame:viewFrame];
    [labelView setFrame:labelViewFrame];
    [navigationBar setFrame:navigationBarFrame];
    
    [UIView commitAnimations];
}

@end
