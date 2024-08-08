import pandas as pd

# Define function to calculate average heart rate for a given time period
def calculate_average_hr(hr_values, start_time, end_time, frequency_hz):
    start_index = int(start_time * frequency_hz * 60)
    end_index = int(end_time * frequency_hz * 60)
    return hr_values[start_index:end_index].mean()

# Load the data
path ='C:/Users\Work\OneDrive - University of Waterloo/Research/Project/Experiment/Data Collection/DataAnalysis/Export/4578'
hr_file_path = path+'/HR.csv'
tags_file_path = path+'/tags.csv'
takeover_file_path = path+'/takeover_4578.csv'

hr_data = pd.read_csv(hr_file_path, header=None)
tags_data = pd.read_csv(tags_file_path)
takeover_data = pd.read_csv(takeover_file_path)

# Extracting start time and frequency
start_time_unix = hr_data.iloc[0, 0]
frequency_hz = hr_data.iloc[1, 0]

# Extracting HR data
hr_values = hr_data.iloc[2:, 0].astype(float).reset_index(drop=True)
time_values_minutes = (hr_values.index / frequency_hz) / 60

# Converting tags time to minutes
tags_time_unix = tags_data.iloc[:, 0]
tags_time_minutes = (tags_time_unix - start_time_unix) / 60

# Convert date_time to minutes for takeover data
takeover_data['time_minutes'] = (takeover_data['date_time'] - start_time_unix) / 60

# Separate the events where ADAS.Outputs.Generic.Takeover, brake.reaction_detected, and steering.reaction_detected are not 0
takeover_events = takeover_data[takeover_data['ADAS.Outputs.Generic.Takeover'] != 0]
brake_events = takeover_data[takeover_data['brake.reaction_detected'] != 0]
steering_events = takeover_data[takeover_data['steering.reaction_detected'] != 0]

# Define custom time tags
time_tags = {20: "Start Scenario 1", 33: "Start Scenario 2", 51: "Start Scenario 3", 61: "Start Scenario 4", 0: "Start Trial Drive", 72: "End of Experiment"}

# Calculate average heart rate for each scenario and takeover
results = []
for minute, label in time_tags.items():
    if 'Start Scenario' in label:
        # Start of scenario to start of takeover
        scenario_start = minute
        next_takeover_event = takeover_events['time_minutes'][takeover_events['time_minutes'] > scenario_start].iloc[0]
        average_hr_scenario = calculate_average_hr(hr_values, scenario_start, next_takeover_event, frequency_hz)
        
        # 8 seconds average during takeover
        average_hr_takeover = calculate_average_hr(hr_values, next_takeover_event, next_takeover_event + 8/60, frequency_hz)
        
        # 1 minute average after takeover
        average_hr_after_takeover = calculate_average_hr(hr_values, next_takeover_event + 8/60, next_takeover_event + 68/60, frequency_hz)
        
        # Calculate percentage increase during takeover and after takeover
        percentage_increase_takeover = ((average_hr_takeover - average_hr_scenario) / average_hr_scenario) * 100
        percentage_increase_after_takeover = ((average_hr_after_takeover - average_hr_scenario) / average_hr_scenario) * 100
        
        results.append((label, average_hr_scenario, average_hr_takeover, average_hr_after_takeover, percentage_increase_takeover, percentage_increase_after_takeover))

# Convert results to DataFrame for better visualization
results_df = pd.DataFrame(results, columns=['Scenario', 'Avg HR Before Takeover', 'Avg HR During Takeover', 'Avg HR After Takeover', 'Percentage Increase During Takeover', 'Percentage Increase After Takeover'])

# Display the results
print(results_df)
