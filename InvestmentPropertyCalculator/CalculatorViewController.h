//
//  FirstViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mortgage.h"
#import "PropertyInvestment.h"
#import "BaseCalculatorViewController.h"

@interface CalculatorViewController : BaseCalculatorViewController 

@property (nonatomic, retain) IBOutlet UILabel *downpaymentLabel;
@property (nonatomic, retain) IBOutlet UILabel *netOperatingIncomeLabel;
@property (nonatomic, retain) IBOutlet UILabel *capitalizationRateLabel;
@property (nonatomic, retain) IBOutlet UILabel *cashOnCashReturnLabel;

@property (nonatomic, retain) IBOutlet UITextField *salesPriceField;
@property (nonatomic, retain) IBOutlet UITextField *downpaymentField;
@property (nonatomic, retain) IBOutlet UITextField *taxesField;
@property (nonatomic, retain) IBOutlet UITextField *grossRentField;

- (void) updateDownpaymentLabel;
- (void) updateNetOperatingIncome;

- (IBAction)touchBackground:(id)sender;

@end
