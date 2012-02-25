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
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIView *labelView;
@property (nonatomic, retain) IBOutlet UIScrollView *entryScrollView;

- (PropertyInvestment *) getPropertyInvestment;

@end
