Hi
SHDatabase is library written in Objective-C that lets you use sqlite database in convenient way.By using SHDatabase you’r no longer suppose to work with C library and function.Just drag and drop the SHDatabase and add “libsqlite3.0.dylib” to your project and your ready to take off.
The example project that might help you understand how does the SHDatabase works, is also available to you .
You can create a sqlite database in memory by using:

    SHDatabase *database = [SHDatabase createAndOpenDatabaseInMemory];
You can open (or copy and open if coping is needed) a pre loaded database from main bundle by using:

    SHDatabase *db = [SHDatabase openDatabaseInMainBundleWithName:@"MyDatabase" andExtention:@"db"];
or

    SHDatabase *db = [SHDatabase copyAndOpenDatabaseFromMainBundleWithName:@"MyDatabase" andExtention:@“db"];
You can also open a managed database!
A managed database is a database that SHDatabase handle the creating and opening for you, All you have to do is open it with just a name.
You can open a managed database by using:

    SHDatabase *db = [SHDatabase openOrCreateManagedDatabaseWithName:@"MyManagedDatabase" andInitBlock:^(SHDatabase *db) {
        // initialization code here
        
        //create your tables
        
        //add sample data
        
        //and ...
    }];

After Opening a database all you need to do is execute a command or query
