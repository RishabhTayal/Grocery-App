//
//  Customer.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/29/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Customer : NSManagedObject

@property (nonatomic, retain) NSString * customerId;
@property (nonatomic, retain) NSString * cartId;

@end
