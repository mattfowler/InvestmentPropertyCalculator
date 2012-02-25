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
@property (nonatomic, retain) NSArray* properties;

@end
