//
//  PropertyInvestment.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mortgage.h"
#import "PropertyExpenses.h"

@interface PropertyInvestment : NSObject <NSCoding>

@property (nonatomic, retain) Mortgage *mortgage;
@property (nonatomic, retain) PropertyExpenses *expenses;

@property (nonatomic, retain) DollarValueForInterval* grossIncome;
@property double taxBracket;

-(int) getNetOperatingIncome; 
-(double) getCapitalizationRate;
-(double) getCashOnCashReturn;
-(double) getVacancyLoss;

-(int) getAfterTaxCashFlow;
-(double) getTaxDeductibleExpenseAmountForYear:(int)year withInflationRate:(double)rate;
-(double) getPropertyDepreciatonForYear:(int)year;

@end
