//
//  GRWebService.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/28/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRWebService : NSObject

-(void)getCategoriesWithCallback:(void (^) (NSArray* result, NSError* error))callback;
-(void)searchProductsForText:(NSString*)queryText callback:(void (^)(NSArray *result, NSError *error))callback;

@end
