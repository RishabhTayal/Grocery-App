//
//  GRWebService.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/28/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRWebService.h"
#import "Customer.h"

@implementation GRWebService

-(void)getCategoriesWithCallback:(GRCompletionBlockGet)callback
{
    [self sendGetRequestURL:kWSURLCategories getDict:nil completion:callback];
    
}

-(void)getProdctsForCategory:(NSString*)categoryId callback:(GRCompletionBlockGet)callback
{
    NSString* urlString = [NSString stringWithFormat:kWSURLGetProductsForCategory, categoryId, @"a"];
    [self sendGetRequestURL:urlString getDict:nil completion:callback];
}

-(void)getProductInfo:(NSString*)productId callback:(GRCompletionBlockGet)callback
{
    NSString* url = [NSString stringWithFormat:kWSURLGetProductInfo, productId];
    [self sendGetRequestURL:url getDict:nil completion:callback];
}

-(void)searchProductsForText:(NSString*)queryText callback:(GRCompletionBlockGet)callback
{
    NSString * urlString = [NSString stringWithFormat:kWSURLSearchProducts, queryText];
    [self sendGetRequestURL:urlString getDict:nil completion:callback];
}

-(void)createCartcallBack:(GRCompletionBlockPost)callback
{
    
    [self sendPostRequestURL:kWSURLCreateCart postDict:nil completion:callback];
    
}

-(void)addToCartCategory:(NSString*)category productId:(NSString*)productId skuId:(NSString*)skuId callback:(GRCompletionBlockPost)callback
{
    Customer* cust = [Customer MR_findFirst];
    NSMutableDictionary* dict;
   
    //Add Item to cart
    dict = [NSMutableDictionary dictionaryWithDictionary:@{@"customer" : @{@"id": cust.customerId}, @"id": cust.cartId}];
    [self sendPostRequestURL:[NSString stringWithFormat:kWSURLAddToCart, category, productId, skuId] postDict:dict completion:^(id result, NSError *error) {
        callback(result, error);
    }];
}

-(void)getCartWithCallback:(GRCompletionBlockGet)callback
{
    NSString* url = kWSURLGetCart;
    Customer* cust = [Customer MR_findFirst];
    NSDictionary* params = @{@"customerId": cust.customerId};
    [self sendGetRequestURL:url getDict:params completion:callback];
}

#pragma mark - Internal Methods

-(void)sendGetRequestURL:(NSString*)urlString getDict:(id)getDict completion:(GRCompletionBlockGet)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    if (getDict != nil) {
        [request setHTTPBody:[self dictToJSON:getDict]];
    }
    request.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSMutableArray* array = nil;
        if (data) {
            array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(array, connectionError);
        });
    }];
}

-(void)sendPostRequestURL:(NSString*)urlString postDict:(id)postDict completion:(GRCompletionBlockPost)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (postDict) {
        [request setHTTPBody:[self dictToJSON:postDict]];
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        DLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        id resultJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultJSON, connectionError);
        });
    }];
}

-(NSData*)dictToJSON:(id)dict
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end
