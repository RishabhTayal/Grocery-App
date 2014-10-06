//
//  Constants.h
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#ifndef Grocery_App_Constants_h
#define Grocery_App_Constants_h

#ifdef DEBUG
#define DEBUGMODE YES
#else
#define DEBUGMODE NO
#endif

#ifndef DLog
#ifdef DEBUG
#define DLog(_format_, ...) NSLog(_format_, ## __VA_ARGS__)
#else
#define DLog(_format_, ...)
#endif
#endif

/**
 *  User Defaults
 */

#define kUDUserLoggedIn @"userLoggedIn"


/**
 *  Webservice API URL
 */

#define kProductImageUrlPrefix @"http://sife-env.elasticbeanstalk.com"

#define kWSURLBase @"http://sife-env.elasticbeanstalk.com/api/v1/"

#define kWSURLCategories [NSString stringWithFormat:@"%@%@", kWSURLBase, @"catalog/categories"]
#define kWSURLGetProductsForCategory [NSString stringWithFormat:@"%@%@", kWSURLBase, @"catalog/search/category/%@/products?q=%@"]
#define kWSURLGetProductInfo [NSString stringWithFormat:@"%@%@", kWSURLBase, @"catalog/product/%@"]
#define kWSURLSearchProducts [NSString stringWithFormat:@"%@%@", kWSURLBase, @"catalog/search/products?q=%@"]
#define kWSURLAddToCart [NSString stringWithFormat:@"%@%@", kWSURLBase, @"cart/%@/?categoryId=%@"]
#define kWSURLCreateCart [NSString stringWithFormat:@"%@%@", kWSURLBase,@"cart"]
#define kWSURLGetCart [NSString stringWithFormat:@"%@%@", kWSURLBase, @"cart"]
#define kWSURLGetMediaList [NSString stringWithFormat:@"%@%@",kWSURLBase, @"catalog/product/%@/media"]

#endif