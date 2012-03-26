//
//  PropertyExpenses.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DollarValueForInterval.h"

@interface PropertyExpenses : NSObject <NSCoding>

@property (nonatomic, retain) DollarValueForInterval* taxes;
@property (nonatomic, retain) DollarValueForInterval* insurance;
@property (nonatomic, retain) DollarValueForInterval* utilities;
@property (nonatomic, retain) DollarValueForInterval* maintainence;
@property double vacancyRate;
@property (nonatomic, retain) DollarValueForInterval* otherExpenses;

-(double) getYearlyExpenses;
-(double) getMonthlyExpenses;

@end
