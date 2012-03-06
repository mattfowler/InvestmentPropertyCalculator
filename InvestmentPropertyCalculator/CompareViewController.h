//
//  CompareView.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> 
@property (nonatomic, retain) IBOutlet UIPickerView *propertyPicker;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIToolbar *doneToolbar;
@property (nonatomic, retain) IBOutlet UIButton *showPropertyPicker;


@property (nonatomic, retain) NSArray* properties;

-(IBAction)chooseProperty:(id)sender;
-(IBAction)doneWithPropertyPicker:(id)sender;

@end
