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
    [self sendGetRequestURL:kWSURLCategories completion:callback];
}

-(void)searchProductsForText:(NSString*)queryText callback:(GRCompletionBlockGet)callback
{
    NSString * urlString = [NSString stringWithFormat:kWSURLSearchProducts, queryText];
    [self sendGetRequestURL:urlString completion:callback];
}

//-(void)createCartcallBack:(GRCompletionBlockPost)callback
//{
//}

-(void)addToCart:(NSDictionary *)item callback:(GRCompletionBlockPost)callback
{
    Customer* cust = [Customer MR_findFirst];
    NSMutableDictionary* dict;
    if (cust == nil) {
        DLog(@"%@", cust);
        
        //Create new cart
        dict = [NSMutableDictionary dictionaryWithDictionary:@{@"customer" : @{@"id": cust.customerId}, @"id": cust.cartId}];
        [self sendPostRequestURL:kWSURLCreateCart postDict:dict completion:^(id result, NSError *error) {
            if (cust == nil) {
                Customer* newCustomer = [Customer MR_createEntity];
                newCustomer.customerId = [NSString stringWithFormat:@"%@", result[@"customer"][@"id"]];
                newCustomer.cartId = [NSString stringWithFormat:@"%@", result[@"id"]];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
            }
            callback(result, error);
        }];
    }

    //Add Item to cart
    dict = [NSMutableDictionary dictionaryWithDictionary:@{@"customer" : @{@"id": cust.customerId}, @"id": cust.cartId}];
    [self sendPostRequestURL:[NSString stringWithFormat:kWSURLAddToCart, @"", @"", @""] postDict:dict completion:^(id result, NSError *error) {
        callback(result, error);
    }];
}

#pragma mark - Internal Methods

-(void)sendGetRequestURL:(NSString*)urlString completion:(GRCompletionBlockGet)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(array, nil);
        });
    }];
}

-(void)sendPostRequestURL:(NSString*)urlString postDict:(id)postDict completion:(GRCompletionBlockPost)completion
{
    NSURL* url = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[self dictToJSON:postDict]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        DLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
        id resultJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(resultJSON, nil);
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
