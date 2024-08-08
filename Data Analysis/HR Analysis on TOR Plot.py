import pandas as pd
import matplotlib.pyplot as plt

# Load the data
hr_file_path = 'path_to/HR.csv'
tags_file_path = 'path_to/tags.csv'
takeover_file_path = 'path_to/takeover_4578.csv'

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

# Plot
def plot_hr_analysis(time_values, hr_values, tags_time, takeover_events, brake_events, steering_events, time_tags):
    plt.figure(figsize=(15, 8))
    plt.plot(time_values, hr_values, color='blue', label='HR Data')

    # Marking the tags on the plot
    for tag_time in tags_time:
        plt.axvline(x=tag_time, color='orange', linestyle='--')

    # Highlighting the events with updated colors and adding dotted vertical lines
    plt.scatter(brake_events['time_minutes'], [max(hr_values)] * len(brake_events), color='red', label='Brake Reaction')
    for event_time in brake_events['time_minutes']:
        plt.axvline(x=event_time, color='red', linestyle=':')

    plt.scatter(steering_events['time_minutes'], [max(hr_values)] * len(steering_events), color='green', label='Steering Reaction')
    for event_time in steering_events['time_minutes']:
        plt.axvline(x=event_time, color='green', linestyle=':')

    # Highlighting takeover events with lavender purple color and 30% opacity
    lavender_purple = '#E6E6FA'
    for i, event_time in enumerate(takeover_events['time_minutes']):
        plt.axvspan(event_time - 0.5, event_time + 0.5, color=lavender_purple, alpha=0.3)
        if i % 10 == 0:  # Reduce the number of labels for performance
            plt.text(event_time - 2, max(hr_values) - 20, 'Takeover Request', rotation=90, verticalalignment='top', color='purple')

    # Adding custom time tag labels and lines in orange
    for minute, label in time_tags.items():
        plt.text(minute, 100, label, rotation=90, verticalalignment='bottom', color='orange', backgroundcolor='white')

    # Adding labels and legend
    plt.xlabel('Time (minutes)')
    plt.ylabel('Heart Rate')
    plt.title('Heart Rate Analysis based on TOR events')
    plt.legend()
    plt.grid(True)
    plt.show()

# Define custom time tags
time_tags = {20: "Start Scenario 1", 33: "Start Scenario 2", 51: "Start Scenario 3", 61: "Start Scenario 4", 0: "Start Trial Drive", 72: "End of Experiment"}

# Call the function with the appropriate data
plot_hr_analysis(time_values_minutes, hr_values, tags_time_minutes, takeover_events, brake_events, steering_events, time_tags)
