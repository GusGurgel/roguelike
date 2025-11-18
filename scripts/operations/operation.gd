extends Resource
class_name Operation
## Represents a fallible operation with a "error" and "error_message".
##
## By convention, every resource that's inherit Operation has a
## data attribute as the result of the operation.

var error: Error = OK
var error_message: String = ""
