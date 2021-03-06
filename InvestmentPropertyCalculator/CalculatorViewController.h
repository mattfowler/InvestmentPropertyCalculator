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
#import "BaseTextInputViewController.h"

@interface CalculatorViewController : BaseTextInputViewController 

@property (nonatomic, retain) IBOutlet UILabel *downpaymentLabel;
@property (nonatomic, retain) IBOutlet UILabel *capitalizationRateLabel;
@property (nonatomic, retain) IBOutlet UILabel *cashOnCashReturnLabel;

@property (nonatomic, retain) IBOutlet UITextField *salesPriceField;
@property (nonatomic, retain) IBOutlet UITextField *downpaymentField;
@property (nonatomic, retain) IBOutlet UITextField *taxBracketField;
@property (nonatomic, retain) IBOutlet UITextField *grossRentField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *grossRentIntervalField;


- (IBAction)touchBackground:(id)sender;

@end
