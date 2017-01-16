//
//  DAORodada.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "DAORodada.h"
#import "AppDelegate.h"

@implementation DAORodada

+(Rodada*)fetchRodadaWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allRodadas = [[NSFetchRequest alloc] init];
    [allRodadas setEntity:[NSEntityDescription entityForName:@"Rodada" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allRodadas setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allRodadas error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllRodadas
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allRodadas = [[NSFetchRequest alloc] init];
    [allRodadas setEntity:[NSEntityDescription entityForName:@"Rodada" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allRodadas error:&readError];
    
    return fetchArray;
}

+(NSArray*)fetchAllRodadasOrderedByDate
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allRodadas = [[NSFetchRequest alloc] init];
    [allRodadas setEntity:[NSEntityDescription entityForName:@"Rodada" inManagedObjectContext:context]];
    
    NSSortDescriptor*sort = [NSSortDescriptor sortDescriptorWithKey:@"dataFim" ascending:YES];
    
    [allRodadas setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allRodadas error:&readError];
    
    return fetchArray;
}

@end
