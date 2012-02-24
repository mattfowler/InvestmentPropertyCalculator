//
//  SecondViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MortgageViewController : UIViewController <UITextFieldDelegate> {
@private
    CGFloat animatedDistance;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIView *labelView;
@property (nonatomic, retain) IBOutlet UIScrollView *entryScrollView;

@property (nonatomic, retain) IBOutlet UITextField *salesPriceField;
@property (nonatomic, retain) IBOutlet UITextField *downpaymentField;
@property (nonatomic, retain) IBOutlet UITextField *interestRateField;
@property (nonatomic, retain) IBOutlet UITextField *mortgageTermField;

@end
