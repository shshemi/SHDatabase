<h2>SHDatabase</h2><br/>
<h4>Sqlite Wrapper for Objective C</h4>
SHDatabase is library written in Objective-C that lets you use sqlite database in convenient way.By using SHDatabase you’r no longer suppose to work with C library.
<h3>Setup SHDatabase</h3>
Drag and drop the SHDatabase.
Add “libsqlite3.0.dylib” to your project.
Now your ready to take off!
<h3>Getting Started with Classes and Methods</h3>
The example project that might help you understand how does the SHDatabase works. Some method and simple examples are also available here:

<h3>In Memory Database</h3>
You can create a sqlite database in memory by using:

    SHDatabase *database = [SHDatabase createAndOpenDatabaseInMemory];
<h3>Pre Filled Database</h3>
You can open a pre filled database directly in main bundle by using:

    SHDatabase *db = [SHDatabase openDatabaseInMainBundleWithName:@"MyDatabase" andExtention:@"db"];
or you can use the following line to copy it to app directory and then open it:

    SHDatabase *db = [SHDatabase copyAndOpenDatabaseFromMainBundleWithName:@"MyDatabase" andExtention:@“db"];
<b>NOTE:</b> You cant change the database in main bundle, The main bundle directory is read only.
<h3>Managed Database</h3>
You can also try a managed database!<br/>
A Managed Database is a database that SHDatabase handles the creation and opening for you all the time and take all your focus to your applications logic, All you have to do is open it with just a name.
You can open a managed database by using:

    SHDatabase *db = [SHDatabase openOrCreateManagedDatabaseWithName:@"MyManagedDatabase" andInitBlock:^(SHDatabase *db) {
        // initialization code here
        
        //create your tables
        
        //add sample data
        
        //and ...
    }];
<h3>Command Execution</h3>
After Opening a database all you need to do is execute a command or query. Executing a query is just as simple as calling a function.you can execute a command(like creating a table or droping one) by using:

    [db execute:@"CREATE TABLE my_table (id integer PRIMARY KEY NOT NULL,name TEXT)"];
    
<h3>Query Execution</h3>
If you want to execute a query (like a sql select statment) you have to keep the result in an object with the type of  "ResultSet" like the following line :

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
<h3>Other ResultSet Features</h3>
You can get name of each column by using:

    NSString *columnName = [resultSet columnNameForColumnIndex:index];
You can get number of column by using:

    int columnCount = [resultSet columnCount];
Or just use columnCount property on ResultSet like this:

    int columnCount = resultSet.columnCount;
You can get the current row (record) dictionary by using:

    NSDictionary *dictionary = [resultSet dictionaryForCurrentRow];

Thanks for using <b>SHDatabase</b>
