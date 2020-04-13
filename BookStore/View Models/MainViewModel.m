//
//  MainViewModel.m
//  BookStore
//
//  Created by Pedro Costa on 09/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "MainViewModel.h"
#import "Book.h"
#import "BooksRepo.h"
@implementation MainViewModel{
    
}


- (void)fetchBookByBookId:(NSString *)bookId sucessHandler:(void (^)(Book * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler{
    
    [BooksRepo FetchBookByBookId:bookId sucessHandler:^(NSDictionary *rawBookData){
        NSDictionary *volumeInfo = [rawBookData valueForKey:@"volumeInfo"];
        Book *book = [Book new];
        book.bookId = [rawBookData valueForKey:@"id"];
        book.name = [volumeInfo valueForKey:@"title"];
        book.publishedDate = [volumeInfo valueForKey:@"publishedDate"];
        book.coverImageURL = [[volumeInfo valueForKey:@"imageLinks"] valueForKey:@"thumbnail"];

        
        successHandler(book);
    } errorHandler:^(NSError *error){
        errorHandler(error);
    }];
}


- (void) update{
            
    NSMutableArray *books = [NSMutableArray new];
    BOOL exists;
    NSArray *favourites =  [BooksRepo getFavourites];
    for (NSString *bookId in favourites) {
        exists = NO;
                       
        for (Book *storedBook in self.books) {
            if([storedBook.bookId isEqualToString:bookId]){
                [books addObject:storedBook];
                exists = YES;
                break;
            }
        }
        
        if(!exists){
            Book *book = [Book new];
            book.bookId = bookId;
            [books addObject:book];
        }
        

    }
    self.books = books;
}





@end
