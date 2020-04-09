//
//  Book.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
@property NSString *bookId;
@property NSString *name;
// string because sometimes date is incomplete
@property NSString   *publishedDate;
@property NSString *coverImageURL;
@property UIImage  *coverImage;
@property NSString *description;
@property NSArray  *authors;
@property NSString *buyLink;
@end

NS_ASSUME_NONNULL_END
