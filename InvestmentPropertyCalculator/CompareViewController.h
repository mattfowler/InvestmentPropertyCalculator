//
//  CompareView.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CompareViewController : BaseViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) IBOutlet UIPickerView *propertyPicker;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIToolbar *doneToolbar;
@property (nonatomic, retain) IBOutlet UIButton *showPropertyPicker;

@property (nonatomic, retain) IBOutlet UILabel *firstPropertyNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *secondPropertyNameLabel;

@property (nonatomic, retain) IBOutlet UILabel *firstPropertyNetOperatingIncome;
@property (nonatomic, retain) IBOutlet UILabel *secondPropertyNetOperatingIncome;
@property (nonatomic, retain) IBOutlet UILabel *firstPropertyCapRate;
@property (nonatomic, retain) IBOutlet UILabel *secondPropertyCapRate;

@property (nonatomic, retain) IBOutlet UILabel *firstPropertyExpenses;
@property (nonatomic, retain) IBOutlet UILabel *secondPropertyExpenses;

@property (nonatomic, retain) IBOutlet UILabel *firstPropertyCashReturn;
@property (nonatomic, retain) IBOutlet UILabel *secondPropertyCashReturn;

@property (nonatomic, retain) NSArray* propertyNames;
@property (nonatomic, retain) NSMutableArray* properties;

-(IBAction)chooseProperty:(id)sender;
-(IBAction)doneWithPropertyPicker:(id)sender;

@end
