//
//  GRWebService.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/28/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GRCompletionBlockGet)(NSArray *result, NSError *error);
typedef void (^GRCompletionBlockPost)(id result, NSError* error);

@interface GRWebService : NSObject

-(void)getCategoriesWithCallback:(GRCompletionBlockGet)callback;
-(void)searchProductsForText:(NSString*)queryText callback:(GRCompletionBlockGet)callback;

-(void)addToCart:(NSDictionary*)item callback:(GRCompletionBlockPost)callback;

@end
