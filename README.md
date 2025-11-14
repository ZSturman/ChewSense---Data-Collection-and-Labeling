Chew Sense - Data Collection and Labeling

This app records synchronized AirPods motion data and video for research, prototyping, and dataset creation. It is designed to support workflows focused on chewing-related motion analysis but can be used for any task requiring aligned video and AirPods motion samples.

Features
	•	Automatic AirPods connection
The app connects to supported AirPods motion sensors on launch. Recording is only enabled when motion data is actively available.
	•	Synchronized recording
Each session stores a .mov video file and a .csv motion-data file in a single folder. Timestamps ensure alignment between modalities.
	•	Optional labeling workflow
Recordings may be exported immediately when started in “Not eating” mode.
If labeling is needed, the detail view supports playback, marker placement, and segment-based boolean labels. Segments between markers are labeled true; all others are false.
	•	Connection-loss protection
The app automatically pauses recording if the AirPods connection drops, preventing incomplete or misaligned datasets.

Data Format
	•	Video: recording.mov
	•	Motion data: motion.csv with timestamped sensor rows
	•	Labels: Stored as boolean values aligned to motion-data segments

Exporting

Recordings can be exported or shared as a folder containing both files. This simplifies downstream processing and machine-learning dataset assembly.

Intended Use

This tool is intended for technical users who require clean, consistent, and synchronized motion/video data. It is not intended as a consumer chewing-monitoring or health-tracking product.
