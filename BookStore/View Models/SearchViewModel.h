//
//  SearchViewModel.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewModel : NSObject
@property NSMutableArray *books;


- (void) clear;

- (void) fetchListByName:(NSString *) name sucessHandler:(void(^)(NSMutableArray *data)) successHandler errorHandler:(void(^)(NSError *data)) errorHandler;


@end

NS_ASSUME_NONNULL_END
