# PlateSlate
## Setup
1. ```mix deps.get```
2. ```mix ecto.setup```
3. ```mix phx.server```

## Usage
* ```GET http://localhost:4000/api?query={menuItems(matching: "reu"){name}}```
* ```POST http://localhost:4000/api  body: query=query($term:String){menuItems(matching: $term){name}} variable={"term":"reu"}```

## GraphQL
GraphQL is a query language that gives the users of an API the ability to describe the data that they want, and lets creators of the API focus on data relationships and business rules instead of worrying about the various data payloads the API needs to return.

### Problems with REST
As a client of this REST API, you have very limited control over what is returned. The contract between the client and the server is fairly one- sided: the client gets what the server wants to give it.

REST API authors attempting to address this problem use a number of differ- ent techniques and conventions:
* Writing detailed, custom documentation about API responses, so clients at least know what to expect
* Supporting query parameters (like include and fields) that act as flags to select information, adding some limited flexibility
* Including references (either IDs or URLs) to related data, rather than embedding it, effectively splitting the query across multiple requests
* Using different resources to model different levels of data inclusion (for example, /users/123 as a full set of data and /profiles/123 as a sparse set of data), duplicating or reusing large chunks of code
* Splitting the API completely, perhaps by platform (for instance, exposing /desktop/users/123 and /mobile/users/123), to support the needs of different types of clients
* Some combination of all of these

REST’s simplicity falls away pretty suddenly as the needs of clients become more varied and the surface area of the API expands.

### Exclamation Mark
An exclamation mark (!) denotes that, as the person writing the GraphQL query document, you’re making the variable mandatory. This is a handy tool on the client side, giving front-end developers the ability to enforce additional input constraints.

```
  query ($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name
    }
  }
```

### Non-Nullability
When the field for an input object is non-nullable — just as with arguments — validation will fail when a non-null value isn’t provided for that field. It’s different for normal (output) object fields. Declaring an output object field as non-nullable means that the schema will guarantee the field resolver’s result will always be non-null.

Non-nullability for input object fields means the client needs to provide a non-null value as part of the request. Non-nullability for output object fields means the server needs to provide a non- null value as part of the response.

### Fragments
Fragments are a way to write chunks of GraphQL that can target a specific type. E.g:
```
query Search($term: String!) {
  search(matching: $term) {
    ... on MenuItem {
      name
    }
    ... on Category {
      name
      items {
        name
      }
    }
  }
}
```

The ... is referred to as a 'fragment spread', and it inserts the inline fragment that follows. This is nomenclature you’ll also find in ECMAScript 6 objects, which isn’t surprising considering the number of JavaScript developers involved with the creation and maintenance of GraphQL.

Unions are about combinations of disparate types that might not have any fields in common, retrieving data from them requires us to use fragments (that target types) to get the data we want. There’s another option: interfaces.

Selecting fields that have been declared on the interface aren't subject to the same type of restrictions as selecting fields on unions, so no fragments are needed. If there are fields in common, interfaces allow users to write more simple, readable GraphQL.

## Elixir
### Anonymous Functions Multiple Bodies
An anonymous function can also have multiple bodies (as a result of pattern matching):
```
my_func = fn
  param1 -> do_this
  param2 -> do_that
end
```

### Capture Function
Capture means & can turn a function into an anonymous functions which can be passed as arguments to other function or be bound to a variable.
```
speak = &(IO.puts/1)
speak.("hello")  # hello
```

The capture operator can also be used to create anonymous functions, for example:
```
add_one = &(&1 + 1)
add_one.(1) # 2
```

# Upto

Page 81

First, we start the server
