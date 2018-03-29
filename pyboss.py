import os
import csv

#dict of abbrev https://gist.github.com/afhaque/29f0f4f37463c447770517a6c17d08f5
us_state_abbrev = {
    'Alabama': 'AL',
    'Alaska': 'AK',
    'Arizona': 'AZ',
    'Arkansas': 'AR',
    'California': 'CA',
    'Colorado': 'CO',
    'Connecticut': 'CT',
    'Delaware': 'DE',
    'Florida': 'FL',
    'Georgia': 'GA',
    'Hawaii': 'HI',
    'Idaho': 'ID',
    'Illinois': 'IL',
    'Indiana': 'IN',
    'Iowa': 'IA',
    'Kansas': 'KS',
    'Kentucky': 'KY',
    'Louisiana': 'LA',
    'Maine': 'ME',
    'Maryland': 'MD',
    'Massachusetts': 'MA',
    'Michigan': 'MI',
    'Minnesota': 'MN',
    'Mississippi': 'MS',
    'Missouri': 'MO',
    'Montana': 'MT',
    'Nebraska': 'NE',
    'Nevada': 'NV',
    'New Hampshire': 'NH',
    'New Jersey': 'NJ',
    'New Mexico': 'NM',
    'New York': 'NY',
    'North Carolina': 'NC',
    'North Dakota': 'ND',
    'Ohio': 'OH',
    'Oklahoma': 'OK',
    'Oregon': 'OR',
    'Pennsylvania': 'PA',
    'Rhode Island': 'RI',
    'South Carolina': 'SC',
    'South Dakota': 'SD',
    'Tennessee': 'TN',
    'Texas': 'TX',
    'Utah': 'UT',
    'Vermont': 'VT',
    'Virginia': 'VA',
    'Washington': 'WA',
    'West Virginia': 'WV',
    'Wisconsin': 'WI',
    'Wyoming': 'WY',
}

filepath = os.path.join("employee_data2.csv")

fempid = []
ffname = []
flname = []
fformatdob = []
fssn2 = []
fstateab = []

with open(filepath) as csvfile:
    reader = csv.reader(csvfile)
 
    next(reader)
    for row in reader:
            empid = row[0]
            name = row[1]
            dob = row[2]
            ssn = row[3]
            state = row[4]
        
            splitname = name.split()
            fname = splitname[0]
            lname = splitname[1]
        
            splitdob = dob.split ("-")
            year = splitdob[0]
            month = splitdob [1]
            day = splitdob [2]

            formatdob = day + "/" + month + "/" + year

        
            splitssn = ssn.split("-")
            ssn2 = "***-**-" + splitssn[2]

        
            stateab = us_state_abbrev.get(state)
        
            fempid.append(empid)
            ffname.append(fname)
            flname.append(lname)
            fformatdob.append(formatdob)
            fssn2.append(ssn2)
            fstateab.append(stateab)

    
cleanoutput = zip(fempid,ffname,flname,fformatdob,fssn2,fstateab)

outputpath = os.path.join("output.csv")
outputfile = open('output.csv', "w")
with open(outputpath, "w") as outputfile:
    fieldnames = ['Emp ID','First Name','Last Name','DOB','SSN','State']
    writer = csv.writer(outputfile)
    writer.writerow(fieldnames)
    writer.writerows(cleanoutput)