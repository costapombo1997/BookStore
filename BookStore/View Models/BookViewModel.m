//
//  BookViewModel.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "BookViewModel.h"

@implementation BookViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.book = [Book new];
    }
    return self;
}



- (void)fetchBookByBookId:(NSString *)bookId sucessHandler:(void (^)(NSDictionary * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler{
    
    [BooksRepo FetchBookByBookId:bookId sucessHandler:^(NSDictionary *rawBookData){
         
        NSDictionary *volumeInfo = [rawBookData valueForKey:@"volumeInfo"];
        self.book.bookId = [rawBookData valueForKey:@"id"];
        self.book.name = [volumeInfo valueForKey:@"title"];
        self.book.publishedDate = [volumeInfo valueForKey:@"publishedDate"];
        self.book.coverImageURL = [[volumeInfo valueForKey:@"imageLinks"] valueForKey:@"thumbnail"];
        self.book.description = [volumeInfo valueForKey:@"description"];
        self.book.buyLink = [[rawBookData valueForKey:@"saleInfo"] valueForKey:@"buyLink"];
        successHandler(rawBookData);
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
    
}


- (void)addBookToFavourites{
    [BooksRepo addBookToFavourites:self.book];
}


- (void)removeBookFromFavourites{
    [BooksRepo removeBookFromFavourites:self.book];
}


- (BOOL)isBookFavourite{
    return [BooksRepo isFavourite:self.book.bookId];
}


@end
