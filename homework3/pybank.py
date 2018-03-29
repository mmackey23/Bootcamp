import os
import csv

filepath = os.path.join("budget_data_2.csv")

revenuelist = []
monthlist = []

monthcount = 0
totalrevenue = 0.0
avgrevchange = 0.0
greatestrevinc = 0.0
greatestrevdec = 0.0



with open(filepath) as csvfile:
    reader = csv.reader(csvfile)
    next(reader)
    for row in reader:
        
        date = row[0]
        revenue = float(row[1])
        revenuelist.append(revenue)
        monthlist.append(date)
monthcount = len(monthlist)

totalrevenue = sum(revenuelist)

avgrevchange = round(float((max(revenuelist) - min(revenuelist)) / monthcount),2)


greatestrevinc = max(revenuelist)
greatestrevincmonth = monthlist[revenuelist.index(greatestrevinc)]

greatestrevdec = min(revenuelist)
greatestrevdecmonth = monthlist[revenuelist.index(greatestrevdec)]

pybankmsg = (
    f' Financial Analysis\n \
    ----------------------------\n \
    Total Months: {monthcount}\n \
    Total Revenue: $ {totalrevenue}\n \
    Average Revenue Change: $ {avgrevchange}\n \
    Greatest Increase in Revenue: {greatestrevincmonth} $ {greatestrevinc}\n \
    Greatest Decrease in Revenue: {greatestrevdecmonth} $ {greatestrevdec}\n \
    ')

#prints msg 
print(pybankmsg)

#define where the output is going
outputpath = os.path.join('output.txt')
#open output file to write
outputfile = open('output.txt',"w")

#write the message
outputfile.write(pybankmsg)