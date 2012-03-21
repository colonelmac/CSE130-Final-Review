# Problem 3
# 
# Decorates each call to the function
# 
#

# Function decorator
def print_first_k_args_fn(k):
    def g(f):
        def h(*args, **kwargs):
            for i, arg in enumerate(args):
                if i == k: break
                print "Arg %d: %s" % (i+1, arg)     
            ret = f(*args, **kwargs)
            print "Return: %d" % (ret)
            return ret
        return h    
    return g
        
# Class decorator
class print_first_k_args_c(object):
    def __init__(self, k):
        self.k = k

    def __call__(self, f):
        def wrapper(*args, **kwargs):
            for i, arg in enumerate(args):
                if i == self.k: break
                print "Arg %d: %s" % (i+1, arg)     
            ret = f(*args, **kwargs)
            print "Return: %d" % (ret)
            return ret
        return wrapper


@print_first_k_args_fn(1)
def sum(a, b): return a + b

sum(5, 4)

@print_first_k_args_c(1)
def fac(n):
    if n <= 0: return 1
    else: return n * fac(n - 1)

fac(3)
