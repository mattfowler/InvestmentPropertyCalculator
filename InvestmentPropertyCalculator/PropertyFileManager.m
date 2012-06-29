//
//  PropertyFileManager.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyFileManager.h"

@implementation PropertyFileManager

-(NSArray *) loadProperties {
    NSString *documentsPath = [self getDocumentsPath];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:nil];    
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    
    for (NSString *fileName in files) {
        NSString *dataPath = [documentsPath stringByAppendingPathComponent:fileName];
        NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        PropertyInvestment* property = [unarchiver decodeObjectForKey:@"property"];
        [properties addObject:property];
        [unarchiver finishDecoding];
        [unarchiver release];
    }
    
    return [[NSArray alloc] initWithArray:properties];
}

-(void) saveProperty:(PropertyInvestment *) propertyInvestment {
    NSString *dataPath = [[self getDocumentsPath] stringByAppendingPathComponent:propertyInvestment.propertyName];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:propertyInvestment forKey:@"property"];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
    [archiver release];
    [data release];
}

-(void) deleteProperty:(NSString *)propertyName {
    NSString *documentsPath = [self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[documentsPath stringByAppendingPathComponent:propertyName] error:nil];
}

- (NSString*) getDocumentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    return [paths objectAtIndex:0];
}

@end
