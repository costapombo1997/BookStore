//
//  MainViewModel.h
//  BookStore
//
//  Created by Pedro Costa on 09/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewModel : NSObject

@property NSArray *books;


- (void) fetchBookByBookId:(NSString *) bookId sucessHandler:(void(^)(Book *data)) successHandler errorHandler:(void(^)(NSError *data)) errorHandler;

- (void) update;

@end

NS_ASSUME_NONNULL_END
