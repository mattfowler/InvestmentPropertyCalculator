//
//  PropertyExpenses.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyExpenses : NSObject <NSCoding>

@property double taxes;
@property double insurance;
@property double utilities;
@property double maintainence;
@property double vacancyRate;
@property double otherExpenses;

-(double) getMonthlyExpenses;
-(double) getYearlyExpenses;

@end
