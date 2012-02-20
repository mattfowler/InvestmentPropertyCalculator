//
//  PropertyExpenses.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyExpenses.h"

@implementation PropertyExpenses

@synthesize taxes;
@synthesize insurance;
@synthesize utilities;
@synthesize maintainence;
@synthesize vacancyRate;

-(double) getMonthlyExpenses {
    return taxes + insurance + utilities + maintainence;
}

@end
