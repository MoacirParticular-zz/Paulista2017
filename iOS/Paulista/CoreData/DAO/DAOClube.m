//
//  DAOClube.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "DAOClube.h"
#import "AppDelegate.h"

@implementation DAOClube


+(void)parseAndInsertObjectsWithJson:(NSDictionary *)json
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSMutableArray *cidadesArray = [json objectForKey:@"Clubes"];
    
    for (NSMutableDictionary *clubeDict in cidadesArray) {
        Clube *fetchedClube = [DAOClube fetchClubeWithCode:[[clubeDict objectForKey:@"codigo"] intValue]];
                               
        if (fetchedClube == nil) {
            Clube * clube = [NSEntityDescription insertNewObjectForEntityForName:@"Clube" inManagedObjectContext:context];
            clube.codigo = [NSNumber numberWithInteger:[[clubeDict objectForKey:@"codigo"] integerValue]];
            clube.nome = [clubeDict objectForKey:@"nome"];
            clube.escudo = [clubeDict objectForKey:@"escudo"];
            clube.sigla = [clubeDict objectForKey:@"sigla"];
            clube.grupo = [clubeDict objectForKey:@"dsgrupo"];
        }
        else
        {
            fetchedClube.nome = [clubeDict objectForKey:@"nome"];
            fetchedClube.escudo = [clubeDict objectForKey:@"escudo"];
            fetchedClube.sigla = [clubeDict objectForKey:@"sigla"];
            fetchedClube.grupo = [clubeDict objectForKey:@"dsgrupo"];
        }
    }
    
    NSError *saveError;
    
    [context save:&saveError];
}

+(Clube*)fetchClubeWithCode:(int)codigo;
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allClubes = [[NSFetchRequest alloc] init];
    [allClubes setEntity:[NSEntityDescription entityForName:@"Clube" inManagedObjectContext:context]];
    
    NSError * readError = nil;
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"codigo == %i", codigo];
    [allClubes setPredicate:predicate];
    
    NSArray *fetchArray = [context executeFetchRequest:allClubes error:&readError];
    
    if (fetchArray.count > 0) {
        return [fetchArray objectAtIndex:0];
    }
    else
    {
        return nil;
    }
}

+(NSArray*)fetchAllClubes
{
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate] ;
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest * allClubes = [[NSFetchRequest alloc] init];
    [allClubes setEntity:[NSEntityDescription entityForName:@"Clube" inManagedObjectContext:context]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
    [allClubes setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError * readError = nil;
    
    NSArray *fetchArray = [context executeFetchRequest:allClubes error:&readError];
    
    return fetchArray;
}

@end
