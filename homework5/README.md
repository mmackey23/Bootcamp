

```python
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns


city_file = 'raw_data/city_data.csv'
ride_file = 'raw_data/ride_data.csv'

city_df = pd.read_csv(city_file)
ride_df = pd.read_csv(ride_file)

city_data_df = city_df.copy()

ride_data_df = ride_df.copy()

city_ride_data = ride_data_df.groupby(ride_data_df['city'])

city_avg_fare = city_ride_data.mean().reset_index()

city_nbr_rides = city_ride_data.count().reset_index()

city_data_plus_avg_fare = pd.merge(city_data_df, city_avg_fare, on='city', how='left')

city_data_plus_avg_fare_renamed = city_data_plus_avg_fare.rename(columns={"fare": "average_fare"})

city_data_plus_avg_fare_work = city_data_plus_avg_fare_renamed[['city', 'driver_count', 'type', 'average_fare']]

city_data_plus_nbr_rides = pd.merge(city_data_plus_avg_fare_work, city_nbr_rides, on='city', how='left')

city_data_plus_nbr_rides_renamed = city_data_plus_nbr_rides.rename(columns={"ride_id": "nbr_rides"})

city_data_work = city_data_plus_nbr_rides_renamed[['city', 'driver_count', 'type', 'average_fare', 'nbr_rides']]

city_data_urban = city_data_work.loc[city_data_work['type'] == 'Urban']

city_data_suburban = city_data_work.loc[city_data_work['type'] == 'Suburban']

city_data_rural = city_data_work.loc[city_data_work['type'] == 'Rural']

sns.set()
fig = plt.figure(figsize=(10,10))
ax1 = fig.add_subplot(111)
ax2 = fig.add_subplot(111)
ax3 = fig.add_subplot(111)

ax1.scatter(city_data_urban['nbr_rides'],city_data_urban['average_fare'], 
                        (city_data_urban['driver_count']*5),facecolors='aquamarine', edgecolors='black', alpha=0.75,
                        label='Urban',linewidth=1.0)
ax2.scatter(city_data_suburban['nbr_rides'],city_data_suburban['average_fare'], 
                        (city_data_suburban['driver_count']*5),facecolors='forestgreen', edgecolors='black',
                        alpha=0.75,label='Suburban',linewidth=1.0)
ax3.scatter(city_data_rural['nbr_rides'],city_data_rural['average_fare'], 
                        (city_data_rural['driver_count']*5),facecolors='maroon', edgecolors='black',
                        alpha=0.75,label='Rural',linewidth=1.0)

textstr = 'Note:\nCircle size correlates with driver count per city'
plt.xlabel('Total Number of Rides (Per City)')
plt.ylabel('Average Fare ($)')
plt.title('Pyber Ride Sharing Data (2016)')
plt.figtext(.95, .60, textstr)
lgnd = plt.legend(loc='best', title = 'City Types')
for handle in lgnd.legendHandles:
    handle.set_sizes([30.0])
    
plt.show()
```
