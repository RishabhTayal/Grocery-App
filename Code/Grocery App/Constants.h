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

#define kWSURLBase @"http://sife-env.elasticbeanstalk.com/api/v1/"

#define kWSURLCategories @"catalog/categories"
#define kWSURLSearchProducts @"catalog/search/products"

#endif