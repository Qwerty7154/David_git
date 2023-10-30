#!/usr/bin/python3

                                            '''SOLUTION'''
'''The function "valid_password" is defined to check the password'''
def valid_password(password):
    '''The special_character variable is made as a list to store all the sspecial characters'''
    special_character = ["$","#","@","_","&","%"]
    '''The empty string "letters" is created to store all the alphabets in the password'''
    letters = ""
    '''Empty list for lowercase, uppercase, numbers and special characters are made to store the corresponding
    elements from the password'''
    lowercase = []
    uppercase = []
    numbers = []
    special = []
    '''This "if" statement returns the password statement if the password is not between 6 - 12 characters long '''
    if not 5 < len(password) < 13:
        return "The password must have between 6 - 12 characters."
    '''The "for" loop statement goes through the individual characters of the password'''
    for character in password:
        '''This conditional stores all alphabets in the passsword into the empty string "letters"'''
        if character.isalpha():
            letters += character
        '''This conditional stores all numbers in the passsword into the empty list "numbers"'''
        if character.isnumeric():
            numbers.append(character)
        '''This conditional stores all special characters in the passsword into the empty list "special" 
        by comparing them to the stored special_characters list'''
        if character in special_character:
            special.append(character)
        '''This conditional stores all uppercased alphabets in the passsword into the empty list "uppercase"'''
        if character in letters.upper():
            uppercase.append(character)
        '''This conditional stores all lowercased alphabets in the passsword into the empty list "lowercase"'''
        if character in letters.lower():
            lowercase.append(character)
    '''This conditional returns a negative message if any of the list below is empty and a positive message 
    if they are all filled'''
    if lowercase == [] or uppercase == [] or numbers == [] or special == []:
        return "The password does not meet all the requirements."
    else:
        return "Password accepted!"
    

