//
//  GRWebService.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/28/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRWebService.h"

@implementation GRWebService

-(void)getCategoriesWithCallback:(void (^)(NSArray *, NSError *))callback
{
    [self sendAsynchronousRequestURL:[NSString stringWithFormat:@"%@%@", kWSURLBase, kWSURLCategories] completion:callback];
}

-(void)searchProductsForText:(NSString*)queryText callback:(void (^)(NSArray *, NSError *))callback
{
    NSString* urlString = [NSString stringWithFormat:@"%@%@?q=%@", kWSURLBase, kWSURLSearchProducts, queryText];
    [self sendAsynchronousRequestURL:urlString completion:callback];
}

-(void)sendAsynchronousRequestURL:(NSString*)urlString completion:(void (^) (NSArray* result, NSError* error))completion
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

@end
