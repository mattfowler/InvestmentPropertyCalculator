//
//  PropertyExpenses.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyExpenses : NSObject

@property double taxes;
@property double insurance;
@property double utilities;
@property double maintainence;
@property double vacancyRate;

-(double) getMonthlyExpenses;

@end
