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

@property (nonatomic, retain) NSString *propertyName;
@property (nonatomic, retain) Mortgage *mortgage;
@property (nonatomic, retain) PropertyExpenses *expenses;

@property (nonatomic, retain) DollarValueForInterval* grossIncome;
@property double taxBracket;

-(DollarValue*) getNetOperatingIncome;
-(int) getNetOperatingIncomeForYear:(int) year withAppreciationRate:(double) rate;

-(double) getCapitalizationRate;
-(double) getCashOnCashReturn;
-(DollarValue *) getVacancyLoss;

-(DollarValue *) getAfterTaxCashFlow;
-(DollarValue *) getTaxDeductibleExpenseAmountForYear:(int)year withAppreciationRate:(double)rate;
-(DollarValue *) getPropertyDepreciationForYear:(int)year;
-(double) getPropertyAppreciationForYear:(int)year withAppreciationRate:(double)rate;
-(double) getAdditionToNetWorthAfterYear:(int)year withRentIncrease:(double)rentIncrease andPropertyAppreciationRate:(double)propertyAppreciationRate;
@end
