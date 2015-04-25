Hi
SHDatabase is library written in Objective-C that lets you use sqlite database in convenient way.By using SHDatabase you’r no longer suppose to work with C library.Just drag and drop the SHDatabase and add “libsqlite3.0.dylib” to your project and your ready to take off!
The example project that might help you understand how does the SHDatabase works, is also available to you .
You can create a sqlite database in memory by using:

    SHDatabase *database = [SHDatabase createAndOpenDatabaseInMemory];
You can open (or copy and open if coping is needed) a pre loaded database from main bundle by using:

    SHDatabase *db = [SHDatabase openDatabaseInMainBundleWithName:@"MyDatabase" andExtention:@"db"];
or

    SHDatabase *db = [SHDatabase copyAndOpenDatabaseFromMainBundleWithName:@"MyDatabase" andExtention:@“db"];
You can also open a managed database!
A managed database is a database that SHDatabase handles the creating and opening for you all the time and you can focus on your applications logic, All you have to do is open it with just a name.
You can open a managed database by using:

    SHDatabase *db = [SHDatabase openOrCreateManagedDatabaseWithName:@"MyManagedDatabase" andInitBlock:^(SHDatabase *db) {
        // initialization code here
        
        //create your tables
        
        //add sample data
        
        //and ...
    }];

After Opening a database all you need to do is execute a command or query. Executing a query is just as simple as calling a function.you can execute a command(like creating a table or droping one) by using:

    [db execute:@"CREATE TABLE my_table (id integer PRIMARY KEY NOT NULL,name TEXT)"];
If you want to execute a query(like a select statment) you have to store the result.You can store it in an object called ResultSet like this:

    SHResultSet *resultSet = [db execute:@"CREATE TABLE my_table (id integer PRIMARY KEY NOT NULL,name TEXT)"];
After that you can access the query result like this:

    while ([resultSet next]) {
        //code for fetching each column...
    }

You can access proper coulmn type like this:

    // String
    NSString *string = [resultSet stringForColumnIndex:index];
        
    // Integer
    int integer = [resultSet intForColumnIndex:index];
     
    // Long
    long long longInteger = [resultSet longForColumnIndex:index];
     
    // Double
    double decimal = [resultSet doubleForColumnIndex:index];
     
    // Blob
    NSData *data = [resultSet dataForColumnIndex:index];
     
    // id
    id unknownTyped = [resultSet valueForColumnIndex:index];
    
You can get name of each column by using:

    NSString *columnName = [resultSet columnNameForColumnIndex:index];
You can get number of column by using:

    int columnCount = [resultSet columnCount];
Or just use columnCount property on ResultSet

    int columnCount = resultSet.columnCount;
You can get the current row (record) dictionary by using:

    NSDictionary *dictionary = [resultSet dictionaryForCurrentRow];
You can use the dictionary to create json or pass to a server

Thanks for using SHDatabase
