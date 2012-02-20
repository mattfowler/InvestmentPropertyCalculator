//
//  PropertyInvestment.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyInvestment.h"

@implementation PropertyInvestment

@synthesize mortgage;
@synthesize expenses;
@synthesize grossIncome;

-(int) getNetOperatingIncome {
    return grossIncome - mortgage.getMonthlyPayment * 12 - expenses.getMonthlyExpenses * 12;
}

-(double) getCapitalizationRate {
    return ((double)self.getNetOperatingIncome / (double)mortgage.salesPrice);
}

-(double) getCashOnCashReturn {
    return (double) self.getNetOperatingIncome / (double) mortgage.getDownpaymentAmount;
}

@end
