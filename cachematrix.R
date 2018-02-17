##The first function looks for cached data and the second computed inverse of the matrix by R function named solve()
## functions do

  makeCacheMatrix <- function(m = matrix()) {
    inv <- NULL
    set <- function(n) {
      m <<- n
      inv <<- NULL
    }
    get <- function() m
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set = set,
         get = get,
         setinverse = setinverse,
         getinverse = getinverse)
  }

## This part checks if there is already an unverse of the matrix residing in the memory
  
  cacheSolve <- function(m, ...) {
    inv <- m$getinverse()
    if (!is.null(inv)) {
      message("Fetching data from cache")
      return(inv)
    }
    mat <- m$get()
    inv <- solve(mat, ...) ## This function solves the matrix, it could take many other arguments based on complexity of the matrix
    m$setinverse(inv)
    inv
  }
## Pass any vector to form a matrix noting also whether the formed matrix could be invertible: 
  Z <- matrix(c(10,20,30,40),2,2)
  ma<-makeCacheMatrix(Z)
  cacheSolve(ma)
