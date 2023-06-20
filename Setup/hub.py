# python shell hub
# Lloyd W Jones III
import os
x= True
ylist = ['y','Y','yes','Yes']
while x == True:
## User inputs for the command line scripts 
    user1 = input('Please enter the name of your project, no spaces or special characters allowed: ')
    user2 = input('Please enter the Project ID you are using for data: ')
    user3 = input('Please input your reference genomes taxon id, numbers only no spaces: ')
    try:
        os.system(f'sh R03.sh {user1} {user2} {user3}') # search function
        try:
            os.system(f'sh R04.sh {user1} {user2} {user3}') # trimmomatic function
            try:
               os.system(f'sh R05.sh {user1} {user2} {user3}') # variant calling function
            except:
                print('error when trying to run variant detection')
                user3 = input('Would you like to try an additional search?[y/n]')
                if user3 in ylist:
                    continue
                else:
                    exit
                continue   
        except:
            print('error when trying to run trimmomatic, make sure your files are paired end')
            user3 = input('Would you like to try an additional search?[y/n]')
            if user3 in ylist:
                continue
            else:
                exit
            continue
    except:
        print('You have input an Invalid Project Name or Project ID')
        user3 = input('Would you like to try an additional search?[y/n]')
        if user3 in ylist:
            continue
        else:
            exit
        continue
         