//
//  BooksRepo.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface BooksRepo : NSObject

+ (void) fetchByName:(NSString *) NAME sucessHandler:(void(^)(NSDictionary *data)) successHandler errorHandler:(void(^)(NSError *data)) errorHandler;
+ (void) FetchBookByBookId:(NSString *) bookId sucessHandler:(void (^)(NSDictionary * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler;


+ (NSArray *) getFavourites;

+(BOOL) addBookToFavourites:(Book *) book;

+ (BOOL) removeBookFromFavourites:(Book *)book;


+ (BOOL) isFavourite: (NSString *) bookId;

@end


NS_ASSUME_NONNULL_END
