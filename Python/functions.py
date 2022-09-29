def reverse_string(string1):
    rev_str = string1.split()[::-1]
    str_list = []
    for i in rev_str:
        str_list.append(i)
    return(" ".join(str_list))

# reverse_string("Hi My name is")