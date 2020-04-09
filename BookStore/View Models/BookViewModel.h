//
//  BookViewModel.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "BooksRepo.h"


NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel : NSObject
@property Book *book;

- (void) fetchBookByBookId:(NSString *) bookId sucessHandler:(void(^)(NSDictionary *data)) successHandler errorHandler:(void(^)(NSError *data)) errorHandler;

- (void) addBookToFavourites;

- (void) removeBookFromFavourites;

- (BOOL) isBookFavourite;


@end

NS_ASSUME_NONNULL_END
