//
//  OpenPropertyViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyFileManager.h"

@interface OpenPropertyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    @private
    PropertyFileManager *fileManager;
}

@property (nonatomic, retain) NSArray* properties;
@property (nonatomic, retain) IBOutlet UITableView* propertyTableView;
@property (nonatomic, retain) IBOutlet UINavigationItem* navItem;

-(IBAction)doneWithView:(id)sender;

@end
