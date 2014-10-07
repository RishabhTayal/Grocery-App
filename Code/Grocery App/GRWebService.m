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
    [self sendGetRequestURL:kWSURLCategories httpBody:nil httpHeader:nil completion:callback];
}

-(void)getProdctsForCategory:(NSString*)categoryId callback:(GRCompletionBlockGet)callback
{
    NSString* urlString = [NSString stringWithFormat:kWSURLGetProductsForCategory, categoryId, @"a"];
    [self sendGetRequestURL:urlString httpBody:nil httpHeader:nil completion:callback];
}

-(void)getProductInfo:(NSString*)productId callback:(GRCompletionBlockGet)callback
{
    NSString* url = [NSString stringWithFormat:kWSURLGetProductInfo, productId];
    [self sendGetRequestURL:url httpBody:nil httpHeader:nil completion:callback];
}

-(void)searchProductsForText:(NSString*)queryText callback:(GRCompletionBlockGet)callback
{
    NSString * urlString = [NSString stringWithFormat:kWSURLSearchProducts, queryText];
    [self sendGetRequestURL:urlString httpBody:nil httpHeader:nil completion:callback];
}

#pragma mark - Cart

-(void)createCartcallBack:(GRCompletionBlockPost)callback
{
    [self sendPostRequestURL:kWSURLCreateCart httpBody:nil httpHeader:nil completion:callback];
}

-(void)addToCartCategory:(NSString*)category productId:(NSString*)productId skuId:(NSString*)skuId callback:(GRCompletionBlockPost)callback
{
    Customer* cust = [Customer MR_findFirst];
    NSMutableDictionary* dict;
   
    //Add Item to cart
    dict = [NSMutableDictionary dictionaryWithDictionary:@{@"customerId" : cust.customerId}];
    [self sendPostRequestURL:[NSString stringWithFormat:kWSURLAddToCart, productId,category] httpBody:nil httpHeader:dict completion:callback];
}

-(void)getCartWithCallback:(GRCompletionBlockGet)callback
{
    NSString* url = kWSURLGetCart;
    Customer* cust = [Customer MR_findFirst];
    NSDictionary* params = @{@"customerId": cust.customerId};
    [self sendGetRequestURL:url httpBody:nil httpHeader:params completion:callback];
}

-(void)deleteItemFromCart:(NSString*)itemId callBack:(GRCompletionBlockDelete)callback
{
    Customer* cust = [Customer MR_findFirst];
    NSDictionary* dict = @{@"customerId": cust.customerId};
    [self sendDeleteRequestURL:[NSString stringWithFormat:kWSURLCartDelete, itemId] httpHeader:dict completion:callback];
}

-(void)getMediaListForProduct:(NSString*)productId callback:(GRCompletionBlockGet)callback
{
    [self sendGetRequestURL:[NSString stringWithFormat:kWSURLGetMediaList, productId] httpBody:nil httpHeader:nil completion:callback];
}

#pragma mark - Internal Methods

-(void)sendGetRequestURL:(NSString*)urlString httpBody:(id)httpBody httpHeader:(id)httpHeader completion:(GRCompletionBlockGet)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    if (httpBody != nil) {
        [request setHTTPBody:[self dictToJSON:httpBody]];
    }
    if (httpHeader) {
        for (NSString* key in httpHeader) {
            [request addValue:httpHeader[key] forHTTPHeaderField:key];
        }
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

-(void)sendPostRequestURL:(NSString*)urlString httpBody:(id)httpBody httpHeader:(id)httpHeader completion:(GRCompletionBlockPost)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (httpBody) {
        [request setHTTPBody:[self dictToJSON:httpBody]];
    }
    
    if (httpHeader) {
        for (NSString* key in httpHeader) {
            [request addValue:httpHeader[key] forHTTPHeaderField:key];
        }
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        DLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        id resultJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultJSON, connectionError);
        });
    }];
}

-(void)sendDeleteRequestURL:(NSString*)urlString httpHeader:(id)httpHeader completion:(GRCompletionBlockDelete)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"DELETE";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (httpHeader) {
        for (NSString* key in httpHeader) {
            [request addValue:httpHeader[key] forHTTPHeaderField:key];
        }
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id resultJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultJson, connectionError);
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
