# Dynamic Alert Design Based on Driver’s Cognitive State for Take-over Request in Automated Vehicles


<p align="center">
  <img src="images\Dashboard-Overall.PNG" alt="Overall Dashboard Design" style="width: 540px">
</p>

---


## About the Research
**Master's Research Project - University of Waterloo**

This project explores innovative approaches in the domains of Human Factors Engineering, Advanced Driver Assistance Systems (ADAS), and Human-Machine Interface (HMI) with a focus on enhancing road safety for autonomous driving. The research involved developing a dynamic alert system that adapts to drivers' cognitive states, aimed at improving their readiness and effectiveness during takeover requests (TOR) in semi-autonomous vehicles. The study utilized advanced driving simulation technologies and comprehensive user research to evaluate the effectiveness of these dynamic alerts.

---

## Research Problem

In semi-autonomous vehicles, the transition of control from the vehicle to the human driver, especially during critical situations, is a significant challenge. Traditional alert systems are typically static, delivering the same type of alert regardless of the driver’s current cognitive load or distraction level. This can lead to delayed or inappropriate responses, reducing the effectiveness of the takeover process and potentially compromising safety. The research sought to address the challenge of designing an adaptive alert system that responds to the driver’s cognitive state, thereby enhancing their ability to take over control of the vehicle in a timely and effective manner.

---

## Methodology

### Human Factors and Tools

- **Participants:** The study recruited 40 participants, aged 18 to 54, with at least one year of driving experience. The experiments were conducted in the Autonomous Vehicle Research and Intelligence Laboratory (AVRIL) at the University of Waterloo. Participants were exposed to a variety of driving scenarios to assess their responses to different alert systems.
- **Driving Simulator:** The primary experimental tool was VI-Grade’s high-fidelity STATIC driving simulator, designed to replicate real-world driving conditions with precision. This simulator was integrated with MATLAB Simulink for ADAS control models, and VI-WorldSim was used to create diverse driving scenarios that reflected realistic road conditions.

<p align="center">
  <img src="images\Simulink AutoPilot Model.png" alt="Simulink AutoPilot Model" style="width: 540px">
</p>

- **UI/UX Design:** The alert system and driver dashboard were designed using Figma for prototyping and Qt QML for implementation. The design focused on intuitive user interfaces that could effectively communicate alerts and other critical information to the driver, improving their situational awareness and response time.

- **Mixed-Methods Research:** The research employed a combination of qualitative and quantitative methods to gather comprehensive data. This included:
  - **Physiological Measurements:** Heart rate monitoring and eye tracking were used to assess the physiological impact of different alert systems on the driver.
  - **Behavioral Analysis:** Video recordings and log data were analyzed to observe drivers' behaviors, including their gaze direction, reaction times, and steering maneuvers.
  - **Post-Scenario Questionnaires:** Participants completed surveys after each scenario to capture subjective experiences, including perceived stress, alert effectiveness, and overall user satisfaction.

### Experimental Setup
<p align="center">
  <img src="images\DriveSimCockpit.png" alt="Cockpit View" style="width: 540px">
  <img src="images\Dash and Spectator.png" alt="Spectator View" style="width: 540px">
</p>

- **Driving Scenarios:** Four distinct driving scenarios were designed to test the effectiveness of the alert systems under varying conditions. These scenarios included:
  - **Road Closure Scenario:** Drivers encountered unexpected road closures requiring immediate rerouting.
  - **Sudden Obstacle Scenario:** An unexpected obstacle, such as an animal crossing the road, required immediate driver intervention.
  - **Merging Vehicle Scenario:** A vehicle suddenly merged into the driver’s lane, demanding quick evasive action.
  - **Distracted Driving Scenario:** Participants were engaged in a secondary task (typing on a smartphone) to simulate a distracted driving condition during which a takeover request was issued.
- **Alert Design:** The study compared two types of alerts:
<p align="center">
  <img src="images\Dashboard-Takeover-Strong-Red.PNG" alt="Dashboard Driver Alert" style="width: 540px">
</p>

  - **Static Alerts:** A single, consistent alert was delivered regardless of the driver’s cognitive state.
  - **Dynamic Alerts:** Alerts varied in intensity and modality (visual and auditory) based on real-time assessments of the driver’s cognitive load, such as distraction levels or engagement with secondary tasks.
- **Cognitive States:** The research classified cognitive states into two categories:
  - **Focused Attention:** The driver was fully attentive to the driving task with no secondary distractions.
  - **Distracted State:** The driver was engaged in a secondary task, such as using a smartphone, leading to increased cognitive load and reduced attention to the driving task.

---

## Research Results

The results demonstrated that dynamic alert systems significantly improve takeover performance, particularly in scenarios where drivers are distracted or cognitively overloaded. Key findings include:

- **Response Time:** Dynamic alerts led to a reduction in average response times by approximately 1.75 seconds compared to static alerts, particularly in scenarios involving high cognitive load.
- **Driver Confidence:** Participants expressed higher levels of confidence in their ability to respond to dynamic alerts, with reported confidence levels increasing by 20% in high-distraction scenarios.
- **Alert Effectiveness:** Dynamic alerts were more effective in capturing the driver’s attention without causing undue stress or annoyance. High attention-capturing scores were consistently paired with low annoyance ratings, indicating that the dynamic alerts were well-tuned to the drivers' needs.
- **Physiological Impact:** The study observed a correlation between the intensity of dynamic alerts and physiological responses, such as increased heart rate and galvanic skin response, indicating heightened readiness and alertness. Additionally, more decisive steering and braking actions were recorded under dynamic alert conditions, suggesting a more effective takeover process.
- **Behavioral Outcomes:** Dynamic alerts resulted in fewer erratic maneuvers and smoother transitions from automated to manual control, reducing the likelihood of secondary incidents post-takeover.


---

## Future Work

The promising results of this research suggest several avenues for future exploration:

- **Real-World Testing:** While the current study was conducted in a controlled simulated environment, future research should aim to validate these findings in real-world driving conditions, where variables such as road conditions, weather, and traffic may impact the effectiveness of dynamic alert systems.
- **Broader Alert Modalities:** Future research could explore the integration of additional alert modalities, such as haptic feedback (e.g., vibrating seats or steering wheels) and more sophisticated auditory cues, to further enhance the alert system’s effectiveness.
- **Refinement of Physiological Monitoring:** Improving the real-time monitoring and assessment of physiological markers, such as EEG-based cognitive load detection, could provide even more accurate and responsive dynamic alerts tailored to the driver’s current state.
- **Adaptive Learning Systems:** Developing adaptive systems that learn from individual driver behaviors over time could allow for even more personalized and effective alert mechanisms. These systems could adjust alert thresholds and modalities based on the driver’s historical performance data and real-time cognitive state assessments.

---

## Related Skills and Experience

- **Human Factors Engineering:** Applied principles of human factors to design a user-centric HMI for autonomous vehicles, focusing on enhancing driver safety and performance during critical takeover scenarios.
- **Mixed-Methods User Research:** Conducted comprehensive user research involving both qualitative and quantitative methods to assess system performance, user experience, and physiological impacts.
- **UI/UX Design:** Developed intuitive and responsive driver dashboards and alert systems using Figma and Qt QML, focusing on optimizing user engagement, safety, and ease of use.
- **Autonomous Driving & ADAS Development:** Leveraged VI-Grade’s simulation tools, including VI-DriveSim and SIMulation Workbench, as well as MATLAB Simulink, for the development and testing of ADAS control models in high-fidelity driving scenarios.

---

## Teaching Experience

- **Teaching Assistant - Cognitive Ergonomics (Fall 2023):** Assisted in teaching cognitive ergonomics, focusing on the application of human factors principles in the design and evaluation of automated systems.
- **Lab Instructor - Application of Driving Simulators to Driving Safety (Winter 2024):** Instructed 15 students on using VI-Grade’s driving simulator for their term projects, emphasizing the application of simulation tools in driving safety research and human-machine interface design.

---

## Contact Information

For more details about this research or to discuss potential collaborations, please reach out via [Email](mailto:petewachi@outlook.com) or connect with me on [LinkedIn](https://www.linkedin.com/in/umpaipantw).
