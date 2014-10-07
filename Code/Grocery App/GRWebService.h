//
//  GRWebService.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/28/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GRCompletionBlockGet)(id result, NSError *error);
typedef void (^GRCompletionBlockPost)(id result, NSError* error);
typedef void (^GRCompletionBlockDelete)(id result, NSError* error);

@interface GRWebService : NSObject

-(void)getCategoriesWithCallback:(GRCompletionBlockGet)callback;
-(void)getProdctsForCategory:(NSString*)categoryId callback:(GRCompletionBlockGet)callback;
-(void)getProductInfo:(NSString*)productId callback:(GRCompletionBlockGet)callback;
-(void)searchProductsForText:(NSString*)queryText callback:(GRCompletionBlockGet)callback;

-(void)createCartcallBack:(GRCompletionBlockPost)callback;
-(void)addToCartCategory:(NSString*)category productId:(NSString*)productId skuId:(NSString*)skuId callback:(GRCompletionBlockPost)callback;
-(void)getCartWithCallback:(GRCompletionBlockGet)callback;
-(void)deleteItemFromCart:(NSString*)itemId callBack:(GRCompletionBlockDelete)callback;


-(void)getMediaListForProduct:(NSString*)productId callback:(GRCompletionBlockGet)callback;

@end
