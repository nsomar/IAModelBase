IAModelBase
================

Object modeling class for Objective c
IAModelBase will help you with your NSDictionary to object modeling problems.

If you have an NSDictionary with nested Arrays and Dictionaries, you can easily model them to your own classes and arrays.

<b>Example 1 simple class with no dictionaries and arrays:</b>
================
Your dictionary looks like

    dic =
        {
           "key1" = "val1",
           "key2" = "val2",
           "key3" = "val3",
           "id" = "some id";
        }

First create a subclass of IAModalBase and add the properties to it
The names of the properties has to match the name of keys in the dictionary

    @interface YourClass : IAModelBase
    @property (nonatomic, strong) NSString *key1;
    @property (nonatomic, strong) NSString *key2;
    @property (nonatomic, strong) NSString *key3;
    @property (nonatomic, strong) NSString *exID;
    @end
    
In case you have a property that is not equal to the key of the dictionay (such as id in the example)
You will have to override propertiesToDictionaryEntriesMapping from IAModelBase:

    - (NSDictionary *)propertiesToDictionaryEntriesMapping
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"exID", @"id", //correct name of the property, name in dictionary
                nil];
    }
Where exID is the name of the property in your class, and id is the key in the dictionary
At runtime IAModelBase will match id and set its value to exID property
    
Now ti fill initialize this class with the dictionary:

    YourClass *obj = [[YourClass alloc] initWithDictionary:dic];
    
<b>Example 2 class with a dictionary:</b>
================
Your dictionary looks like

    dic =
        {
           "key" = "val1",
           "keyForSubClass" = 
                   {
                        "subKey1" = "val1",
                        "subKey2" = "val2",
                   }
        }

Create a subclass of IAModalBase and add the properties to it
The names of the properties has to match the name of keys in the dictionary
For the inner dictionary you will create another Class extending IAModalBase

    @interface YourMainClass : IAModelBase
    @property (nonatomic, strong) NSString *key;
    @property (nonatomic, strong) YourSecondClass *keyForSubClass;
    @end
    
And for the second class

    @interface YourSecondClass : IAModelBase
    @property (nonatomic, strong) NSString *subKey1;
    @property (nonatomic, strong) NSString *subKey2;
    @end
    
    
Now ti fill initialize this class with the dictionary:

    YourMainClass *obj = [[YourMainClass alloc] initWithDictionary:dic];
At runtime the IAModelClass will fill both the classes

<b>Example 3 class with an array:</b>
================
Here you have an array within your dictionary
You will have to create an a model class for the objects in the array
we will call this class MyArrayObject
Your dictionary looks like

    dic =
        {
           "key" = "val1",
           "myArrayObject" = 
                   [
                        {
                            "subKey1" = "val1",
                            "subKey2" = "val2",
                        }
                   ]
        }

Create a subclass of IAModalBase and add the properties to it
The names of the properties has to match the name of keys in the dictionary

For the array, you will create a property of type NSArray,
The name of this property its important, it has to follow a naming convention


    @interface YourMainClass : IAModelBase
    @property (nonatomic, strong) NSString *key;
    @property (nonatomic, strong) NSArray *myArrayObjectCollection;
    @end
    
Also override 

    - (NSDictionary *)propertiesToDictionaryEntriesMapping
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"myArrayObjectCollection", @"myArrayObject", //correct name of the property, name in dictionary
                nil];
    }
Where myArrayObjectCollection is the name of the property and myArrayObject is the name of the key in the dictionary
    
And for the second class

    @interface MyArrayObject : IAModelBase
    @property (nonatomic, strong) NSString *subKey1;
    @property (nonatomic, strong) NSString *subKey2;
    @end
    
    
Now ti fill initialize this class with the dictionary:

    YourMainClass *obj = [[YourMainClass alloc] initWithDictionary:dic];
At runtime IAModelBase uses introspection to fill in the array objects
It dose this by following a set of rules

1. it reads the name of the property, and it checks if it contains any of the following words

    "Array", @"Items", @"List", @"Collection"
2. if it found any of this words, it will remove them, so myArrayObjectCollection will become myArrayObject
3. It then capitalize the first letter so myArrayObject will become MyArrayObject
4. It looks at the runtime for a class named MyArrayObject
5. since we have this class IAModelBase will initialize an object of MyArrayObject for
each entry of the dictionary

The result will be that YourMainClass will be filled with all the values of the dictionary
And the property
    NSArray *myArrayObjectCollection;
Will contain an array of MyArrayObject class that we defined

