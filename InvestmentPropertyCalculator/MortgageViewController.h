//
//  SecondViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCalculatorViewController.h"

@interface MortgageViewController : BaseCalculatorViewController 

@property (nonatomic, retain) IBOutlet UILabel *downpaymentLabel;

@property (nonatomic, retain) IBOutlet UITextField *salesPriceField;
@property (nonatomic, retain) IBOutlet UITextField *downpaymentField;
@property (nonatomic, retain) IBOutlet UITextField *interestRateField;
@property (nonatomic, retain) IBOutlet UITextField *mortgageTermField;

@property (nonatomic, retain) IBOutlet UILabel *netOperatingIncome;
@property (nonatomic, retain) IBOutlet UILabel *mortgagePayment;
@property (nonatomic, retain) IBOutlet UILabel *totalInterestPaid;

- (IBAction)touchBackground:(id)sender;

@end
