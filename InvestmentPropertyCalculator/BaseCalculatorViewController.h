//
//  BaseCalculatorViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "PropertyInvestment.h"

@interface BaseCalculatorViewController : UIViewController <UITextFieldDelegate> {
    @private
    CGFloat animatedDistance;
    
    @protected
    NSNumberFormatter *dollarsAndCentsFormatter;
    NSNumberFormatter *percentFormatter;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIView *labelView;
@property (nonatomic, retain) IBOutlet UIScrollView *entryScrollView;

- (PropertyInvestment *) getPropertyInvestment;

- (NSString*) stringFromPercent:(double)percent;

- (NSString*) stringFromDollarsAndCents:(double)dollarsAndCents;


@end
