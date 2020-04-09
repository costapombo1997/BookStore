//
//  BooksRepo.m
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "BooksRepo.h"

@implementation BooksRepo


+ (void)fetchByName:(NSString *) name sucessHandler:(void (^)(NSDictionary * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler{
     NSDictionary *params = @{ @"q":name};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://www.googleapis.com/books/v1/volumes" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        successHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error){
        errorHandler ?: errorHandler(error);
    }];
}



+ (void)FetchBookByBookId:(NSString *)bookId sucessHandler:(void (^)(NSDictionary * _Nonnull))successHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler{
    
    NSString *url = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes/%@",bookId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject){
        successHandler(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error){
        errorHandler ?: errorHandler(error);
    }];
}








+ (NSArray *)getFavourites{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSArray *favourites = [preferences objectForKey:@"favouriteBooks"];
    
    if(!favourites){
        favourites = [NSArray new];
    }
    
    return favourites;
}

+ (BOOL)addBookToFavourites:(Book *)book{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSArray *stored_favourites = [preferences objectForKey:@"favouriteBooks"];
    NSMutableArray *favourites = [NSMutableArray new];
    
    if(stored_favourites){
        [favourites addObjectsFromArray:stored_favourites];
    }
    
    // prevent duplication
    if ([self isFavourite:book.bookId]){
        return true;
    }
    
    [favourites addObject:book.bookId];

    [preferences setObject:favourites forKey:@"favouriteBooks"];
        
    //  Save to disk
    return  [preferences synchronize];
}





+ (BOOL)removeBookFromFavourites:(Book *)book{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    NSArray *favourites = [preferences objectForKey:@"favouriteBooks"];
    NSMutableArray *mutableFavourites = [NSMutableArray new];
    
    if(favourites){
        [mutableFavourites addObjectsFromArray:favourites];
    }
    [mutableFavourites removeObject:book.bookId];
    
        
    [preferences setObject:mutableFavourites forKey:@"favouriteBooks"];
    //  Save to disk
    return  [preferences synchronize];
}


+ (BOOL)isFavourite:(NSString *)bookId{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSArray *favourites = [preferences objectForKey:@"favouriteBooks"];
    return favourites && [favourites containsObject:bookId];
}


@end
