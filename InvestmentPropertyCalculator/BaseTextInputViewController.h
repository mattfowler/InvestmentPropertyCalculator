//
//  BaseCalculatorViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "PropertyInvestment.h"
#include "BaseOpenAndSaveViewController.h"

@interface BaseTextInputViewController : BaseOpenAndSaveViewController <UITextFieldDelegate> {
    @private
    CGFloat animatedDistance;
    
    @protected
    NSNumberFormatter *dollarsAndCentsFormatter;
    NSNumberFormatter *percentFormatter;
}

@property (nonatomic, retain) IBOutlet UIView *labelView;
@property (nonatomic, retain) IBOutlet UIScrollView *entryScrollView;

@property (nonatomic, retain) IBOutlet UILabel *netOperatingIncomeLabel;
@property (nonatomic, retain) IBOutlet UILabel *afterTaxCashFlowLabel;

- (NSString*) stringFromPercent:(double)percent;

- (NSString*) stringFromDollarsAndCents:(double)dollarsAndCents;

- (void) touchBackground:(id)sender;

- (void) labelViewDidChange;

-(void) setYearMonthToggleFrame:(UISegmentedControl *) toggle forCorrespondingTextField:(UITextField *) textField;

@end
