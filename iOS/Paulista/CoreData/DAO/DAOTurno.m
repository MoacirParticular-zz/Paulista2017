//
//  DAOTurno.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "DAOTurno.h"
#import "AppDelegate.h"

@implementation DAOTurno


+(Turno*)fetchTurnoWithCode:(int)codigo
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allTurno = [[NSFetchRequest alloc] init];
    [allTurno setEntity:[NSEntityDescription entityForName:@"Turno" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allTurno setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allTurno error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllTurno
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allTurno = [[NSFetchRequest alloc] init];
    [allTurno setEntity:[NSEntityDescription entityForName:@"Turno" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allTurno error:&readError];
    
    return fetchArray;
}

@end
