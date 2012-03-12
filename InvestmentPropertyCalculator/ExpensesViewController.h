//
//  ExpensesViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCalculatorViewController.h"

@interface ExpensesViewController : BaseCalculatorViewController

@property (nonatomic, retain) IBOutlet UITextField *taxesField;
@property (nonatomic, retain) IBOutlet UITextField *insuranceField;
@property (nonatomic, retain) IBOutlet UITextField *maintanenceField;
@property (nonatomic, retain) IBOutlet UITextField *utilitiesField;
@property (nonatomic, retain) IBOutlet UITextField *vacancyField;
@property (nonatomic, retain) IBOutlet UITextField *otherField;

@end
