//
//  FirstViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mortgage.h"

@interface CalculatorViewController : UIViewController <UITextFieldDelegate> {
    @private
    NSNumberFormatter *dollarsAndCentsFormatter;
    Mortgage *mortgage; //TODO: the mortgage tab will contain this!
}

@property (nonatomic, retain) IBOutlet UILabel *downpaymentLabel;
@property (nonatomic, retain) IBOutlet UILabel *netOperatingIncomeLabel;
@property (nonatomic, retain) IBOutlet UILabel *capitalizationRateLabel;
@property (nonatomic, retain) IBOutlet UILabel *cashOnCashReturnLabel;

@property (nonatomic, retain) IBOutlet UITextField *salesPriceField;
@property (nonatomic, retain) IBOutlet UITextField *downpaymentField;
@property (nonatomic, retain) IBOutlet UITextField *grossRentField;

- (void) updateDownpaymentLabel;
- (void) updateNetOperatingIncome;

@end
