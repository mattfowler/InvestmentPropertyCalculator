//
//  ExpensesViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextInputViewController.h"

@interface ExpensesViewController : BaseTextInputViewController

@property (nonatomic, retain) IBOutlet UITextField *taxesField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *taxesIntervalField;

@property (nonatomic, retain) IBOutlet UITextField *insuranceField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *insuranceIntervalField;

@property (nonatomic, retain) IBOutlet UITextField *maintanenceField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *maintanenceIntervalField;

@property (nonatomic, retain) IBOutlet UITextField *utilitiesField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *utilitiesIntervalField;

@property (nonatomic, retain) IBOutlet UITextField *vacancyField;

@property (nonatomic, retain) IBOutlet UITextField *otherField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *otherIntervalField;

@property (nonatomic, retain) IBOutlet UILabel * vacancyLabel;

@property (nonatomic, retain) IBOutlet UILabel *monthlyExpensesLabel;
@property (nonatomic, retain) IBOutlet UILabel *yearlyExpensesLabel;

-(IBAction)touchBackground:(id)sender;

@end
