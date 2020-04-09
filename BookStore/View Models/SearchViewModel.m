//
//  SearchViewModel.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "SearchViewModel.h"
#import "BooksRepo.h"
#import "Book.h"

@implementation SearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self clear];
    }
    return self;
}


- (void)clear{
    self.books = [NSMutableArray new];
}



- (void)fetchListByName:(NSString *)name sucessHandler:(void (^)(NSMutableArray * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler{
    
    [BooksRepo fetchByName:name sucessHandler:^(NSDictionary *data){
        data = [data valueForKey:@"items"];
        for (NSDictionary *bookData in data) {
            NSDictionary *volInfo = [bookData objectForKey:@"volumeInfo"];
            
            Book *book = [Book new];
            book.bookId = [bookData objectForKey:@"id"];
            book.name = [volInfo objectForKey:@"title"];
            book.coverImageURL = [[volInfo objectForKey:@"imageLinks"] objectForKey:@"thumbnail"];
            book.publishedDate = [volInfo objectForKey:@"publishedDate"];
            [self.books addObject:book];
        }
        successHandler(self.books);
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
    
}



@end
