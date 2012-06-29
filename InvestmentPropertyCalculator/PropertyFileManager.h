//
//  PropertyFileManager.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyInvestment.h"

@interface PropertyFileManager : NSObject

-(NSArray *) loadProperties;

-(void) saveProperty:(PropertyInvestment *) propertyInvestment;

-(void) deleteProperty:(NSString *)propertyName;

@end
